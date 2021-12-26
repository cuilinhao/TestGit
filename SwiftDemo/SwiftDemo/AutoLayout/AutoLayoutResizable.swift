import Foundation
import UIKit

/// 支持通过 `NSLayoutDimension` 进行 Auto Layout 自适应尺寸的视图
public protocol AutoLayoutResizable: AutoLayoutCompatible {
    var heightAnchor: NSLayoutDimension { get }
    var widthAnchor: NSLayoutDimension { get }
}

// MARK: - UIView + AutoLayoutResizable

// UIView 默认支持 NSLayoutDimension
extension UIView: AutoLayoutResizable {}

// MARK: - UILayoutGuide + AutoLayoutResizable

// UILayoutGuide 默认支持 NSLayoutDimension
extension UILayoutGuide: AutoLayoutResizable {}
