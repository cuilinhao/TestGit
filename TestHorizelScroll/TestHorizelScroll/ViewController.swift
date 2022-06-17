//
//  ViewController.swift
//  TestHorizelScroll
//
//  Created by Linhao CUI 崔林豪 on 2022/6/17.
//

import UIKit
import MarqueeLabel


class ViewController: UIViewController {
    
    @IBOutlet weak var demoLabel1: MarqueeLabel!
    
    // MARK: - Life Cycle
    
    lazy var titleLab: MarqueeLabel = {
        let lab = MarqueeLabel()
        
        lab.text = "新功能【一键启动】"
        view.addSubview(lab)
        lab.frame = CGRect(x: 40, y: 200, width: 180, height: 90)
        return lab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        demoLabel1.text = "This is a test of MarqueeLabel - the text is long enough that it needs to scroll to see the whole thing."
//
//        demoLabel1.tag = 101
//        demoLabel1.type = .continuous
//        demoLabel1.animationCurve = .easeInOut
//
//        MarqueeLabel.controllerLabelsLabelize(self)
        
        //----
        titleLab.text = "快捷场景: 下班回家模式啊, "
        titleLab.backgroundColor = .lightGray
        titleLab.tag = 101
        titleLab.type = .continuous
        titleLab.animationCurve = .easeInOut
        
        titleLab.animationDelay = 0.0
        
        titleLab.speed = .duration(7.0)

        
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        MarqueeLabel.controllerLabelsLabelize(self)
        
    }


}

