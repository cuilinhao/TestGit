//
//  TestCombine.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2021/12/31.
//

import Foundation
import UIKit


//let lab = UILabel()
//
//lab.text.publisher
//
////chara
//lab.text?.publisher

class TestCombine: UIViewController {
    
    
    let pC = "Combine".publisher
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ss = ["aaa", "bbb"]
        
        let lab = UILabel()
        lab.text = "haha"
        lab.backgroundColor = .systemRed
        lab.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lab)
        NSLayoutConstraint.activate([
            lab.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            lab.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lab.heightAnchor.constraint(equalToConstant: 100),
            lab.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        //pC.assign(to: <#T##ReferenceWritableKeyPath<Root, String.Element>#>, on: "")
        
        view.backgroundColor = .randomColor()
        let aaClass = AAClass()
        
//        aaClass.pC.collect().map({
//            String($0)
//        }).assign(to: \.text, on: lab)
//
        aaClass.pC.collect().map({
            String($0)
        }).sink { str in
            debugPrint("\(Thread.current)")
            lab.text = str
        }
        
        
    }
}
