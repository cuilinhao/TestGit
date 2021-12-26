//
//  Common.swift
//  DouYu_Project
//
//  Created by 崔林豪 imac on 2021/11/5.
//

import UIKit

//
//// 系统控件默认高度
//#define StatusBarHeight        (isiPhoneX?44.f:20.f)
//// 导航栏 高度
//#define TopBarHeight          (isPad?(70.f) :(isiPhoneX?88.f:64.f))
//#define BottomBarHeight        (isiPhoneX?83.f:49.f)
//#define TabBarHeight           (isiPhoneX?83.f:49.f)

//+ (BOOL)isIphoneX
//{
//	if (kIsIphoneX != 0) {
//		return (kIsIphoneX == 1);
//	}
//	if (@available(iOS 11.0, *)) {
//		UIEdgeInsets insets = [UIApplication sharedApplication].delegate.window.safeAreaInsets;
//		CGFloat bottom = insets.bottom;
//		if (bottom > 0) {
//			kIsIphoneX = 1;
//			return YES;
//		}
//		kIsIphoneX = -1;
//		return NO;
//	} else {
//		kIsIphoneX = -1;
//		return NO;
//	}
//}

//let isIphoneX: Bool = UIApplication.shared.delegate?.window.safe

let kStatusBarH : CGFloat = 44
let kNavigationBarH : CGFloat = 88
let kTabbarH : CGFloat = 83


let kStatusBarH2 : CGFloat = 20
let kNavigationBarH2 : CGFloat = 44
let kTabbarH2 : CGFloat = 44

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
