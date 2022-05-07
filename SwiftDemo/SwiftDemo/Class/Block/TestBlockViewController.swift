//
//  TestBlockViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/2/24.
//

import UIKit


//闭包的使用
//https://www.jianshu.com/p/7c599b96815b

// $0. $1 的使用
/*
 //immo倒计时
 vehicle.functionsController.immo.countDownTrigger = {  [weak self] in
     //_ = $1
     if let t = $0 {
         self?.homepage?[\.display].countDown = .init(remaining: t, doorLocked:$1, formatter: { label, _, suggestion in
             label?.attributedText = self?.setUpImmoText(timerText: suggestion)
         })
     }
 }
 
 */
class TestAAB: UIViewController {
    
    //var aa: ((UIViewController?) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.aa = aa
        let vc = TestBlockViewController()
        
        
        vc.test1(actBottom: ("aa", { vc in
            print("555")
        }))
        
        vc.test2(actBottom: ("tit", {
            print("1111")
        }))
        
        vc.test3 {
            print("____ss")
        }
        
        vc.test4 { aa in
            print("____ss")
        }
        
        vc.test5 { aa, bb in
            print("____")
            return aa + bb
        }
    }
}


public typealias buttonClourse1 = (title: String,act:(UIViewController?) -> Void)

//public typealias buttonClourse = (title: String,act:(() -> Void)?)
public typealias buttonClourse2 = (title: String,act:(() -> Void)?)

//为没有参数也没有返回值的闭包类型起一个别名
   typealias Nothing = () -> ()
    
 //如果闭包的没有返回值，那么我们还可以这样写，
   typealias Anything = () -> Void
    
 //为接受一个Int类型的参数不返回任何值的闭包类型 定义一个别名：PrintNumber
   typealias PrintNumber = (Int) -> ()
    
 //为接受两个Int类型的参数并且返回一个Int类型的值的闭包类型 定义一个别名：Add
   typealias Add = (Int, Int) -> (Int)


class TestBlockViewController: UIViewController {

    public var actBottom1: buttonClourse1?
    public var actBottom2: buttonClourse2?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
                let lab = UILabel()
                view.addSubview(lab)
                lab.autoLayout(in: view, top: 100, bottom: nil, leading: 0, trailing: 0)
                lab.autoLayout(fixingHeight: 90, fixingWidth: nil)
        
                lab.backgroundColor = .systemGreen
                lab.text = "dfhjsdhfj"
        
        view.backgroundColor = .randomColor()
    }
    
//    public convenience init(actBottom: buttonClourse? = nil, actBottom1: buttonClourse1? = nil) {
//        self.init()
//        self.actBottom = actBottom
//        self.actBottom1 = actBottom1
//    }
    
    public func test1(actBottom: buttonClourse1? = nil) {
        print("++++")
    }
    
    public func test2(actBottom: buttonClourse2? = nil) {
        print("++++222")
    }
    
    public func test3(actBottom: Nothing) {
        print("++++222")
    }
    
    public func test4(actBottom: PrintNumber) {
        print("++++222")
    }
    
    public func test5(actBottom: Add) {
        print("++++222")
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
