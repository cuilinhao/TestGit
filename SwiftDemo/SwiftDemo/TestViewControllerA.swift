//
//  TestViewControllerA.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2021/12/19.
//

import UIKit
import TestFrame


class TestViewControllerA: UIViewController {
    // 数据源data
    var dataSorceArray = [Any]() {
        
        didSet {
            self.tableView.reloadData()
        }
    }

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

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SwiftDemo"
        view.backgroundColor = .systemYellow
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        loadData()
        handleData()
//        test()
        
        
    }
}

//MARK: - LoadData
extension TestViewControllerA {
    func loadData() {
        let listData = Bundle.main.path(forResource: "Property List", ofType: "plist")
        let dic = NSDictionary(contentsOfFile: listData ?? "")
        if let dataDic = dic {
            dataArray = dataDic.value(forKey: "Function") as! [String]
        }
    }
}


extension TestViewControllerA {

    func handleData() {
        for (i, _) in self.dataArray.enumerated() {
            if i <= 10 {
                self.dataSorceArray.append(self.dataArray[i])
            }
        }
    }
    
    func handleDataSource() -> [Any] {
        self.dataArray.forEach { item in
            debugPrint(item)
        }
        return [Any]()
    }
 
}

//MARK: - DataSource
extension TestViewControllerA: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSorceArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // cell.textLabel?.text = indexPath.row.description
        cell.textLabel?.text = dataSorceArray[indexPath.row] as? String
        cell.contentView.backgroundColor = UIColor.white
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
            navigationController?.pushViewController(vc, animated: true)

        case 1:
            let vc = TestURLComponentViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = TestCoadbleViewController()
            navigationController?.pushViewController(vc, animated: true)
            
            //协议
        case 3:
            let vc = TestProtocolViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            // Combine
        case 4:
            let vc = TestCombine()
            self.navigationController?.pushViewController(vc, animated: true)
            //数组
        case 5:
            let vc = TestArrayViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 6:
            //渐变
            let vc = GradientViewcontrollerViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 7:
            let vc = CoreTextViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 8:
            let vc = CountDownViewController()
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

        // self.beginAppearanceTransition(T##isAppearing: Bool##Bool, animated: T##Bool)

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
        let ff = try! JSONDecoder().decode(Double.self, from: "123.456".data(using: .utf8)!)

        print("___\(ff)")
    }
}
