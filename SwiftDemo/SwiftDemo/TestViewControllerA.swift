//
//  TestViewControllerA.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2021/12/19.
//

import UIKit


//协议定义

//协议定义通过关键字protocol
protocol SomeProtocol {
    //协议定义
    func test()
}


//类实现协议和继承父类，协议一般都写在父类后面
class SomeSuperclass: SomeProtocol {
    func test() {
        print("__test")
    }
    
    //父类定义
}

class SomeClass: SomeSuperclass{
    //子类定义
}

class TestViewControllerA: UIViewController {

	
	lazy var tableView: UITableView = {
		
		let tableView = UITableView()
		
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		 
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		return tableView
		
	}()
	
	//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPurple
        let ss = SomeClass()
        ss.test()
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
		
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
		
		tableView.backgroundColor = .systemPurple
		
		testURLCompones1()
    }
}

extension TestViewControllerA: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 20 + 20
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		cell.textLabel?.text = indexPath.row.description
		
		return cell
	}
	
	
	
 func tableView(_ tableView: UITableView,
				   heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 45
	}
		
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
}

extension TestViewControllerA {
	
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
		
		
		print(urlComponents.url?.absoluteString)

		
	}

}



extension TestViewControllerA {
	
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		print(">>>>>viewDidAppear")
		
		//self.beginAppearanceTransition(T##isAppearing: Bool##Bool, animated: T##Bool)

		let num1 = NSDecimalNumber(string: "123.456")
		let numaa = Decimal(123.456)
		
		let numbb = Decimal(string: "123.45")
		
		print("---\(num1)____\(numaa)___\(numbb)")
		let num: NSNumber = 123.456
		
		let num2 = NSDecimalNumber(decimal: num.decimalValue)
		let numberFormatter = NumberFormatter()
		
		numberFormatter.positiveFormat = "##,###.##"
		numberFormatter.numberStyle = .decimal
		numberFormatter.roundingMode = .floor
		
		let amountStr1 = numberFormatter.string(from: num1) ?? "--"
		print(amountStr1)
		let amountStr2 = numberFormatter.string(from: num2) ?? "--"
		print(amountStr2)
		
		// fontName:"Avenir-Black" size:18
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		print(">>>>>viewWillDisappear")
	}
	
}


extension TestViewControllerA {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let ff =  try! JSONDecoder().decode(Double.self, from: "123.456".data(using: .utf8)!)
        
        print("___\(ff)")
    }
}
