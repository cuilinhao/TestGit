//
//  GradientViewcontrollerViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/1/22.
//

import UIKit

/*
 
 ====
 贝塞尔曲线

 https://www.jianshu.com/p/b203537f31af

 https://www.jianshu.com/p/e136c3e65c29


 ====
 有动图
 https://cloud.tencent.com/developer/news/692746
 贝塞尔曲线在iOS端的绘图实践

 https://mp.weixin.qq.com/s?__biz=MzIyMTg0OTExOQ==&mid=2247486067&idx=2&sn=db651bfd51d23aff14224b7d357d7462&chksm=e8373903df40b015eaf88033cf56a84f4b5afe479ed9a21e17197ce996ebe61367e3031cd0bb&scene=27#wechat_redirect

 https://juejin.cn/post/6844903558718947341



 ===
 带切角的矩形
 https://juejin.cn/post/6844903481237569544


 ===
 快速上手IOS UIBezierPath（贝塞尔曲线）

 https://www.yisu.com/zixun/199658.html

 ====
 如何用渐变色填充贝塞尔曲线路径

 https://www.codenong.com/41437581/

 */

/*
 https://www.codenong.com/js94c0144feb35/
 */

class GradientViewcontrollerViewController: UIViewController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //test()
        
        //testBorder()
        //testAlpha()
        
        test_1()
        
        
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


//MARK: - 透明度
extension GradientViewcontrollerViewController {
    
    func testAlpha() {
        
        let aView = UIView(frame: CGRect(x: 0, y: 100, width: 200, height: 160))
        aView.backgroundColor = .lightGray
        view.addSubview(aView)
        
        let gradientLayer = CAGradientLayer()
        
        let color1 = UIColor(red: 216/255.0, green: 0/255.0, blue: 18/255.0, alpha: 0.0).cgColor
        
        let color2 = UIColor(red: 216/255.0, green: 0/255.0, blue: 18/255.0, alpha: 1.0).cgColor
        gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = aView.bounds
        
        //aView.layer.addSublayer(gradientLayer)
        
        let shaplayer = CAShapeLayer()
        shaplayer.borderWidth = 1.0
        shaplayer.path = UIBezierPath(roundedRect: gradientLayer.bounds, cornerRadius: 15.0).cgPath
        
        shaplayer.fillColor = UIColor.clear.cgColor
        
        shaplayer.strokeColor = UIColor.white.cgColor
        
        gradientLayer.mask = shaplayer
        
        aView.layer.addSublayer(gradientLayer)
    }
    
}


//MARK: - 给view的border 设置渐变色
extension GradientViewcontrollerViewController {
    
    func testBorder() {
        
        let bView = UIView()
        bView.backgroundColor = UIColor.lightGray
        view.addSubview(bView)
        
        bView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            bView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //bView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bView.heightAnchor.constraint(equalTo: bView.widthAnchor, multiplier: 1.0),
            bView.widthAnchor.constraint(equalToConstant: 150)
        ])
        view.layoutIfNeeded()
        
        //CAGradientLayer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.yellow.cgColor]
        gradientLayer.frame = bView.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        bView.layer.addSublayer(gradientLayer)
        
//        return
        let shapeLayer = CAShapeLayer()
        shapeLayer.borderWidth = 1.0
        shapeLayer.path = UIBezierPath(roundedRect: gradientLayer.bounds, cornerRadius: 15.0).cgPath
        //必须要设置成clearColor 或者nil 默认是黑色
        shapeLayer.fillColor = UIColor.clear.cgColor
        //strokeColor 是border的描边色，如果设置成clearColor的话就不会绘制出来border了，这里随便一个颜色就是让其能够绘制出来，实际使用的是渐变色
        shapeLayer.strokeColor = UIColor.white.cgColor
        //mask 用shapeLayer作为gradientLayer的mask，可以让gradientLayer内部挖空，只保留边缘border的渐变颜色
        gradientLayer.mask = shapeLayer
        //hapeLayer只是用来修饰gradientlayer的，目的是把gradientlayer的内部挖空，并且把border和圆角做出来
        bView.layer.addSublayer(gradientLayer)
        
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
        /*
         locations中元素的范围是从0到1。在这里，数组中的第一个元素0.2指定了colors数组中第一个元素红色的终点是0.2，也就是说把整个渐变色范围分成10份，从开始到2/10处都是纯红色，从2/10到8/10处是纯红色到纯黄色的渐变，而从8/10到10/10是纯黄色。
         */
        gradient.locations = [0.2, 0.8]
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
