//
//  GradientViewcontrollerViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/1/22.
//

import UIKit

/*
 https://www.codenong.com/js94c0144feb35/
 */

class GradientViewcontrollerViewController: UIViewController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test()
        view.backgroundColor = .randomColor()
        
    }
    
    
    func createGradientLayer() -> CAGradientLayer {
        //定义渐变的颜色（从黄色渐变到橙色）
        let topColor = UIColor.red// UIColor(red: 0xfe/255, green: 0xd3/255, blue: 0x2f/255, alpha: 1)
        let buttomColor = UIColor.green // UIColor(red: 0xfc/255, green: 0x68/255, blue: 0x20/255, alpha: 1)
        
        let gradientColors = [topColor.cgColor, buttomColor.cgColor]
        
        
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        //对角渐变
        //gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        //gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        //垂直渐变
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        

        return gradientLayer
    }
    
    
}




//MARK: - 垂直变化_项目使用
extension GradientViewcontrollerViewController {
    
    func test() {
        let vv = UIView()
        view.addSubview(vv)
        vv.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            vv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vv.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vv.heightAnchor.constraint(equalTo: vv.widthAnchor, multiplier: 1)
        ])
        vv.backgroundColor = .lightGray
        
        //setNeedsLayout 这个调用一定要和layoutIfNeeded 一起调用,否则没效果
        //layoutIfNeeded 调用之前 可以不用调用setNeedsLayout
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        let layer = createGradientLayer()
        layer.frame  = vv.bounds
        vv.layer.addSublayer(layer)
    }
    
}

extension GradientViewcontrollerViewController {
    
    func test1() {
        
        let vv = UIView()
        vv.frame = CGRect(x: 0, y: 100, width: 200, height: 160)
        view.addSubview(vv)
        
        vv.backgroundColor = .lightGray
        let layer = createGradientLayer()
        layer.frame  = vv.bounds
        vv.layer.addSublayer(layer)
        
    }
    
   
}

//MARK: - //水平变化
extension GradientViewcontrollerViewController {
    
    func testH() {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 200, width: self.view.bounds.width, height: 100)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.colors = [UIColor.red.cgColor,
                           UIColor.orange.cgColor,
                           UIColor.yellow.cgColor,
                           UIColor.green.cgColor,
                           UIColor.blue.cgColor,
                           UIColor.purple.cgColor]
        gradient.locations = [0.0, 0.6, 0.7, 0.8, 0.9, 1.0]
        self.view.layer.addSublayer(gradient)
    }
}

//MARK: - //垂直变化
extension GradientViewcontrollerViewController {
    func test_1() {
        //垂直变化
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 200, width: self.view.bounds.width, height: self.view.bounds.width)
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        //这个数组中的值必须在 0 和 1 之间，并以分数的形式指定渐变几何上的颜色停止。文档中指出，这个数组中的值必须是 "单向递增” 的
        gradient.colors = [UIColor.red.cgColor,
                           UIColor.orange.cgColor,
                           UIColor.yellow.cgColor,
                           UIColor.green.cgColor]
        gradient.locations = [0.0, 0.3, 0.8, 1.0]
        self.view.layer.addSublayer(gradient)
        
        
    }
}
