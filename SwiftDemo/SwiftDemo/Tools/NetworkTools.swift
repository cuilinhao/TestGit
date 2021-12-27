//
//  NetworkTools.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/7.
//

import UIKit
import Alamofire
import SwiftUI

enum MethodType {
	case get
	case post
}

class NetworkTools {

    
    

}

//MARK:-- POST
extension NetworkTools {
    
    //POST 请求
    static func requestPOSTData<Value>(_ type: MethodType, UrlString: String, parameters: [String : Value]? = nil, finishedCallBack: @escaping (_ result : Any) -> ()) where Value : Encodable {
        
        AF.request(UrlString, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).responseJSON { response in

            //debugPrint(response.value)
            //debugPrint(response.result)
            finishedCallBack(response.result)
        }
    }
    
}

//MARK:-- GET
extension NetworkTools {
    
    //GET 请求
    static func requestGETData<Value>(_ type: MethodType, UrlString: String, parameters: [String : Value]? = nil, finishedCallBack: @escaping (_ result : Any) -> ()) where Value : Encodable  {
        
        //let parameters2 = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        print(Date.getCurrentTime())
        
        AF.request(UrlString, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            
            //debugPrint(response.value ?? "")
            print(">>>>>")
            finishedCallBack(response.value)
        }
        
    }
    
    static func requestGETData2<Value>(_ type: MethodType, UrlString: String, parameters: [String : Value]? = nil, finishedCallBack: @escaping (_ result : Any) -> ()) where Value : Encodable  {
        
        //let parameters2 = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        AF.request(UrlString, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            
            //debugPrint(response.value ?? "")
            
            finishedCallBack(response.result)
        }
        
    }
    
    static func requestGETData3<Value>(_ type: MethodType, UrlString: String, parameters: [String : Value]? = nil, finishedCallBack: @escaping (_ result : Any) -> ()) where Value : Encodable  {
        
        AF.request(UrlString, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            debugPrint(response)
            
            finishedCallBack(response.result)
        }
        
    }
    
    static func requestGETData4(_ type: MethodType, UrlString: String, parameters: [String : Any]? = nil, finishedCallBack: @escaping (_ result : Any) -> ())  {
        
        AF.request(UrlString, parameters: parameters).responseJSON { response in
            debugPrint(response)
            
            finishedCallBack(response.result)
        }
        
    }
    
    
    
}

