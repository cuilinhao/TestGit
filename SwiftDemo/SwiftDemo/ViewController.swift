//
//  ViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2021/12/16.
//

import UIKit

class Test {
    var name: String?
}

class ViewController: UIViewController {

    
    var vc: Test?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let gg = SessionDelegate()
        
        print(gg)
        
        let tt = Test()
        
        self.vc = tt
        
        
        guard self.vc !== tt else {
            return
        }
        
        print("23123123")
    }


}

extension ViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let vc = TestViewControllerA()
        
        self.present(vc, animated: true, completion: nil)
        
        let vv = TestViewControllerB()
        
        print("___haha__\(vv)")

        
    }
}

open class SessionDelegate: NSObject {
    
    public  init(_ data: String = "11") {
        
        super.init()
        
    }
    
}
