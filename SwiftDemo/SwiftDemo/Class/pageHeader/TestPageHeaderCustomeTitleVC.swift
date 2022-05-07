//
//  TestPageHeaderCustomeTitleVC.swift
//  MPUIKit
//
//  Created by Linhao CUI 崔林豪 on 2022/4/28.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

/*
 自定义pageHeader Title
 */



class TestPageHeaderCustomeTitleVC: UIViewController {

    private var tabItems: [SegementSlideHeader.Source] = []
    private var headerView: SegementSlideHeader?
    private var modelItems: [TabItem] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        initUI()
        loadData()
    }

}

extension TestPageHeaderCustomeTitleVC {
    func initUI() {
        let headerView = SegementSlideHeader()
        headerView.backgroundColor = .systemYellow
        view.addSubview(headerView)
        //let topY = self.navigationController?.navigationBar.frame.height
        headerView.autoLayout(in: view, top: 120, bottom: nil, leading: 0, trailing: 0)
        headerView.autoLayout(fixingHeight: 45, fixingWidth: nil)
        headerView.delegate = self
        headerView.source = self
        self.headerView = headerView
        
    }
    func setTabs(items: [TabItem]) {
        let newItems = items.map { item -> SegementSlideHeader.Source in
                .init(title: item.title!, isExpandable: false, iconSize: .zero)
        }
        self.tabItems = newItems
        try? self.headerView?.reloadData(index: 0, action: .initial)
    }
    
    func loadData() {
        (0...10).forEach { index in
            self.modelItems.append(TabItem(title: "Discover" + String(index)))
        }
        self.setTabs(items: self.modelItems)
    }
}

extension TestPageHeaderCustomeTitleVC: SegementSlideHeaderSource, SegementSlideHeaderDelegate {
    func segementSlide_tabPage(_ requester: Any, headerSourceOf index: Int) -> SegementSlideHeader.Source {
        self.tabItems[index]
    }
    
    func segementSlide_insetsOfHeader(in requester: Any) -> UIEdgeInsets {
        // 修改标题距离pageheader的间距
        .init(top: 10, left: 25, bottom: 0, right: 25)
        //.init(top: 0, left: 125, bottom: 0, right: 25)
    }
    
    func segementSlide_numberOfHeaderItems(in requester: Any) -> Int {
        self.tabItems.count
    }
    
//    func segementSlide_header(_ header: Any, normalFontAtIndex index: Int) -> UIFont {
//        //.nio.subTitle4Bold
//    }
//
//    func segementSlide_header(_ header: Any, selectedFontAtIndex index: Int) -> UIFont {
//        //.nio.subTitle2Bold
//    }
//
//    func segementSlide_header(_ header: Any, normalColorAtIndex index: Int) -> UIColor {
//        //return .nio.text.tertiary
//    }
//
//    func segementSlide_header(_ header: Any, selectedColorAtIndex index: Int) -> UIColor {
//        //return .nio.text.primary
//    }
    
    func header(_ header: SegementSlideHeader, willChangeFrom index: Int, to newIndex: Int, action: SegementSlideActionSource) {
        
    }
    
    func header(_ header: SegementSlideHeader, didChangeFrom index: Int, to newIndex: Int, action: SegementSlideActionSource) {
        //self.onSelectIndex?(newIndex)
        print("_____tap__ me___")
    }
    
    func segementSlide_header(_ header: Any, didSelectAtIndex index: Int) {
        print("_____点击了_pageHeader__")
    }
    
}



struct TabItem {
    var title: String?
}
