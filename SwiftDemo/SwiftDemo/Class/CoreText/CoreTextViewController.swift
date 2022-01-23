//
//  CoreTextViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/1/23.
//

import UIKit

class CoreTextViewController: UIViewController {

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let coreTextView = CoreTextView()
        coreTextView.backgroundColor = UIColor.lightGray
        coreTextView.frame = CGRect(x: 0, y: 200, width: view.bounds.width, height: 160)
        view.addSubview(coreTextView)

        
        //---
        //CGView
        let coreTextView1 = CGView()
        
        coreTextView1.backgroundColor = UIColor.lightGray
        coreTextView1.frame = CGRect(x: 0, y: 400, width: self.view.bounds.width, height: 200)
        view.addSubview(coreTextView1)
        
        //TestView
//        let testView = TestView()
//
//        testView.backgroundColor = UIColor.lightGray
//        testView.frame = CGRect(x: 0, y: 700, width: self.view.bounds.width, height: 200)
//        view.addSubview(testView)
        
        
        let sempleView = simpleView()
        sempleView.backgroundColor = UIColor.systemYellow
        sempleView.frame = CGRect(x: 0, y: 700, width: self.view.bounds.width, height: 200)
        view.addSubview(sempleView)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vv = TextViewViewController()
        self.navigationController?.pushViewController(vv, animated: true)
    }

}


class CoreTextView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 获取绘图上下文
        /**/
        guard let textContext = UIGraphicsGetCurrentContext() else {
            print(" >>>>>> 没有开启上下文  ")
            return
        }
        
        //保存初始状态
        //saveGState: 将当前图形状态的副本推入上下文的图形状态堆栈。
        textContext.saveGState()
        
        //在UIView 中 坐标原点在左上角, 与CoreText中 坐标原点在左下角
        //将坐标系 上下反转
        
        textContext.translateBy(x: 0, y: self.bounds.height)
        textContext.scaleBy(x: 1, y: -1)
        //设置文本绘制的矩形
        textContext.textMatrix = CGAffineTransform.identity
        
        //创建并设置路径(排版区域)
        let textPath = CGMutablePath()
        //如果高不是160 ,这 绘制的rect 会在下面
        textPath.addRect(CGRect(x: 0, y: 0, width: 100 + 100, height: 160), transform: .identity)
        textContext.addPath(textPath)
        //设置填充颜色
        //textContext.setFillColor(UIColor.black.withAlphaComponent(0).cgColor)
        
        textContext.setFillColor(UIColor.green.cgColor)
        textContext.drawPath(using: .fill)
        
        //根据framesetter和绘图区域创建CTFrame
        let str = "这是一个测试文本这是一个测试文本这是一个测试文本这是一个测试文本这是一个测试文本这是一个测试文本"
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        /*
         //The kerning of the text. 文本字距调整
         */
        
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
                         NSAttributedString.Key.foregroundColor: UIColor.purple,
                         /*NSAttributedString.Key.kern: -0.5,*/
                         NSAttributedString.Key.paragraphStyle: style
                        ]
        let attrString = NSAttributedString(string: str, attributes: attribute)
        
        let framesetter = CTFramesetterCreateWithAttributedString(attrString)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrString.length), textPath, nil)

        //使用CTFrameDraw 进行绘制
        CTFrameDraw(frame, textContext)
        
        //恢复成初始状态
        textContext.restoreGState()
    }
    
}


class CGView:UIView {
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        //为方便看到效果，背景使用黑色
        self.backgroundColor = UIColor.clear
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func draw(_ rect: CGRect) {
        super.draw(rect)
         
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
         
        //保存初始状态
        context.saveGState()
         
        //将坐标系系上下翻转
        context.textMatrix = CGAffineTransform.identity
        context.translateBy(x: 0, y: self.bounds.height)
        context.scaleBy(x: 1, y: -1)
         
        //创建并设置路径(排版区域)
        let path = CGMutablePath()
        //绘制椭圆
        path.addEllipse(in: self.bounds.insetBy(dx: 1, dy: 1))
        //绘制边框
        context.addPath(path)
        context.strokePath()
        
         
        //根据framesetter和绘图区域创建CTFrame
        let str = "欢迎访问hangge.com!欢迎访问hangge.com!欢迎访问hangge.com!欢迎访问hangge.com!欢迎访问hangge.com!欢迎访问hangge.com!欢迎访问hangge.com!"
        let attrString = NSAttributedString(string:str)
        let framesetter = CTFramesetterCreateWithAttributedString(attrString)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrString.length),
                                             path, nil)
         
        //使用CTFrameDraw进行绘制
        CTFrameDraw(frame, context)
         
        //恢复成初始状态
        context.restoreGState()
    }
    
}

class TestView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // 获取图形上下文。
        guard let context = UIGraphicsGetCurrentContext() else { return }

        // 翻转上下文坐标，仅iOS。
        context.translateBy(x: 0, y: self.bounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)

        // 设置文本绘制的矩形
        context.textMatrix = .identity

        // 创建一个绘制文本的区域的路径 不必是矩形
        let path = CGMutablePath()

        // 初始化一个矩形路径。
        //let bounds = CGRect(x: 10.0, y: 10.0, width: 200.0, height: 200.0)
        
        let bounds = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0)
        
        path.addRect(bounds, transform: .identity)

        // 初始化一个字符串
        let textString = "Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine." as CFString
        

        // 创建一个最大长度为0的可变属性字符串
        // kCFAllocatorDefault表示要一个内存分配器
        // 0表示最大长度
        guard let attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0) else { return }

        // 将textString复制到新创建的attrString中
        CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), textString)

        // 创建一个将添加到attrString的颜色属性。
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        var components: [CGFloat] = [1.0, 0.0, 0.0, 0.8]
        let red = CGColor(colorSpace: rgbColorSpace, components: &components)

        // 将前12个字符的颜色设置为红色.
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 12), kCTForegroundColorAttributeName, red)

        // 使用属性字符串创建framesetter。
        let framesetter = CTFramesetterCreateWithAttributedString(attrString as CFAttributedString)

        // 创建一个frame
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)

        // 在给定的frame绘制上下文
        CTFrameDraw(frame, context)

    }
}

//MARK: - 简单文本绘制

class simpleView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let str = "欢迎访问 hangge.com"
        //文字样式属性
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
                         NSAttributedString.Key.foregroundColor: UIColor.purple,
                         NSAttributedString.Key.paragraphStyle: style]
                         
        
        //绘制在指定区域
        (str as NSString).draw(in: self.bounds, withAttributes: attributes)
        
        //从指定点开始绘制
//        (str as NSString).draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
        
    }
}
