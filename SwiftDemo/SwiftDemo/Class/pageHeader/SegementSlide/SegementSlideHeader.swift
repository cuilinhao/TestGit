//
//  SegementSlideHeader.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/5/7.
//


import Combine
import UIKit
import CoreGraphics



let itemWidth: CGFloat = 100.0
let itemSpace = SegementSlideCommonSet.SegementSlideGuide.Space.elementSpaceMid


public protocol SegementSlideHeaderDelegate: NSObjectProtocol {
    func header(_ header: SegementSlideHeader,
                willChangeFrom index: Int,
                to newIndex: Int,
                action: SegementSlideActionSource)

    func header(_ header: SegementSlideHeader,
                didChangeFrom index: Int,
                to newIndex: Int,
                action: SegementSlideActionSource)
}

public class SegementSlideHeader: UIView {
    public weak var source: SegementSlideHeaderSource? {
        didSet {
            self.updateBySource()
        }
    }
    public weak var delegate: SegementSlideHeaderDelegate?

    public private(set) lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()

    public private(set) lazy var container: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = itemSpace
        view.backgroundColor = .clear
        view.isLayoutMarginsRelativeArrangement = true
        //view.layoutMargins = .init(top: 10, left: .mp.margin, bottom: 15, right: .mp.margin)
        //SegementSlideCommonSet.Guide.Space.grid * 5
        view.layoutMargins = .init(top: 10, left: SegementSlideCommonSet.SegementSlideGuide.Space.grid * 5, bottom: 15, right:SegementSlideCommonSet.SegementSlideGuide.Space.grid * 5)
        return view
    }()

    private var currentIndex: Int = 0
    private var isAnimating = false

    private func setupUI() {
        layoutMargins = .zero

        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])

        scrollView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),

            container.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor)
        ])
    }

    private func reloadAllItems() {
        guard let source = self.source else {
            return
        }

        self.container.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }

        for index in 0 ..< source.segementSlide_numberOfHeaderItems(in: self) {
            let data = source.segementSlide_tabPage(self, headerSourceOf: index)
            let label = SelectItem.make(with: data)
            label.font = source.segementSlide_header(self, normalFontAtIndex: index)
            label.textColor = source.segementSlide_header(self, normalColorAtIndex: index)
            container.addArrangedSubview(label)

            let guesture = UITapGestureRecognizer(target: self, action: #selector(didSelectItem(_:)))
            label.addGestureRecognizer(guesture)
        }
    }

    @objc
    func didSelectItem(_ sender: Any) {
        guard let guesture = sender as? UITapGestureRecognizer,
              let label = guesture.view as? UILabel,
              let index = container.arrangedSubviews.firstIndex(of: label) else {
            return
        }

        try? select(index: index, animated: true, action: .select)
        self.source?.segementSlide_header(self, didSelectAtIndex: index)
    }
    
    func updateBySource() {
        guard let source = self.source else {
            return
        }
        
        self.container.layoutMargins = source.segementSlide_insetsOfHeader(in: self)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - SegementSlideAction

extension SegementSlideHeader: SegementSlideAction {
    public func reloadData(index: Int, action: SegementSlideActionSource) throws {
        if case .initial = action {
            self.reloadAllItems()
        }

        try? select(index: index, animated: true, action: .initial)
    }

    public func select(index: Int, animated: Bool, action: SegementSlideActionSource) throws {
        guard let select = container.arrangedSubviews[safe: index] as? SelectItem,
              let _ = container.arrangedSubviews[safe: currentIndex] as? SelectItem,
              self.isAnimating == false,
              let source = self.source
        else {
            return
        }
        
        if case .initial = action {
            DispatchQueue.main.async {
                self.updateSelectState(selectedIndex: index)
            }
            return
        }

        // 序号没变
        if currentIndex == index {
            return
        }

        // 没有动效
        if animated == false {
            updateSelectState(selectedIndex: index)
            return
        }

        isAnimating = true
        delegate?.header(
            self,
            willChangeFrom: currentIndex,
            to: index,
            action: action
        )

        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.updateSelectState(selectedIndex: index)
        } completion: { [weak self] _ in
            guard let `self` = self else { return }

            let currentIndex = self.currentIndex
            self.currentIndex = index
            self.delegate?.header(
                self,
                didChangeFrom: currentIndex,
                to: index,
                action: action
            )
            self.isAnimating = false
        }
    }

    public func currentSelectedIndex() throws -> Int {
        currentIndex
    }

    public func currentSelectedContent() throws -> SegementSlideContent {
        throw SegementSlideError.tabPageContentError
    }
    
    public func refresh() {
        guard let source = self.source else {
            return
        }
        
        for index in 0 ..< container.arrangedSubviews.count {
            guard let header = container.arrangedSubviews[index] as? SelectItem else {
                return
            }
            
            let current = container.arrangedSubviews[self.currentIndex]
            if header == current {
                header.textColor = source.segementSlide_header(self, selectedColorAtIndex: index)
            } else {
                header.textColor = source.segementSlide_header(self, normalColorAtIndex: index)
            }
        }
    }

    private func updateSelectState(selectedIndex: Int) {
        guard let source = self.source,
              let item = self.container.arrangedSubviews[selectedIndex] as? SelectItem
        else {
            return
        }
        
        for index in 0 ..< container.arrangedSubviews.count {
            guard let header = container.arrangedSubviews[index] as? SelectItem else {
                return
            }
            
            if header == item {
                header.transform = self.animationForIndex(index)
                header.textColor = source.segementSlide_header(self, selectedColorAtIndex: index)
            } else {
                header.transform = .identity
                header.textColor = source.segementSlide_header(self, normalColorAtIndex: index)
            }
        }
        
        /// 滑动到头尾的时候，更新左右修正间距
        let inset = self.getAnimationFixInsets()
        if selectedIndex == 0 {
            self.scrollView.contentInset = .init(top: 0, left: inset.left, bottom: 0, right: 0)
        } else if selectedIndex == self.container.arrangedSubviews.count - 1 {
            self.scrollView.contentInset = .init(top: 0, left: 0, bottom: 0, right: inset.right)
        } else {
            self.scrollView.contentInset = .zero
        }
        
        /// 选中的 tab 元素默认滑到中点。需要判断当前选中的元素前后方是否有足够内容让他能居中。
        /// 同时要考虑头尾放大时 inset 的修正。
        ///
        ///        +- offset==0      frame.width/2                           |
        ///     +--+---------------------------↑----------------------------—|------+--+
        ///     |  |        +----—+                                          |      |  |
        ///     |  |        |  ○  |            x                             |      |  |
        ///     |  |        +-----+                                          |      |  |
        ///     +--+---------------------------------------------------------|------+--+
        ///      ↑             +- item.center.x                              |        ↑
        ///      +-contentInset.left                       trailing of frame-+        +-contentInset.right
        if item.center.x < self.scrollView.frame.width / 2 {
            if selectedIndex == 0 {
                self.scrollView.contentOffset = .init(x: -self.scrollView.contentInset.left, y: 0)
            } else {
                self.scrollView.contentOffset = .zero
            }
        } else {
            /// 居中
            self.scrollView.contentOffset = .init(
                x: item.center.x - self.scrollView.frame.width / 2, y: 0
            )
            
            /// 当前选中的元素后方是没有足够内容让他能居中时， offset 会溢出
            if self.scrollView.contentOffset.x + self.scrollView.frame.width > self.scrollView.contentSize.width {
                if selectedIndex == self.container.arrangedSubviews.count - 1 {
                    self.scrollView.contentOffset = .init(
                        x: self.scrollView.contentSize.width + self.scrollView.contentInset.right - self.scrollView.frame.width,
                        y: 0)
                } else {
                    self.scrollView.contentOffset = .init(
                        x: self.scrollView.contentSize.width - self.scrollView.frame.width,
                        y: 0)
                }
            }
        }
    }
    
    private func animationForIndex(_ index: Int) -> CGAffineTransform {
        guard let source = self.source else {
            return .identity
        }
        
        let selectedFont = source.segementSlide_header(self, selectedFontAtIndex: index)
        let normalFont = source.segementSlide_header(self, normalFontAtIndex: index)
        let scale = selectedFont.lineHeight / normalFont.lineHeight
        let delta = selectedFont.xHeight - normalFont.xHeight
        return CGAffineTransform
            .init(scaleX: scale, y: scale)
            .translatedBy(x: 0, y: -delta / 2.0)
    }
    
    private func getAnimationFixInsets() -> UIEdgeInsets {
        guard let source = self.source else {
            return .zero
        }
        var scale =
            source.segementSlide_header(self, selectedFontAtIndex: 0).lineHeight /
            source.segementSlide_header(self, normalFontAtIndex: 0).lineHeight
        var item = self.container.arrangedSubviews[0]
        let leftInset = item.bounds.width * (scale - 1) / 2

        let lastIndex = source.segementSlide_numberOfHeaderItems(in: self) - 1
        scale =
            source.segementSlide_header(self, selectedFontAtIndex: lastIndex).lineHeight /
            source.segementSlide_header(self, normalFontAtIndex: lastIndex).lineHeight
        item = self.container.arrangedSubviews[lastIndex]
        let rightInset = item.bounds.width * (scale - 1) / 2

        let insets = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        print("生成 insets：\(insets)")
        return insets
    }
}

// MARK: - Source

public extension SegementSlideHeader {
    struct Source {
        public var title: String
        public var isExpandable: Bool
        public var normalIcon: Icon?
        public var selectedIcon: Icon?
        public var iconSize: CGSize

        public init(title: String,
                    isExpandable: Bool,
                    normalIcon: Icon? = nil,
                    selectedIcon: Icon? = nil,
                    iconSize: CGSize) {
            self.title = title
            self.isExpandable = isExpandable
            self.normalIcon = normalIcon
            self.selectedIcon = selectedIcon
            self.iconSize = iconSize
        }
    }
}

public extension SegementSlideHeader.Source {
    enum Icon {
        case local(name: String)
        case web(url: URL)
    }
}

extension SegementSlideHeader.Source: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(isExpandable)
        hasher.combine(normalIcon)
        hasher.combine(selectedIcon)
        hasher.combine(iconSize.width)
        hasher.combine(iconSize.height)
    }
}

extension SegementSlideHeader.Source.Icon: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .local(name):
            hasher.combine("local")
            hasher.combine(name)
        case let .web(url):
            hasher.combine("web")
            hasher.combine(url)
        }
    }
}

// MARK: - SelectItem

extension SegementSlideHeader {
    class SelectItem: UILabel {
        
//        var selectedFont: UIFont?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupUI()
        }
        
//        override func drawText(in rect: CGRect) {
//            let realRect = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
//            super.drawText(in: realRect)
//        }
//
//        override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
//            var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
//            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height
//            textRect.origin.y -= self.font.descender
//            if let selectedFont = selectedFont {
//                textRect.origin.y += selectedFont.descender
//            }
//            return textRect
//        }
    }
}

extension SegementSlideHeader.SelectItem {
    private func setupUI() {
        backgroundColor = .clear
        
        //font = UIFont.bluesky(of: .tips_m, weight: .bold)
        //textColor = UIColor.mp(.mb4)
         //TODO: codeTest
        font = UIFont.systemFont(ofSize: 20)
        textColor = UIColor.systemBlue
    }

    static func make(with source: SegementSlideHeader.Source) -> SegementSlideHeader.SelectItem {
        let button = SegementSlideHeader.SelectItem(frame: .zero)
        button.text = source.title
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }
}
