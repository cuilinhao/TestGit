//
//  Dictionary.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/2/28.

// 测试字典, 以及在alert上添加 contentView

import Foundation
import UIKit

class testV: UIViewController {
    
    lazy var contentButton: UIButton = {
        let btn = UIButton()
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        
        let lab2 = UILabel()
        lab2.font = UIFont.systemFont(ofSize: 20)
        lab2.text = "同时启动车辆"
        lab2.backgroundColor = .yellow
        view.addSubview(lab2)
        lab2.autoLayout(horizontallyCenteredIn: view, top: 2, bottom: nil, leading: nil, trailing: nil)
        
        let comds = ["aa", "bb"]
        let ff = comds.filter{ cmd in  cmd == "aa"}
        print("_____\(ff)__\(ff.first)")
        
        if comds.filter({ cmd in  cmd == "aa"}).first == "aa"{
            print("____开始倒计时")
        }
        
    }
}

class TestDictionary: UIViewController {
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 20)
        lab.textColor = .systemRed
        lab.text = "新功能【一键启动】"
        view.addSubview(lab)
        lab.autoLayout(in: view, top: 415, bottom: nil, leading: 25, trailing: nil)
        return lab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        //let ff = Bundle.configureData()
          
        let ff = self.test()
        
        print("______data:\(ff)")
        
//        testAlert()
        
        _ = titleLab
        
        let arr = ["aa"]
        
        self.testAA(arr.count > 0 )
        
    }
    
    func testAA(_ ff: Bool) {
        self.titleLab.isHidden = ff
    }
}




extension TestDictionary {
    
    func testAlert() {
        let content_view_height:CGFloat = 35
        let  ctrl = testV()
        
       let alert = UIAlertController(title: "是否立即解锁车门", message: "", preferredStyle: .alert)
        let somethingAction = UIAlertAction(title: "Something", style: .default, handler: {(alert: UIAlertAction!) in print("something")})
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        alert.addAction(somethingAction)
        alert.addAction(cancelAction)
        alert.setValue(ctrl, forKey: "contentViewController")
        ctrl.preferredContentSize.height = content_view_height
        alert.preferredContentSize.height = content_view_height
        
        print("_____alert:\(alert.view.frame)")
        
        // you have to adjust the Alert size so it's bigger than your custom Content View Controller
        let alert_height:CGFloat = 150
        let custom_alert_height:NSLayoutConstraint = NSLayoutConstraint(
                        item: alert.view as Any,
                        attribute: NSLayoutConstraint.Attribute.height,
                        relatedBy: NSLayoutConstraint.Relation.equal,
                        toItem: nil,
                        attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                        multiplier: 1,
                        //constant: self.view.frame.height * 0.50 // e.g. half of current view
                        constant: alert_height // fixed
                )
        alert.view.addConstraint(custom_alert_height)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension TestDictionary {
    
    func test() -> [String: Any]{
        if let path = Bundle.main.path(forResource: "SwiftUIList", ofType: "plist") {
            return (NSDictionary(contentsOfFile: path) as? [String: Any]) ?? [:]
        }else {
            return [:]
        }
        
    }
}

extension Bundle {
    
    //static func configureData() -> [String: Any] {
        
       //var dataDictionary =  [String: String]
        //SwiftUIList.plist
        //let listData = Bundle.main.path(forResource: "SwiftUIList", ofType: "plist")
        //let dic = NSDictionary(contentsOfFile: listData ?? "")
        
        //return (NSDictionary(contentsOfFile: listData) as? [String : Any]) ?? [:]
        //return [:]x
        
        /*
        if let dataDic = dic {
            dataDic.allKeys.enumerated().forEach({ key in
                print("_____data:\(key)")//PickerView //VehicleSwiftUIView
            })
            //return dataDic as? [String : String]
            //cannot convert return expression of type 'NSDictionary' to return type '[String : Any]?'
            return dataDic
        }
        //return dic as [String: Any]
        */
   // }
}

public class FDExternWebViewBundle: NSObject {
    class func getBundle() -> Bundle {
        var bundle = Bundle(for: FDExternWebViewBundle.self)
        if let resourcePath = bundle.path(forResource: "FDExternWebView", ofType: "bundle") {
            if let resourcesBundle = Bundle(path: resourcePath) {
                bundle = resourcesBundle
            }
        }
        return bundle
    }

    @objc
    public class func brigeList() -> [String: [String]] {
        if let listPath = self.getBundle().path(forResource: "FDExternBridgeList", ofType: "plist") {
            return (NSDictionary(contentsOfFile: listPath) as? [String: [String]]) ?? [:]
        } else {
            return [:]
        }
    }
}

