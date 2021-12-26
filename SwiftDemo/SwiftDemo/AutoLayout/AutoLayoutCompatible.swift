import Foundation
import UIKit

/// 支持 Auto Layout 约束的视图
public protocol AutoLayoutCompatible: NSObjectProtocol {
    var constraints: [NSLayoutConstraint] { get }
}

// MARK: - UIView + AutoLayoutCompatible

// UIView 默认支持约束
extension UIView: AutoLayoutCompatible {}

// MARK: - UILayoutGuide + AutoLayoutCompatible

// UILayoutGuide 提供获取 Auto Layout 约束相关的函数
extension UILayoutGuide: AutoLayoutCompatible {
    public var constraints: [NSLayoutConstraint] {
        self.constraintsAffectingLayout(for: .horizontal) + self.constraintsAffectingLayout(for: .vertical)
    }
}
