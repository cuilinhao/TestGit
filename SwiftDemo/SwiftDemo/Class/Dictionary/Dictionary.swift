//
//  Dictionary.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/2/28.
//

import Foundation
import UIKit

class TestDictionary: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .randomColor()
        //let ff = Bundle.configureData()
          
        let ff = self.test()
        
        print("______data:\(ff)")
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

