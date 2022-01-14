//
//  TestArrayViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2021/12/31.
//

import UIKit
import SwiftUI

class TestArrayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .randomColor()
        
        let vv = UITextView()
        
       let arr = method1()
        print("__arr:\(arr)")
        
        method2()
        method3()
        testForEach()
    }

}

//MARK: - 数组遍历

extension TestArrayViewController {
    
    @discardableResult//忽略 返回值
    func method1() -> [Int] {
        
        let nums = [1,2,3,4,45,56,67]
        let result = nums.filter { num in
            num % 2 == 0
        }
        
        return result
    }
    
    func method2() {
        var someStrs = [String]()
        someStrs.append("Apple")
        someStrs.append("Amazon")
        someStrs.append("sony")
        someStrs += ["Google"]
        
        for (index, item) in someStrs.enumerated() {
            
            print("index = \(index) 位置上值为\(item)")
        }
    }
    
    func method3() {
        
        let arr: [String] = ["q", "w", "e", "r", "t", "y"]
        for i in 0..<arr.count {
            let item = arr[i]
            print("\(item)")
        }
        
        for i in (0..<10).reversed() {
            print(i)
        }
    }
    
}

extension TestArrayViewController {
    
    func testForEach() {
        
        let numbers = ["one", "two", "three"]
        
        numbers.forEach { word in
            print("____\(word)")
        }
    }
}
