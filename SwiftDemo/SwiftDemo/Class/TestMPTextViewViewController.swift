//
//  TestMPTextViewViewController.swift
//  SwiftDemo
//
//  Created by 崔林豪 on 2021/12/26.
//

import UIKit

class TestMPTextViewViewController: UIViewController {

	//MARK: - Lazy load
	lazy var contentView: UIView = {
		let contentView = UIView()
		contentView.backgroundColor = .lightGray
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		return contentView
	}()
	
	lazy var textView: MPTextView = {
		
		let textView = MPTextView()
		
		textView.backgroundColor = .systemPurple
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.font = .systemFont(ofSize: 24)
		//textView.text = "this is a testSDK积分换快递费testSDK积分换快递费款式都建行卡圣诞节疯狂京东数科水电费即可水电费卡大杀四方京东数科极客水电费即\neerer"
		//textView.text = "this a test"
		textView.placeholder = "121212this is a testSDK积分换快递费testSDK积分换快递费款式都建行卡圣诞节疯狂京东数科水电费即可水电费卡大杀四方京东数科极客水电费"
		//textView.placeholder = "121212"

		//内容缩进为0（去除左右边距
//		textView.textContainer.lineFragmentPadding = 0
//		//去除上下间距
//		textView.textContainerInset = .zero
		return textView
	}()
	
	lazy var label: UILabel = {
		let lab = UILabel()
		lab.text = "test"
		lab.textColor = .systemYellow
		lab.backgroundColor = .lightGray
		lab.font = .systemFont(ofSize: 20)
		lab.translatesAutoresizingMaskIntoConstraints = false
		return lab
	}()
	
	//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "MPTextView"
		view.backgroundColor = .white
		
		initUI()
		
		textView.text = "this is a testSDK积分换快递费testSDK积分换快递费款式都建行卡圣诞节疯狂京东数科水电费即可水电费卡大杀四方京东数科极客水电费即\neererthis is a testSDK积分换快递费testSDK积分换快递费款式都建行卡圣诞节疯狂京东数科水电费即可水电费卡大杀四方京东数科极客水电费即\neererthis is a testSDK积分换快递费testSDK积分换快递费款式都建行卡圣诞节疯狂京东数科水电费即可水电费卡大杀四方京东数科极客水电费即\neererthis is a testSDK积分换快递费testSDK积分换快递费款式都建行卡圣诞节疯狂京东数科水电费即可水电费卡大杀四方京东数科极客水电费即\neerer"
		
		
	}
	
}

extension TestMPTextViewViewController {
	
	func initUI() {
		
		view.addSubview(contentView)
		
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 500),
			contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
			//contentView.heightAnchor.constraint(equalToConstant: 200)
		])
		
		// 一行 37
		print("__hhhh:__\(textView.contentSize.height)")
		contentView.addSubview(textView)
		
		let height = ("textView.text" as NSString).boundingRect(
			with: CGSize(width: view.bounds.width - 40, height: .infinity),
			options: [.usesLineFragmentOrigin, .usesFontLeading],
			attributes: [.font : UIFont.systemFont(ofSize: 24.0)],
			context: nil
		).height.rounded(.up)
		
		print("____\(height)")
		
		NSLayoutConstraint.activate([
			textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
			textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			//5行 144.0
			//textView.heightAnchor.constraint(equalToConstant: height * 5),
			textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
		
	}
}


extension TestMPTextViewViewController {
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let vc = TestTextView()
		
		self.present(vc, animated: true, completion: nil)
	}
}

