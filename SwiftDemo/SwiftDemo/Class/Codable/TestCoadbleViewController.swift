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
	
	init(linkUrl: String, payType: String) {
		self.linkUrl = linkUrl
		self.payType = payType
	}
	
}

/*
 如果有类继承, 且遵守Coadble, 会有问题
 */
class superGood : Codable {
    var payType: String?
    var linkUrl: String?
}

class GoodItem2: superGood {
	
}

class  GoodItem3: Codable {
    
    var payType: String?
}

class TestCoadbleViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .lightGray
		
     _ =  try? JSONDecoder().decode(Int.self, from:
        """
          {
          "name":"tom"
          }
          """.data(using: .utf8)!
)
		//self.handleOpenURL(item.linkUrl.flatMap({ URL.init(string: $0) }))
		
		//Argument type 'String' does not conform to expected type 'Decoder'
		let item = GoodItem(linkUrl: "https:ww.baidu.com", payType: "haha")
		
		let url = item.linkUrl.flatMap({
			URL.init(string:$0)
		})
		print(">>>>>+++\(String(describing: url))")
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

class TestObj2: NSObject, Codable {
    
    var name: String?
}

extension TestCoadbleViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = TestTwoCodableViewController()
        self.present(vc, animated: true, completion: nil)
    }
}

