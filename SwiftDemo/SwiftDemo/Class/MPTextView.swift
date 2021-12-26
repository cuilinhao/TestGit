//
//  MPTextView.swift
//  MPUIKit
//
//  Created by Yunchou Peng 彭运筹 on 2021/4/12.
//

import UIKit

open class MPTextView: UITextView {
	public var attributedPlaceholder: NSAttributedString? {
		didSet {
			updatePlaceholderView()
		}
	}

	public var placeholder: String? {
		didSet {
			updatePlaceholderView()
		}
	}

	public var lineColor = UIColor.systemYellow

	public var hightLightedLineColor = UIColor.systemRed

	private let lineView = UIView()

	override public var font: UIFont? {
		didSet {
			self.placeholderAttributes[.font] = self.font
			self.updatePlaceholderConstraints()
			self.updatePlaceholderView()
		}
	}

	override open var textContainerInset: UIEdgeInsets {
		didSet {
			updatePlaceholderConstraints()
		}
	}

	//let placeholderView = UILabel()
	
	lazy var placeholderView: UILabel = {
		let lab = UILabel()
		return lab
	}()

	private var placeholderAttributes: [NSAttributedString.Key: Any] = [
		.foregroundColor: UIColor.systemPurple,
		.font: UIFont.systemFont(ofSize: 24)
	]

	override public init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		setup()
	}

	override public var text: String! {
		get {
			return super.text
		}
		set {
			super.text = newValue
			self.updatePlaceholderView()
		}
	}

	override public var attributedText: NSAttributedString! {
		get {
			return super.attributedText
		}
		set {
			super.attributedText = newValue
			updatePlaceholderView()
		}
	}

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}

	func setup() {
		insertSubview(placeholderView, at: 0)
		placeholderView.numberOfLines = 10
		
		showsVerticalScrollIndicator = false

		updatePlaceholderConstraints()

		NotificationCenter.default.addObserver(self,
											   selector: #selector(textDidChangeHandler(notification:)),
											   name: UITextView.textDidChangeNotification,
											   object: self)

		addSubview(lineView)

		lineView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			lineView.leadingAnchor.constraint(equalTo: frameLayoutGuide.leadingAnchor),
			lineView.trailingAnchor.constraint(equalTo: frameLayoutGuide.trailingAnchor),
			lineView.bottomAnchor.constraint(equalTo: frameLayoutGuide.bottomAnchor),
			lineView.heightAnchor.constraint(equalToConstant: 1.0)
		])

		updateLineView()
	}

	private var placeholderConstraints: [NSLayoutConstraint] = []

	private func updatePlaceholderConstraints() {
		guard placeholderView.superview != nil else {
			return
		}

		placeholderView.translatesAutoresizingMaskIntoConstraints = false

		removeConstraints(placeholderConstraints)

		let inset: UIEdgeInsets = {
			let textContainerInset = self.textContainerInset
			let lineFragmentPadding = self.textContainer.lineFragmentPadding
			return UIEdgeInsets(
				top: textContainerInset.top,
				left: textContainerInset.left + lineFragmentPadding,
				bottom: textContainerInset.bottom,
				right: textContainerInset.right + lineFragmentPadding
			)
		}()
		//MARK: - 设置bottom之后有问题
		placeholderConstraints = [
			placeholderView.leadingAnchor.constraint(equalTo: self.frameLayoutGuide.leadingAnchor, constant: inset.left),
			placeholderView.trailingAnchor.constraint(equalTo: self.frameLayoutGuide.trailingAnchor, constant: inset.right),
			placeholderView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: inset.bottom),
			placeholderView.topAnchor.constraint(equalTo: self.topAnchor, constant: inset.top)
		]
		NSLayoutConstraint.activate(placeholderConstraints)
		
		//codeTest
		placeholderView.backgroundColor = UIColor.systemYellow
		
		self.placeholder = "1122111111"
	}

	@objc
	func textDidChangeHandler(notification: Notification) {
		if let obj = notification.object as? MPTextView, obj === self {
			updatePlaceholderView()
		}
	}

	func updatePlaceholderView() {
		placeholderView.attributedText = attributedPlaceholder ??
			NSAttributedString(string: placeholder ?? "", attributes: placeholderAttributes)
		placeholderView.isHidden = !text.isEmpty
		
		//TODO: codeTest
		placeholderView.isHidden = false
	}

	private func updateLineView() {
		lineView.backgroundColor = isFirstResponder ? hightLightedLineColor : lineColor
	}

	override open func becomeFirstResponder() -> Bool {
		defer {
			self.updateLineView()
		}
		return super.becomeFirstResponder()
	}

	override open func resignFirstResponder() -> Bool {
		defer {
			self.updateLineView()
		}
		return super.resignFirstResponder()
	}
}

