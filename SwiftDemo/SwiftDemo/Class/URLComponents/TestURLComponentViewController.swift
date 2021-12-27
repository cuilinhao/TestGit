//
//  TestURLComponentViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2021/12/27.
//

import UIKit

class TestURLComponentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        test0()
        
    }

}

extension TestURLComponentViewController {
    
    func test0() {
        
        /*
         components?.queryItems = [
             URLQueryItem(name: "tabName", value: "searchTerm"),
             URLQueryItem(name: "fromPage", value: "辨识")
         ]
         var queryItems = [URLQueryItem]()
         queryItems = [
             URLQueryItem(name: "tabName", value: "searchTerm"),
             URLQueryItem(name: "fromPage", value: "辨识")
         ]
         */
        //queryItems.append(T##newElement: URLQueryItem##URLQueryItem)
        
        var components = URLComponents(string: "https://m-mercury-sit.nio.com/module_10009/seriesV2?header=%7B%22isShow%22%3Afalse%7D&wv=do&pageCode=C202110020002")
        components?.queryItems?.append(URLQueryItem(name: "fromPage", value: "home"))
        components?.queryItems?.append(URLQueryItem(name: "tabName", value: "美食"))
        
        
        
        print("____>>>>123\n__\(String(describing: components?.url))___-\(String(describing: components?.url))")
        
        let durl = URLComponents(string: "https://www.baidu.com?tabName=searchTerm&fromPage=%E8%BE%A8%E8%AF%86")
        print(durl?.queryItems ?? "")
    }
    
    func testURLCompones1() {
        
        let searchTerm = "obi wan kenobi"
        let format = "wookiee"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "swapi.co"
        urlComponents.path = "/api/people"
        urlComponents.queryItems = [
            URLQueryItem(name: "search", value: searchTerm),
            URLQueryItem(name: "format", value: format)
        ]
        //Optional("https://swapi.co/api/people?search=obi%20wan%20kenobi&format=wookiee")
        print(urlComponents.url?.absoluteString ?? "")
        
        //这个传false 和 ture 在 创建url 使用 relaviteto 的时候,是不一样的
        //参考
        //URLComponents(url: URL(string: "https://www.baidu.com")!, resolvingAgainstBaseURL: false)
        var url = URL.init(string: "hahaha")
        url?.appendPathComponent("users")
        
    }
    
    func test2() {
        
        let queryParams: [String: String] = [
            "search": "obi wan kenobi",
            "format": "wookie"
        ]
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "swapi.co"
        urlComponents.path = "/api/people"
        urlComponents.setQueryItems(with: queryParams)
        print(urlComponents.url?.absoluteString ?? "")
    }
    
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
    }
}
