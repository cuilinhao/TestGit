//
//  CountDownViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/2/18.
//

import UIKit
import Combine

class CountDownViewController: UIViewController {

    var cancellable = Set<AnyCancellable>()
    
    
    var timerLabel: UILabel?
    
    //----
    lazy var bgView: UIView = {
        let vv = UIView()
        view.addSubview(vv)
        vv.backgroundColor = .lightGray
        vv.autoLayout(centeredIn: view, top: nil, bottom: nil, leading: nil, trailing: nil)
        vv.autoLayout(fixingHeight: 300, fixingWidth: 300)
        return vv
    }()
    
//    lazy var bgView1: UIView = {
//        let bgView = UIView()
//        view.addSubview(bgView)
//        bgView.backgroundColor = .systemGreen
//        bgView.autoLayout(centeredIn: view, top: nil, bottom: nil, leading: 20, trailing: -20)
//        return bgView
//    }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 20)
        lab.textColor = .systemPurple
        lab.text = "水平居中"
        self.bgView.addSubview(lab)
        //水平居中
        lab.autoLayout(horizontallyCenteredIn: self.bgView, top: 30, bottom: nil, leading: nil, trailing: nil)
        
        return lab
    }()
    
    lazy var titleLab2: UILabel = {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 20)
        lab.textColor = .systemGreen
        lab.text = "垂直居中】"
        self.bgView.addSubview(lab)
        //垂直居中
        lab.autoLayout(verticallyCenteredIn: self.bgView, top: 50, bottom: nil, leading: nil, trailing: nil)
        return lab
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let lab = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 45))
        view.addSubview(lab)
        lab.backgroundColor = .lightGray
        lab.textColor = .systemOrange

        self.timerLabel = lab
        CountDown(300).start().sink(receiveValue: {
            self.timerLabel!.text = $0.1
        }).store(in: &self.cancellable)
        
        _ = self.bgView
        _ = self.titleLab
        _ = self.titleLab2
        
    }
    
}

extension CountDownViewController {
    
    
    
}
