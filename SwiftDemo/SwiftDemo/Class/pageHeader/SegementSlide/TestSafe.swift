//
//  TestSafe.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/4/27.
//

import Foundation


public extension Collection {
    /// 安全获取指定索引的元素。如果索引不存在，返回 `nil`。
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5][safe: 10]  // nil
    /// [1, 2, 3, 4, 5][safe: 0]   // 1
    /// ```
    subscript(safe index: Index) -> Element? {
        self.indices.contains(index) ? self[index] : nil
    }
}

public extension Collection where Index: Strideable {
    /// 安全获取指定索引范围的元素。如果索引范围部分越界，只会返回可以获取的元素；如果整体越界，返回空子序列。
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5][safe: 0...10]  // [1, 2, 3, 4, 5]
    /// [1, 2, 3, 4, 5][safe: 0..<3]   // [1, 2, 3]
    /// [1, 2, 3, 4, 5][safe: 100...]  // []
    /// ```
    subscript<R: RangeExpression>(safe range: R) -> SubSequence where R.Bound == Index {
        self[range.relative(to: self).clamped(to: self.startIndex..<self.endIndex)]
    }
}

public extension MutableCollection {
    /// 安全读取或写入指定索引的元素。如果索引不存在，读取返回 `nil`，写入无操作。
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5][safe: 10]  // nil
    /// [1, 2, 3, 4, 5][safe: 0]   // 1
    ///
    /// var x = [1, 2, 3, 4, 5]
    /// x[safe: 10] = 100  // [1, 2, 3, 4, 5]
    /// x[safe: 3] = 100   // [1, 2, 3, 100, 5]
    /// ```
    subscript(safe index: Index) -> Element? {
        get {
            self.indices.contains(index) ? self[index] : nil
        }
        set(value) {
            guard let value = value, self.indices.contains(index) else { return }
            self[index] = value
        }
    }
}

public extension MutableCollection where Index: Strideable {
    /// 安全读取或写入指定索引范围的元素。如果索引范围越界，将使用新元素替换索引范围和有效索引的交集。
    ///
    /// - Important:
    /// 必须先阅读 `Range`, `ClosedRange`, `RangeExpression` 和 `MutableCollection` 的文档。此函数仅保证范围安全，但 Swift
    /// 集合类型对有效范围的定义和对以范围存取元素的处理可能与常识或其他编程语言不同。错误地使用此函数可能导致数据污染和丢失。
    ///
    /// - Warning:
    /// 严禁修改此函数的实现以排除非预期但符合 Swift 标准的行为。如此做将导致使用某些参数调用此函数 `subscript[safe:]` 和系统函数
    /// `subscript[]` 行为不同。
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5][safe: 0...10]  // [1, 2, 3, 4, 5]
    /// [1, 2, 3, 4, 5][safe: 0..<3]   // [1, 2, 3]
    /// [1, 2, 3, 4, 5][safe: 100...]  // []
    ///
    /// var x = [1, 2, 3, 4, 5]
    /// x[safe: 0...3] = [100]        // [100, 5]
    /// x[safe: -5..<2] = [100, 101]  // [100, 101, 3, 4, 5]
    /// x[safe: 50...90] = [50, 51]   // [1, 2, 3, 4, 5, 50, 51]
    /// ```
    subscript<R: RangeExpression>(safe range: R) -> SubSequence where R.Bound == Index {
        get {
            self[range.relative(to: self).clamped(to: self.startIndex..<self.endIndex)]
        }
        set(values) {
            self[range.relative(to: self).clamped(to: self.startIndex..<self.endIndex)] = values
        }
    }
}
