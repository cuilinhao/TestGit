//
//  TestProtocolViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2021/12/31.
//

import UIKit


//协议定义
//协议定义通过关键字protocol
protocol SomeProtocol {
    //协议定义
    func test()
}


//类实现协议和继承父类，协议一般都写在父类后面
class SomeSuperclass: SomeProtocol {
    func test() {
        print("__test")
    }
    
    //父类定义
}

class SomeClass: SomeSuperclass{
    //子类定义
}


class TestProtocolViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.randomColor()
        
        let ss = SomeClass()
        ss.test()
        
    }
    

	

}

extension TestProtocolViewController {
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let vc = TestNSObjectProtocol()
		self.navigationController?.pushViewController(vc, animated: true)
	}
}
