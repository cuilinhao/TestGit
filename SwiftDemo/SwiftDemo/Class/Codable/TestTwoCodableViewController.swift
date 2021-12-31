//
//  TestTwoCodableViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2021/12/29.
//

import UIKit

/*
 基本类型（String, Int, Double, Date 这些）系统有 Codable 默认实现，任何基于基本类型组装出来的 struct 系统也提供 Codable 默认实现
 */
struct FoolItem: Codable {
    var name: String?
    var price: String?
}


class MyClass: NSObject {
    
    var number: Int?
    var string: String?
    
    //如下声明的类型无法使用默认参数初始化：
    init(number: Int , string: String ) {
        super.init()
    }
    
}
class TestTwoCodableViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        test()
        testInit()
    }
}

extension TestTwoCodableViewController {
    func testInit() {
        
        let testClass = MyClass(number: 22, string: "haha")
        testClass.number = 22
        debugPrint("____\(testClass)")
        
        //let testclass2 = MyClass()
        //testclass2.number  = 11
        //debugPrint("___\(testclass2)")
    }
}

extension TestTwoCodableViewController {
    func test() {
        var item = FoolItem()
        item.name = "北大"
        print("____\(item)")
    }
}

