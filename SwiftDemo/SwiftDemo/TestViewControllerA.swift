//
//  TestViewControllerA.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2021/12/19.
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

class TestViewControllerA: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPurple
        let ss = SomeClass()
        ss.test()
        
        print("______ff")
        
//        self.beginAppearanceTransition(<#T##isAppearing: Bool##Bool#>, animated: <#T##Bool#>)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(">>>>>viewDidAppear")
        
        
        let num1 = NSDecimalNumber(string: "123.456")
        let numaa = Decimal(123.456)
        
        let numbb = Decimal(string: "123.45")
        
        print("---\(num1)____\(numaa)___\(numbb)")
        let num: NSNumber = 123.456
        
        let num2 = NSDecimalNumber(decimal: num.decimalValue)
        let numberFormatter = NumberFormatter()
        
        numberFormatter.positiveFormat = "##,###.##"
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .floor
        
        let amountStr1 = numberFormatter.string(from: num1) ?? "--"
        print(amountStr1)
        let amountStr2 = numberFormatter.string(from: num2) ?? "--"
        print(amountStr2)
        
        // fontName:"Avenir-Black" size:18
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print(">>>>>viewWillDisappear")
    }
}


extension TestViewControllerA {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let ff =  try! JSONDecoder().decode(Double.self, from: "123.456".data(using: .utf8)!)
        
        print("___\(ff)")
    }
}
