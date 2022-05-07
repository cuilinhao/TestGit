//
//  TestAlertViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/4/5.
//

import UIKit

//custom popup

class TestAlertViewController: UIViewController {

    lazy var btn: UIButton = {
        let btn = UIButton()
        //btn.setImage(UIImage(named: "vehicle_ui_function_alert_immo", in: .vehicleUI, compatibleWith: nil), for: .normal)
        view.addSubview(btn)
        btn.autoLayout(in: view, top: 140, bottom: nil, leading: 25, trailing: -25)
        btn.autoLayout(fixingHeight: 60, fixingWidth: nil)
        btn.backgroundColor = .systemPurple
        btn.setTitle("alert test", for: .normal)
        btn.setTitleColor(.systemYellow, for: .normal)
        btn.addTarget(self, action: #selector(test), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        _ = btn
        
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.text = "总金额睡觉时代峰峻四大皆空黄金时代封建时代黄金时代行风建设电话分机收到回复就是电话封建时代行风建设电话分机收到回复就是电话封建时代行风建设电话分机收到回复世纪东方好的"
        lab.font = UIFont.systemFont(ofSize: 20)
        lab.textColor = UIColor.systemPurple
        lab.backgroundColor = UIColor.systemBlue
        lab.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 600)
        //UIApplication.shared.keyWindow!.addSubview(lab)
       // Self.keyWindows()?.addSubview(lab)
        
        let vv = UITextView()
        vv.text = "总金额睡觉时代峰峻四大皆"
        vv.font = UIFont.systemFont(ofSize: 20)
        vv.textColor = UIColor.systemPurple
        vv.backgroundColor = UIColor.lightGray
        vv.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 600)
        Self.keyWindows()?.addSubview(vv)
    }
    
    @objc func test() {
        print("_____objc__")
        
//        let alertView = CustomPopupView("test")
//        alertView.show()
        
    }
    
    //主屏幕
    static func keyWindows()->UIWindow?{
        if #available(iOS 13.0, *) {
            let arr = Array(UIApplication.shared.connectedScenes)
            let scene:UIWindowScene =   arr.first as! UIWindowScene
            let keyWindow =   scene.windows[0]
            return keyWindow

        }else{
            return UIApplication.shared.keyWindow
        }

    }
    

}


