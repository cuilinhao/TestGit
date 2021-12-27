//
//  TestCoadbleViewController.swift
//  SwiftDemo
//
//  Created by 崔林豪 on 2021/12/27.
//

import UIKit


struct GoodItem: Codable {
	let payType: String?
	let linkUrl: String?
	
	
	//Return from initializer without initializing all stored properties
	init(linkUrl: String, payType: String) {
		self.linkUrl = linkUrl
		self.payType = payType
	}
	
}

struct GoodItem2: Codable {
	let payType: String?
	let linkUrl: String?
	
	
	//Return from initializer without initializing all stored properties
	init(linkUrl: String, payType: String) {
		self.linkUrl = linkUrl
		self.payType = payType
	}
	
}

class TestCoadbleViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .lightGray
		
		
		//self.handleOpenURL(item.linkUrl.flatMap({ URL.init(string: $0) }))
		
		//Argument type 'String' does not conform to expected type 'Decoder'
		let item = GoodItem(linkUrl: "https:ww.baidu.com", payType: "haha")
		
		let url = item.linkUrl.flatMap({
			
			//print("_____url:\(String(describing: URL.init(string:$0)))")
			//print("___\(item.linkUrl?.count)")
			URL.init(string:$0)
		})
		
		print(">>>>>+++\(String(describing: url))")
		
		print("___\(url)")
		
		
	}

}

extension TestCoadbleViewController
{
	func test() {
		
		//报错
		//Call can throw, but it is not marked with 'try' and the error is not handled
		//let item = GoodItem2(from: <#Decoder#>)
		//item.linkUrl = "123456"
		
	}
}

