import UIKit

// 为按钮画圆角

/*
open class MPCornerMaskedButton: MPStateButton {
    open var isCornerMaskedEnable: Bool = false {
        didSet {
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        guard self.isCornerMaskedEnable else {
            return
        }
        self.cornersMasked(layer: self.layer)
    }
    
    open func cornersMasked(layer: CALayer) {
        layer.cornerRadius = (Swift.min(layer.bounds.width, layer.bounds.height) / 2.0).rounded(.down)
        layer.masksToBounds = true
    }
    
    open override func drawDecoration(in rect: CGRect) {
        guard self.isCornerMaskedEnable else {
            super.drawDecoration(in: rect)
            return
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setLineWidth(self.borderWidth(for: self.state) * 2.0)
        context.setStrokeColor(self.borderColor(for: self.state).cgColor)
        context.setFillColor(self.backgroundColor(for: self.state).cgColor)
        let radius = (Swift.min(rect.width, rect.height) / 2.0).rounded(.down)
        context.addPath(UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath)
        context.strokePath()
    }
}
