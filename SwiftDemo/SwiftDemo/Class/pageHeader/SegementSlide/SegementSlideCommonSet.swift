//
//  SegementSlideCommonSet.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/5/7.
//

import Foundation
import UIKit


extension SegementSlideCommonSet {
    /// Guideline 相关定义
    enum SegementSlideGuide {}
}

public enum SegementSlideCommonSet {
    //internal static let bundle = Bundle(for: MPPageTitleView.self).bundle("SegementSlideCommonSet")!
}

extension SegementSlideCommonSet.SegementSlideGuide {
    enum Space {
        /// 栅格单位（最小单位）
        static let grid: CGFloat = 5.0

        /// 统一边距
        static let margin: CGFloat = Space.grid * 4

        /// 统一组件距离 - 短
        static let elementSpaceSmall: CGFloat = Space.grid * 3
        /// 统一组件距离 - 中
        static let elementSpaceMid: CGFloat = Space.grid * 6
        /// 统一组件距离 - 长
        static let elementSpaceLarge: CGFloat = Space.grid * 12

        /// 统一文本间距 - 短
        static let textSpaceSmall: CGFloat = Space.grid * 1
        /// 统一文本间距 - 中
        static let textSpaceMid: CGFloat = Space.grid * 2
        /// 统一文本间距 - 长
        static let textSpaceLarge: CGFloat = Space.grid * 3
    }
}
