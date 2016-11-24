//
//  ClassOne.swift
//  day02
//
//  Created by Alex on 2016/11/24.
//  Copyright © 2016年 ShenZhenQinJin. All rights reserved.
//

import UIKit

class ClassOne: NSObject {
}



// NonSubclassableParentClass这个类是不能被继承的, 只能够被访问
public class NonSubclassableParentClass {

    public func play() {
    
        print("打篮球")
    }
    
    // final 的含义是保持不变, 后面会仔细讲
    public final func comeOn() {
        print("来, 互相伤害啊")
    }
    /*
     // 在这里使用open是错误的做法, 原因是class不能够继承的, 所以类中方法的访问权限是不能高于所在类的访问权限
    open func see() {
    
        print("就看看")
    }
     */
}

/*
 // 在当前类的范围外可以被继承
 open class SubclassableParentClass {
 
 // 这个属性在当前类的的范围外不能被override
 public var size : Int
 
 // 这个方法在当前类的的范围外不能被override
 public func foo() {}
 
 // 这个方法在任何地方都可以被override
 open func bar() {}
 
 ///final的含义保持不变
 public final func baz() {}
 }
 
 
 /*****子类*****/
 // 这个写法是错误的，编译会失败
 // 因为NonSubclassableParentClass类访问权限标记的是public，只能被访问不能被继承
 class SubclassA : NonSubclassableParentClass { }
 
 // 这样写法可以通过，因为SubclassableParentClass访问权限为 `open`.
 class SubclassB : SubclassableParentClass {
 
 // 这样写也会编译失败
 // 因为这个方法在SubclassableParentClass 中的权限为public，不是`open'.
 override func foo() { }
 
 // 这个方法因为在SubclassableParentClass中标记为open，所以可以这样写
 // 这里不需要再声明为open，因为这个类是internal的
 override func bar() { }
 }
 
 open class SubclassC : SubclassableParentClass {
 // 这种写法会编译失败，因为这个类已经标记为open
 // 这个方法override是一个open的方法，则也需要表明访问权限
 override func bar() { }
 }
 
 open class SubclassD : SubclassableParentClass {
 // 正确的写法，方法也需要标记为open
 open override func bar() { }
 }
 
 open class SubclassE : SubclassableParentClass {
 // 也可以显式的指出这个方法不能在被override
 public final override func bar() { }
 }
 */

/*
 总结: 
 public修饰的类, 不能够被继承,只能够被访问
 opne修饰的类, 可以被继承也可以被访问
 
 open修饰的类中的方法: 如果方法被public修饰, 那么该方法不能够override, 如果是open修饰的方法, 可以override
 但是如果说public修饰的类中使用了open, 会报错, 原因是当前类的访问权限低于了类中方法的访问权限, 简而言之: public修饰的类中不能使用open关键字.
 
 */


/*
参考资料: http://www.jianshu.com/p/604305a61e57
*/

