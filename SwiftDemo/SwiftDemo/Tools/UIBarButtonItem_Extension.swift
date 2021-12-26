//
//  UIBarButtonItem_Extension.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/6.
//

import UIKit

extension UIBarButtonItem {
	
	/*
	class func createItem(imageName : String, highImageName : String, size : CGSize) -> UIBarButtonItem {
		let btn = UIButton()
		
		btn.setImage(UIImage(named: imageName), forState: .Normal)
		btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
		
		btn.frame = CGRect(origin: CGPointZero, size: size)
		
		return UIBarButtonItem(customView: btn)
	}
	*/
	
	//遍历构造器
	//1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
	convenience init(imageName: String, highImageName: String = "", size:CGSize = CGSize.zero) {
		
		let btn = UIButton()
		
		btn.setImage(UIImage(named: imageName), for: .normal)
		
		if highImageName != "" {
			btn.setImage(UIImage(named: highImageName), for: .highlighted)
		}
		
		if size == CGSize.zero {
			btn.sizeToFit()
		}else {
			btn.frame = CGRect(origin: CGPoint.zero, size: size)
		}
		
		self.init(customView: btn)
	}
}
