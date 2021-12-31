//
//  TestCombineViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2021/12/31.
//

import UIKit
import Combine


/*
 Combine是一种响应式编程范式, 采用声明试的Swift APi
 你写代码不同于以往命名式的描述如何处理数据.而是要描述好数据会经过那些逻辑运算处理,
 这样代码更好维护,可以有效的减少嵌套闭包以及分散的回调

 */


class TestCombineViewController: UIViewController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()

        let testA = AClass()
        testA.sinkTest()

        //let testB = BClass()
        //testB.sinkTest()
    }
}

extension TestCombineViewController {
    //声明式 和过程式 区别

    //所有数组相加
    //命令式思维
    func sum1(arr: [Int]) -> Int {
        var sum: Int = 0
        for v in arr {
            sum += v
        }
        return sum
    }

    //声明式思维
    func sum2(arr: [Int]) -> Int {
        return arr.reduce(0, +)
    }
}

extension TestCombineViewController {
    //Combine 主要用来处理异步的事件和值, 苹果UI框架是在主线程上进行UI更新
    //Combine 通过Publisher的receive设置回到主线程更新UI会非常简单

    //Combine的三个核心概念
    //1.发布者 Publiser
    //2.订阅者 Subscriber
    //3.操作符 Operator

    //简单举个发布数据和类属性绑定的例子：

    //subject 广播
    //

}

class AClass {

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

        let o = AClass()
        let _ = pB.assign(to: \.p, on: o)
    }

}

class BClass {
    
    /*
     pA 的类型 O: Int, F: Never
     pA.map类型: > -> O: (T) String, F: Never
     */
    let pA = Just(20)
    let pB = [7,90,16,11].publisher

    /*
     struct Sequence<Elements, Failure> where Elements : Sequence, Failure : Error
     typealias Output = Elements.Element
     */
    
    let lab = UILabel()

    /*
     pC 的类型: // pC >  Publishers.Sequence<String, Never> -> O: Character, F: Never
     pC.collect // pC >  Publishers.Sequence<String, Never> -> O: Character, F: Never
     pC.collect().map() // > Publishers.Map<Self, T> -> O: (T) String, F: Never
     */
    let pC = "Combine".publisher
    let pD = ["Combine"].publisher

    //Int 数组
    let pE = Just(20)

    var p: Int = 20 {
        didSet {
            print("property update to \(p)")
        }
    }
    var str: String = "aa" {
        didSet {
            print("str update to \(str)")
        }
    }

    func sinkTest() {
        let _ = pA.sink { v in
            print("pA is: \(v)")
        }
        let _ = pB.sink { v in
            print("pB: \(v)")
        }
        let o = BClass()
        let _ = pB.assign(to: \.p, on: o)
        let test2 = BClass()

        //character 的Array
        //success: [Publishers.Sequence<Elements, Failure>.Output]
        //failure: Failure
        //collect: func collect() -> Result<[Publishers.Sequence<Elements, Failure>.Output], Failure>.Publisher
        //map: map的输入[Publishers.Sequence<Elements, Failure>.Output] map的输出: string

        //typealias Result<Success, Failure>.Publisher.Output = Success
        let _ = pC.collect().map { String($0) }.assign(to: \.str, on: test2)
        let _ = pD.assign(to: \.str, on: test2)
        let _ = pE.map { String($0) }
        //[[],[],] -> [[],[],[]]

        /*
         sink 拿到值自己处理
         assign 直接赋值
         */
    }
}

/*
class BClass {
    let pA = Just(20)
    // pA >  -> O: Int, F: Never
    {
        pA.map(<#T##(Output) -> T#>)
    }()
    // > -> O: (T) String, F: Never

    let pB = [7,90,16,11].publisher

    /*
     struct Sequence<Elements, Failure> where Elements : Sequence, Failure : Error
     typealias Output = Elements.Element
     */
    
    let lab = UILabel()

    let pC = "Combine".publisher
    // pC >  Publishers.Sequence<String, Never> -> O: Character, F: Never
    let x = {
        pC.collect()
    }()
    //  > Result<[], Never>.Publisher -> O: [Character], F: Never
    x = {
        pC.collect().map(<#T##transform: (Result<[String.Element], Never>.Publisher.Output) -> T##(Result<[String.Element], Never>.Publisher.Output) -> T#>)
    }()
    // > Publishers.Map<Self, T> -> O: (T) String, F: Never

    let pD = ["Combine"].publisher

    //Int 数组
    let pE = Just(20)

    var p: Int = 20 {
        didSet {
            print("property update to \(p)")
        }
    }
    var str: String = "aa" {
        didSet {
            print("str update to \(str)")
        }
    }

    func sinkTest() {

        let _ = pA.sink { v in
            print("pA is: \(v)")
        }
        let _ = pB.sink { v in
            print("pB: \(v)")
        }

        let o = BClass()
        let _ = pB.assign(to: \.p, on: o)

        let test2 = BClass()

        //character 的Array
        //success: [Publishers.Sequence<Elements, Failure>.Output]
        //failure: Failure
        //collect: func collect() -> Result<[Publishers.Sequence<Elements, Failure>.Output], Failure>.Publisher
        //map: map的输入[Publishers.Sequence<Elements, Failure>.Output] map的输出: string

        //typealias Result<Success, Failure>.Publisher.Output = Success
        let _ = pC.collect().map { String($0) }.assign(to: \.str, on: test2)

        let _ = pD.assign(to: \.str, on: test2)

        let _ = pE.map { String($0) }

        //[[],[],] -> [[],[],[]]

        /*
         sink 拿到值自己处理
         assign 直接赋值
         */
    }
}
 */




