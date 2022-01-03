//
//  TestcombileLab.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2021/12/31.
//

import UIKit
import Combine


class AAClass {
    
    let pA = Just(0)
    let pB = [7,90,16,11].publisher
    
    let pC = "Combine".publisher
    
    var p: Int = 0 {
        didSet {
            print("property update to \(p)")
        }
    }
    /* 打印结果
     //- pA的值是0
     //pB的值是 7, 90, 16, 11
     //属性p的值 更新为7 ,更新为90 ,更新为 16
     pA is: 0
     pB: 7
     pB: 90
     pB: 16
     pB: 11
     property update to 7
     property update to 90
     property update to 16
     property update to 11
     */
    func sinkTest() {
        
        let _ = pA.sink { v in
            //-值写到UI
            //上游(publisher)决定 值改变的时候,就会调用
            print("pA is: \(v)")
        }
        
        let _ = pB.sink { v in
            print("pB: \(v)")
        }
        
        //let o = AClass()
        //let _ = pB.assign(to: \.p, on: o)
    }
    
}

class TestcombileLab: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
