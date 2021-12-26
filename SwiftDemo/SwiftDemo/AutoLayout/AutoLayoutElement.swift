import Foundation
import UIKit

/// 支持通过 `NSLayoutAnchor` 进行 Auto Layout 布局的视图
public protocol AutoLayoutElement: AutoLayoutCompatible {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }

    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }

    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

// MARK: - UIView + AutoLayoutElement

// UIView 默认支持 NSLayoutAnchor
extension UIView: AutoLayoutElement {}

// MARK: - UILayoutGuide + AutoLayoutElement

// UILayoutGuide 默认支持 NSLayoutAnchor
extension UILayoutGuide: AutoLayoutElement {}
