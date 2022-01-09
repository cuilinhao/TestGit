//
//  TestNSObjectProtocol.swift
//  SwiftDemo
//
//  Created by 崔林豪 on 2022/1/9.
//

import UIKit


class MyClass {
	
}

class TestNSObjectProtocol: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = UIColor.randomColor()
		
		
		//let obj = MyClass()
		
		// Error: Value of type 'MyClass' has no member 'isKindOfClass'
		//obj.isKindOfClass(MyClass.self)
		
		//如果我将实例转换为 AnyObject ，我的对象现在符合 NSObjectProtocol我可以调用协议(protocol)定义的实例方法:
		
		let obj: AnyObject = MyClass()
		
		let aa =  obj.isKind(of: MyClass.self)

		let bb =  obj.conforms(to: NSObjectProtocol.self)

		let cc =  obj.isKind(of: NSObject.self)
		
		//___true___true__false
		print("___\(aa)___\(bb)__\(cc)")
    }
}

/**
 
 //对象不是从 NSObject 继承的，但仍符合 NSObjectProtocol .怎么样AnyObject符合 NSObjectProtocol ?
 
 在 Cocoa/Objective-C 世界中，AnyObject 是 id .将此对象转换为 AnyObject 后，您可以向其发送任何已知的 Objective-C 消息，例如 isKindOfClass或 conformsToProtocol .现在，当你说 isKindOfClass或 conformsToProtocol ，你已经不在 Swift 的世界里了；你正在用 Objective-C 与 Cocoa 交谈。所以想一想Objective-C 是如何看待这个对象的。 Objective-C 世界中的所有类都来自某个基类；像 MyClass 这样的无根据的类是不可能的。并且 Objective-C 世界中的每个基类都符合 NSObject 协议(protocol)(Swift 称之为 NSObjectProtocol)；这就是成为(或继承)基类的意义所在!因此，为了让它进入 Objective-C 世界，Swift 将 MyClass 呈现为一个特殊的桥接基类 SwiftObject 的后代，该基类确实符合 NSObjectProtocol(如您所见:https://github.com/apple/swift/blob/master/stdlib/public/runtime/SwiftObject.mm)。

 关于swift - AnyObject 如何符合 NSObjectProtocol？，我们在Stack Overflow上找到一个类似的问题： https://stackoverflow.com/questions/36851866/
 
 */
extension TestNSObjectProtocol {
	
}
