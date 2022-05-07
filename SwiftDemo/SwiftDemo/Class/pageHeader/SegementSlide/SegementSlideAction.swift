//
//  SegementSlideAction.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/5/7.
//


import Combine
import Foundation
import UIKit


/// tab 管理页面的必须功能
public protocol SegementSlideAction {
    func reloadData(index: Int, action: SegementSlideActionSource) throws
    func select(index: Int, animated: Bool, action: SegementSlideActionSource) throws
    func currentSelectedIndex() throws -> Int
    func currentSelectedContent() throws -> SegementSlideContent
}

/// tab 详情页的必须功能
public protocol SegementSlideContent: UIViewController {
    func reloadData(action: SegementSlideActionSource)

    func tabPageContentWillAppear(action: SegementSlideActionSource)
    func tabPageContentDidAppear(action: SegementSlideActionSource)

    func tabPageContentWillDisappear(action: SegementSlideActionSource)
    func tabPageContentDidDisappear(action: SegementSlideActionSource)

    var publisherOfContent: AnyPublisher<Any, Never>? { get }
}

public extension SegementSlideContent {
    func reloadData(action _: SegementSlideActionSource) {}

    func tabPageContentWillAppear(action _: SegementSlideActionSource) {}
    func tabPageContentDidAppear(action _: SegementSlideActionSource) {}

    func tabPageContentWillDisappear(action _: SegementSlideActionSource) {}
    func tabPageContentDidDisappear(action _: SegementSlideActionSource) {}

    var publisherOfContent: AnyPublisher<Any, Never>? {
        nil
    }
}

/// tab 页面中事件来源定义
public enum SegementSlideActionSource {
    /// 初始化时
    case initial

    /// 下拉刷新时
    case pullDown

    /// 手动选择时
    case select

    /// 滚动时
    case scroll(direct: UIPageViewController.NavigationDirection)

    /// 跟随别的组件触发而触发，此时需要避免循环套娃
    case followSelect
}
