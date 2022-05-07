//
//  SegementSlideHeaderSource.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/5/7.
//

import Foundation
import UIKit

public typealias SegementSlideSource =
    SegementSlideDelegate &
    SegementSlideDataSource &
    SegementSlideLayout &
    SegementSlideHeaderSource

public protocol SegementSlideHeaderSource: AnyObject {

    func segementSlide_tabPage(
        _ requester: Any,
        headerSourceOf index: Int
    ) -> SegementSlideHeader.Source
    
    func segementSlide_insetsOfHeader(in requester: Any) -> UIEdgeInsets
    
    func segementSlide_numberOfHeaderItems(in requester: Any) -> Int
    
    func segementSlide_header(_ header: Any, normalFontAtIndex index: Int) -> UIFont
    func segementSlide_header(_ header: Any, selectedFontAtIndex index: Int) -> UIFont
    func segementSlide_header(_ header: Any, normalColorAtIndex index: Int) -> UIColor
    func segementSlide_header(_ header: Any, selectedColorAtIndex index: Int) -> UIColor
    func segementSlide_header(_ header: Any, didSelectAtIndex index: Int)
}

public extension SegementSlideHeaderSource {
    
    func segementSlide_insetsOfHeader(in requester: Any) -> UIEdgeInsets {
        .init(top: 15, left: 20, bottom: 15, right: 20)
    }
    
    func segementSlide_header(_ header: Any, normalFontAtIndex index: Int) -> UIFont {
        //.nio.subTitle4Bold
        UIFont.systemFont(ofSize: 20)
    }
    func segementSlide_header(_ header: Any, selectedFontAtIndex index: Int) -> UIFont {
        //.nio.subTitle2Bold
        UIFont.systemFont(ofSize: 30)
    }
    func segementSlide_header(_ header: Any, normalColorAtIndex index: Int) -> UIColor {
        //.nio.text.tertiary
        UIColor.systemGreen
    }
    func segementSlide_header(_ header: Any, selectedColorAtIndex index: Int) -> UIColor {
        //.nio.text.primary
        UIColor.systemBlue
    }
    //点击pageHeader 会触发
    func segementSlide_header(_ header: Any, didSelectAtIndex index: Int) {
        
    }
}

public extension SegementSlideHeaderSource where Self: SegementSlideSource {
    
    func segementSlide_numberOfHeaderItems(in requester: Any) -> Int {
        self.segementSlide_numberOfItems(in: requester)
    }
}

public protocol SegementSlideDelegate: AnyObject {
    func segementSlide_tabPage(
        _ requester: Any,
        shouldSelectAt index: Int
    ) -> Bool

    func segementSlide_tabPage(
        _ requester: Any,
        didSelectAt index: Int
    )

    func segementSlide_tabPage(
        _ requester: Any,
        performExpanding isExpanding: Bool,
        at index: Int
    ) -> Bool

    func segementSlide_tabPage(
        _ requester: Any,
        didReceivePublish value: Any,
        at index: Int
    )
}

public extension SegementSlideDelegate where Self: SegementSlideSource {
    func segementSlide_tabPage(
        _: Any,
        shouldSelectAt _: Int
    ) -> Bool {
        true
    }

    func segementSlide_tabPage(
        _: Any,
        performExpanding _: Bool,
        at _: Int
    ) -> Bool {
        false
    }

    func segementSlide_tabPage(
        _: Any,
        didReceivePublish _: Any,
        at _: Int
    ) {}
}

public protocol SegementSlideDataSource: AnyObject {
    func segementSlide_numberOfItems(in requester: Any) -> Int

    func segementSlide_tabPage(_ requester: Any, contentOf index: Int) -> SegementSlideContent

    func segementSlide_tabPage(_ requester: Any, indexOf content: SegementSlideContent) -> Int
}

public protocol SegementSlideLayout: AnyObject {
    func segementSlide_allowsAnimation(in requester: Any) -> Bool
    func segementSlide_allowsScroll(in requester: Any) -> Bool
    
    /// header 的高度，返回空则代表自适应高度，默认为空。
    func segementSlide_heightOfHeader(in requester: Any) -> CGFloat?
}

public extension SegementSlideLayout {

    func segementSlide_allowsAnimation(in _: Any) -> Bool {
        true
    }

    func segementSlide_allowsScroll(in _: Any) -> Bool {
        true
    }
    
    func segementSlide_heightOfHeader(in requester: Any) -> CGFloat? {
        nil
    }
}
