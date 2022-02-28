//
//  TestURLComponentViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2021/12/27.
//

import UIKit



class TestURLComponentViewController: UIViewController {

    //可以使用
    private(set) lazy var blur1: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        //view.backgroundColor = .mp(.mask)
        view.alpha = 0.65
        return view
    }()
    
    
    private(set) lazy var blur22: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        view.alpha = 0.5
//        self.addSubview(view)
//        view.autoLayout(in: self, top: 0, bottom: 0, leading: 0, trailing: 0)
        let contentView = UIView()
//        contentView.backgroundColor = .mp(.mask)
        contentView.backgroundColor = .clear
        contentView.alpha = 0.001
        view.contentView.addSubview(contentView)
        contentView.autoLayout(in: view.contentView, top: 0, bottom: 0, leading: 0, trailing: 0)
        return view
    }()
    
    
    lazy var blur: UIView = {
        let effect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: effect)
        view.backgroundColor = .lightGray
        self.view.addSubview(view)
        view.autoLayout(in: self.view, top: 200, bottom: nil, leading: 0, trailing: 0)
        view.autoLayout(fixingHeight: 100, fixingWidth: nil)
        return view.contentView
    }()
    
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 19)
        view.textColor = .white
        view.backgroundColor = .systemRed
        blur.addSubview(view)
        view.autoLayout(verticallyCenteredIn: self.view, top: 10, bottom: 10, leading: nil, trailing: nil)
        view.autoLayout(leadingAnchor: self.view.leadingAnchor, leadingMargin: 15, leadingPriority: .defaultHigh,
                        trailingAnchor: self.view.trailingAnchor, trailingMargin: -15, trailingPriority: .defaultHigh)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        print("___\(UINavigationController().navigationController)")
        test0()
        let lab = UILabel()
        lab.backgroundColor = .lightGray
        
        lab.text = "hahhaa"
        lab.textColor = .white
        lab.font = .systemFont(ofSize: 20)
        self.view.addSubview(lab)
        
        lab.autoLayout(in: self.view, top: 200, bottom: nil, leading: 0, trailing: 0)
        lab.autoLayout(fixingHeight: 100, fixingWidth: nil)

        let blurEffect = UIBlurEffect.init(style: .regular)
        let effectView = UIVisualEffectView.init(effect: blurEffect)

        effectView.backgroundColor = .clear
        effectView.alpha = 0.3
        lab.addSubview(effectView)

        effectView.autoLayout(in: lab, top: 0, bottom: 0, leading: 0, trailing: 0)
        
        
//        let mask = UIView()
//        mask.backgroundColor = .red
//        mask.alpha = 0.2
//        effectView.contentView.addSubview(mask)
//        mask.autoLayout(in: effectView.contentView, top: 0, bottom: 0, leading: 0, trailing: 0)
        
        
        
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
