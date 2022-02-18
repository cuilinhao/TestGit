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
    }
    
}
