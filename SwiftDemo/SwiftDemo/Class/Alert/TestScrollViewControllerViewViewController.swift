//
//  TestScrollViewControllerViewViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/4/20.
//

import UIKit

class TestScrollViewControllerViewViewController: UIViewController {

    
    lazy var bgScrolleView: UIScrollView = {
        let scrol = UIScrollView()
        scrol.showsHorizontalScrollIndicator = false
        scrol.showsVerticalScrollIndicator = false
        scrol.isScrollEnabled = true
        view.addSubview(scrol)
        //scrol.contentSize = CGSize
        scrol.autoLayout(in: view, top: 0, bottom: 0, leading: 0, trailing: 0)
        return scrol
    }()
    lazy var bgImageView: UIImageView = {
        let img = UIImageView()
        //img.image = UIImage(named: "vehicle_mno_check_bg_logo", in: .vehicle, with: nil)
        img.image = UIImage(named: "111")
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .systemGreen
        bgScrolleView.addSubview(img)
        img.autoLayout(in: bgScrolleView, top: 0, bottom: nil, leading: 0, trailing: 0)
        img.autoLayout(widthRatio: 1, heightRatio: 1)
        img.autoLayout(fixingHeight: nil, fixingWidth: view.bounds.size.width)
        return img
    }()
    lazy var tipTitleLab: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.font = UIFont.systemFont(ofSize: 30)
        lab.text = "CERTIFI-CATION"
        //lab.textColor = .mp(.white)
        //lab.setAutoLineHeightText🧐("CERTIFI-CATION")
        bgImageView.addSubview(lab)
        lab.autoLayout(in: self.bgImageView, top: nil, bottom: -50, leading: 50, trailing: nil)
        lab.autoLayout(fixingHeight: nil, fixingWidth: 97)
        return lab
    }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        //$CN/$Headline/auto/H_1_Regular
        //lab.font = .nio.body1Regular
        //lab.font = .nio(1, category: .headLine)
        lab.textColor = .black
        lab.text = title ?? "请进行实名认证"
        bgScrolleView.addSubview(lab)
        lab.autoLayout(topAnchor: self.bgImageView.bottomAnchor, topMargin: 45,leadingAnchor: bgScrolleView.leadingAnchor, leadingMargin: 25, trailingAnchor: bgScrolleView.trailingAnchor, trailingMargin: -25)
        return lab
    }()
    
    var subtitle: String?
    lazy var subTitleLab: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        //lab.font = .nio.body1Regular
        lab.textColor = .black
        //lab.setAutoLineHeightText🧐(subtitle ?? "据工信部法规要求，运营商将对未实名的车辆物联网卡进行停用处理，车辆网联系统全部功能均将遭受限制。请进行实名认证")
        lab.text = "据工信部法规要求，运营商将对未实名的车辆物联网卡进行停用处理，车辆网联系统全部功能均将遭受限制。请进行实名认证"
        bgScrolleView.addSubview(lab)
        lab.autoLayout(topAnchor: self.titleLab.bottomAnchor, topMargin: 30,bottomAnchor: bgScrolleView.bottomAnchor, bottomMargin: -20, leadingAnchor: bgScrolleView.leadingAnchor, leadingMargin: 25, trailingAnchor: bgScrolleView.trailingAnchor, trailingMargin: -25)

        return lab
    }()
    
    lazy var startCertificationBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.textAlignment = .center
        btn.setTitle("开始认证", for: .normal)
        //btn.setTitleColor(.mp(.white), for: .normal)
        //字体小大 18
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = .systemYellow
        //bgScrolleView.addSubview(btn)
        view.addSubview(btn)
        btn.autoLayout(fixingHeight: 45, fixingWidth: nil)
        btn.autoLayout(in: view, top: nil, bottom: -20, leading: 25, trailing: -25)
        //btn.topAnchor.constraint(greaterThanOrEqualTo: subTitleLab.bottomAnchor, constant: 5)
        //btn.autoLayout(in: bgScrolleView, top: nil, bottom: -15, leading: 25, trailing: -25)
        //btn.autoLayout(topAnchor: subTitleLab.bottomAnchor, topMargin: 136, bottomAnchor: bgScrolleView.bottomAnchor, bottomMargin: -20, leadingAnchor: bgScrolleView.leadingAnchor, leadingMargin: 25, trailingAnchor: bgScrolleView.trailingAnchor, trailingMargin: -25)
        //btn.addTarget(self, action: #selector(tapButtonclick), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        initUI()
    }
    
    override func viewDidLayoutSubviews() {
//        self.bgScrolleView.contentSize = CGSize(width: view.bounds.width, height: 100)
    }
}

extension TestScrollViewControllerViewViewController {
    func initUI() {
        _ = bgScrolleView
        _ = bgImageView
        _ = tipTitleLab
        _ = titleLab
        _ = subTitleLab
        _ = startCertificationBtn
        
        self.bgScrolleView.backgroundColor = .systemPurple
        
    }
}


