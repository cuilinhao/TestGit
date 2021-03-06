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
    
    var dataArray = [String]() {
        
        didSet {
            self.tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
        
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SwiftHelp"
        view.backgroundColor = .systemYellow
        let ss = SomeClass()
        ss.test()
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        loadData()
    }
}

extension TestViewControllerA {
    
    func loadData() {
        
        let listData =  Bundle.main.path(forResource: "Property List", ofType: "plist")
        let dic = NSDictionary(contentsOfFile: listData ?? "")
        if let dataDic = dic {
            self.dataArray = dataDic.value(forKey: "Function") as! [String]
        }
        
    }
}

extension TestViewControllerA: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //cell.textLabel?.text = indexPath.row.description
        cell.textLabel?.text = self.dataArray[indexPath.row]
        cell.contentView.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let vc = TestMPTextViewViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            case 1:
            let vc = TestURLComponentViewController()
            self.navigationController?.pushViewController(vc, animated: true)
		case 2:
			let vc = TestCoadbleViewController()
			self.navigationController?.pushViewController(vc, animated: true)
        default:
            debugPrint(">>>nothing <<<")
        }
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
