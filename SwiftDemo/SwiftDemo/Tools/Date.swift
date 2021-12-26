//
//  Date.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/7.
//

import UIKit

extension Date {

	static func getCurrentTime() -> String {
		
		
		//Date().timeIntervalSince1970
		
//		let timeInterval: TimeInterval = Date().timeIntervalSince1970
//		let timeStamp = Int (timeInterval)
//		print ( "当前时间的时间戳：\(timeStamp)" )
//
//
		
		let nowDate = Date()
		
		let interval = Int(nowDate.timeIntervalSince1970)
		return "\(interval)"
	}
	
}

//Value of type 'Date' has no member 'timeIntervalSince1970'


