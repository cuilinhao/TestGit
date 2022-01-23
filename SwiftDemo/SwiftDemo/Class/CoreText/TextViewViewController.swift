//
//  TextViewViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/1/23.
//

import UIKit

class TextViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .randomColor()
        
        let sempleView = TestTextDrawView()
        sempleView.backgroundColor = UIColor.systemYellow
        sempleView.frame = CGRect(x: 0, y: 200, width: self.view.bounds.width, height: 200)
        view.addSubview(sempleView)
        
        sempleView.font = UIFont.systemFont(ofSize: 20)

        
    }

}


//MARK: - 简单文本绘制

class TestTextDrawView: UITextView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let str = "欢迎访问 baiduc.com"
        //文字样式属性
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
                         NSAttributedString.Key.foregroundColor: UIColor.purple,
                         NSAttributedString.Key.paragraphStyle: style]
                         
        
        //绘制在指定区域
        //(str as NSString).draw(in: self.bounds, withAttributes: attributes)
        
        //从指定点开始绘制
        (str as NSString).draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
        
    }
}


