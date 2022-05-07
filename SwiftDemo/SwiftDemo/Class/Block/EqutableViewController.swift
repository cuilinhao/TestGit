//
//  EqutableViewController.swift
//  SwiftDemo
//
//  Created by Linhao CUI 崔林豪 on 2022/3/8.
//

import UIKit

//不需要实现 Equtable 的协议 == 方法
enum KeyType: Equatable {
    case bluetooth
    case NFCCard
    case smartKey(color: SmartKeyColor? = nil)
    
    enum SmartKeyColor {
        case black,silver,brown
    }
    
}



class EqutableViewController: UIViewController {

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        let aa = KeyType.smartKey(color: nil)

        let bb = KeyType.smartKey(color: .silver)

        if aa == bb {
            print("aa == bb")
        }

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
