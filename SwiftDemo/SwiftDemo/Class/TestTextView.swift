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
		
        initUI()
    }

}

extension TestTextView {
	
	func initUI() {
		
		
		
		
		let img = UIImageView()
		
		img.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(img)
		
		NSLayoutConstraint.activate([
			img.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
			//img.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			//img.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			img.heightAnchor.constraint(equalToConstant: 90-45),
			img.widthAnchor.constraint(equalToConstant: 120)
		])
		
		img.image = self.getDrawImg()
		
		
		
		
		
		
	}
	
	
	func getDrawImg() -> UIImage {
		let text: NSString = "开启"
		let font: CGFloat = 24
		
		// let descAttr = NSMutableAttributedString(string: descStr, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor(red: 0.02, green: 0.04, blue: 0.16, alpha: 1)])
		//车主价格

		
		let textSize = text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.systemPurple])
		
		let contentSize = CGSize(width: 150-50-30, height: 72)
		
		UIGraphicsBeginImageContextWithOptions(contentSize, false, UIScreen.main.scale)
		
		let  content =  UIGraphicsGetCurrentContext()
		
		content?.setFillColor(UIColor.purple.cgColor)
		
		let path = CGMutablePath()
		path.__addRoundedRect(transform: nil, rect: CGRect(x: 0, y: 0, width: 150-50-30, height: 72), cornerWidth: font, cornerHeight: font)
		content?.addPath(path)
		content?.fillPath()
		
		text.draw(in: CGRect(x: (contentSize.width - textSize.width) / 2, y: (contentSize.height - textSize.height)/2, width: textSize.width, height: textSize.height), withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor(red: 0.02, green: 0.04, blue: 0.16, alpha: 1)])
		
		guard let img = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage()}
		UIGraphicsEndImageContext()
		//CFRelease(path)

		return img
	}
	
}
