//
//  ClassTwo.swift
//  day02
//
//  Created by Alex on 2016/11/24.
//  Copyright © 2016年 ShenZhenQinJin. All rights reserved.
//

import UIKit

class ClassTwo: NSObject {

}

// 该类声明称final, 说明该类不具有被继承的能力.
final class Father {

    var name : String = ""
    
    // 说明age属性时不能重写的
    final var age: Int = 0
    
    // 说明该方法是不能重写的(闭包: 表示没有参数: 返回值是String类型)
    final func descripyion() -> String {
    
        return "姓名: \(name) 年龄: \(age)"
    }
    
    //定义printClass静态方法
    final class func printClass() ->() {
        
        print( "Person 打印...")
        
    }
    init(name: String, age: Int) {
        
        self.name = name
        self.age = age
    }
}

/*
 // 编译会报继承了一个final类的错, 只要是被final修饰的类都是不能够被继承的Inheritance from a finalclass 'Father'
class Son: Father {
    
    当然: 你直接去重写Fatehr中被修饰的属性或者方法都是会报错误的.
}
*/

/*
 总结: 只要是被filal修饰的属性, 方法以及类都不能够重写或者继承.保持原来的不变
 */


/*
 参考资料: http://blog.csdn.net/tonny_guan/article/details/50260189
 */
