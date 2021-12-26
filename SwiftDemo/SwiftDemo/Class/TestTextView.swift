//
//  TestTextView.swift
//  SwiftDemo
//
//  Created by 崔林豪 on 2021/12/26.
//

import UIKit

class TestTextView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		
		view.backgroundColor = .lightGray
		
		let textView = UITextView()
		textView.translatesAutoresizingMaskIntoConstraints = false
		
		self.view.addSubview(textView)
		
		NSLayoutConstraint.activate([
			textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
			textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
			textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
			textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200)
		])
		textView.backgroundColor = .systemYellow
		
		textView.text = "hahhaa"
		
        
    }
    

    

}
