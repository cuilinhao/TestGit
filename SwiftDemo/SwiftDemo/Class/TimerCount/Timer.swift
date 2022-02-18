//
//  Timer.swift
//  SwiftDemo
//

import Foundation
import Combine

/// 使用系统递增时间计时的倒计时器。调用者可以手动获取 ``timeRemaining`` 或订阅倒计时器等待 Combine 发布。
///
/// 作为 Combine 发布者，倒计时器发布原始剩余时间（单位：秒）和本地化字符串。受限于系统内部调度，原始剩余时间（``timeRemaining``
/// 属性和 Combine 发布的值）可能不是整数秒。如果调用者需要保存、传输或格式化原始时间，请自行修约（四舍五入），**请勿直接转换为整数**。
///
/// 此倒计时器使用 `CLOCK_MONOTONIC_RAW` 获取系统内部稳定递增时间，不使用当前日历时间计时，因此不受以下事件影响：
///
/// - 用户调整设备时间、时区；
/// - NTP 时间同步，例如：闰秒；
/// - 夏令时等自动时区切换；
/// - 线程暂停、恢复；
/// - 内核休眠；
///
/// 如果业务依赖以上事件执行和修正倒计时，请勿使用此倒计时器。
///
/// > Important: 此倒计时器受系统重启影响，因此不支持以任何方式被持久化存储、并于系统重启后继续使用。
///
/// 此倒计时器**通常**在主线程发布。当主线程暂停（例如：App 冻结）或繁忙时可能延迟发布，但不会影响计时精度。当调用者手动终止或
/// ARC 释放触发发布时，发布工作在不确定的线程。
public final class CountDown: Publisher {
    /// 计时开始时间。
    ///
    /// 此时间戳对应未明确定义的系统内部实现，不匹配日历时间。系统仅保证时间戳相减获得稳定递增的纳秒 (nanoseconds, ns) 时间跨度。
    private let origin: UInt64

    /// 总倒计时时长，单位：秒。
    public let seconds: TimeInterval

    /// 倒计时反馈间隔，单位：秒。
    public let interval: TimeInterval

    /// 剩余时间，单位：秒。
    public var timeRemaining: TimeInterval {
        let difference = Double(clock_gettime_nsec_np(CLOCK_MONOTONIC_RAW) - self.origin) / 1e9
        guard difference < self.seconds else {
            return 0
        }
        return self.seconds - difference
    }

    /// 触发 Combine 发布的计时器。
    private var timer: Timer?

    /// Combine 发布的字符串输出格式。
    ///
    /// 默认格式：
    ///
    /// - 根据总倒计时间自动决定输出是否包含小时；
    /// - 每个时间单位至少使用两位数字，不足补零；
    /// - 时间单位之间以冒号 (`:`) 或当前语言环境常用时间分隔符切分。
    ///
    /// 设置 [`allowedUnits`](
    /// https://developer.apple.com/documentation/foundation/datecomponentsformatter/1410216-allowedunits
    /// ) 可调整输出字符串包含的时间单位。常用值：
    ///
    /// | 赋值                         | 输出示例    |
    /// | --------------------------- | ---------- |
    /// | `[.hour, .minute, .second]` | `00:05:30` |
    /// | `[.minute, .second]`        | `05:30`    |
    /// | `[.second]`                 | `330`      |
    ///
    /// 设置 [`.unitStyle`](
    /// https://developer.apple.com/documentation/foundation/datecomponentsformatter/1413441-unitsstyle
    /// ) 和 [`zeroFormattingBehavior`](
    /// https://developer.apple.com/documentation/foundation/datecomponentsformatter/1413749-zeroformattingbehavior
    /// ) 等可调整输出字符串格式。
    ///
    /// 调用 ``resetOutputStyle()`` 可重置下次发布的字符串格式。
    public let formatter = DateComponentsFormatter()

    /// 构造计时器，但不会立即开始计时。
    ///
    /// - Parameters:
    ///   - timeRemaining: 倒计时长，单位：秒。支持非整数秒，但传入负值将导致未定义行为。
    ///   - interval: Combine 发布间隔，单位：秒。支持非整数秒。
    public init(_ timeRemaining: TimeInterval, interval: TimeInterval = 1) {
        // 严禁使用 Date.now 或者 CFAbsoluteTimeGetCurrent()。
        // 当前日期时间 (Date Time) 可能因用户调整、夏令时切换、NTP 同步（例如：闰秒）出现未知且不可控的正负偏移；
        // 系统启动时间 (Up Time) 不计算内核休眠时间；
        // CLOCK_MONOTONIC_RAW 不保证与日历时间同步，但保证在单次系统运转期间稳定递增。
        self.origin = clock_gettime_nsec_np(CLOCK_MONOTONIC_RAW)

        self.seconds = timeRemaining
        self.interval = interval
        self.resetOutputStyle()
    }
    

    deinit {
        self.timer?.invalidate()
        self.subject.send(completion: .finished)
    }

    /// 根据剩余时间生成字符串。
    ///
    /// 因为 `DateComponentsFormatter` 返回可选值，此方法额外使用 `MeasurementFormatter` 回退意外场景。
    private func localize(_ seconds: TimeInterval) -> String {
        let rounded = seconds.rounded()
        guard let string = self.formatter.string(from: rounded) else {
            let formatter = MeasurementFormatter()
            formatter.locale = .autoupdatingCurrent
            formatter.unitOptions = .providedUnit
            formatter.unitStyle = .medium
            return formatter.string(from: Measurement(value: rounded, unit: UnitDuration.seconds))
        }
        return string
    }

    /// 重置输出字符串格式。
    public func resetOutputStyle() {
        self.formatter.calendar = .autoupdatingCurrent
        if Int(Measurement(value: self.seconds, unit: UnitDuration.seconds).converted(to: .hours).value) > 0 {
            self.formatter.allowedUnits = [.hour, .minute, .second]
        } else {
            self.formatter.allowedUnits = [.minute, .second]
        }
        self.formatter.allowsFractionalUnits = false
        self.formatter.zeroFormattingBehavior = .pad
        self.formatter.unitsStyle = .positional
    }

    /// 开始倒计时。
    ///
    /// 此方法将立即发布一次总倒计时长。如果在此方法调用后订阅 Combine，将错过此次消息。
    @discardableResult
    public func start() -> Self {
        self.subject.send((self.seconds, self.localize(self.seconds)))

        let timer = Timer(timeInterval: self.interval, target: self, selector: #selector(Self.onTimerFired(_:)),
                          userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer

        return self
    }

    /// 提前停止倒计时。
    ///
    /// 倒计时在结束后自动停止。此方法仅用于提前终止。
    ///
    /// > Important: 倒计时器停止后无法恢复。再次调用 ``start()`` 和 ``stop()`` 都将导致未定义行为。
    ///
    /// 此方法将立即发布一次剩余时间，随后发布 Combine 完成事件。
    public func stop() {
        self.timer?.invalidate()
        self.timer = nil
        self.subject.send((self.timeRemaining, self.localize(self.timeRemaining)))
        self.subject.send(completion: .finished)
    }

    /// 发布剩余时间。
    ///
    /// - Parameter timer: 系统计时器。
    @objc func onTimerFired(_ timer: Timer) {
        let timeRemaining = self.timeRemaining
        if timeRemaining == 0 {
            self.timer?.invalidate()
            self.timer = nil
            self.subject.send((0, self.localize(0)))
            self.subject.send(completion: .finished)
            return
        }
        self.subject.send((timeRemaining, self.localize(timeRemaining)))
    }

    // MARK: Publisher

    private let subject = PassthroughSubject<Output, Failure>()

    /// 此发布者将发布的内容。倒计时器发布原始剩余时间（单位：秒）和本地化的字符串。
    public typealias Output = (TimeInterval, String)

    /// 此发布者将发布的错误。倒计时器不会发布错误，发布均正常终止。
    public typealias Failure = Never

    public func receive<S: Subscriber>(subscriber: S) where S.Failure == Failure, S.Input == Output {
        self.subject.receive(subscriber: subscriber)
    }
}
