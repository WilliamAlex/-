//
//  Person.swift
//  day02
//
//  Created by Alex on 2016/11/24.
//  Copyright © 2016年 ShenZhenQinJin. All rights reserved.
//

/*
 一, didSet和willSet以及get:
 属性观察器:
 类似触发器, 属性观察器监控和相应属性值得变化, 每次属性变化的时候都会调用属性观察器甚至新值和旧值相同时也会调用 有几个方面:
 可以为除了延迟存储属性之外的其他存储属性添加观察器, 也可以通过重写属性的方式为继承的属性添加属性观察器
 
 1, 不仅可以在属性值变化后会触发didSet, 也可以在属性值改变前触发willSet.
 2, 在给属性添加属性观察器之前, 必须要声明清楚属性的类型是什么, 否则会编译出错
 3, 属性初始化的时候, didSet和willSet是不会调的, 只有在设置属性值得时候才会调用
 4, 即使设置时和原来的值是一样, 都会调用俩个属性观察器.
 
 注意点:
 父类的属性在自雷的构造器中被赋值时, 父类中的didSet和willSet也是会被调用的
 
 get: 计算属性的观察器
 
 */
import UIKit

class Person: NSObject {

    /// 普通属性
    var firstName: String = ""
    var lastName: String = ""
    var nickName: String = ""
    
    // 计算属性
    var fullName: String {
        
        get {
            
            // 拼接: +
            return nickName + " " + firstName + "" + lastName
        }
    }
    
    // 属性监视器(基本数据类型一定要进行初始化)
    var age: Int = 0 {
        
        //我们需要在age属性变化前做点什么
        willSet
        {
            print("Will set an new value \(newValue) to age")
        }
        //我们需要在age属性发生变化后，更新一下nickName这个属性
        didSet
        {
            print("age filed changed form \(oldValue) to \(age)")
            if age<10
            {
                nickName = "Little"
            }else
            {
                nickName = "Big"
            }
        }
    }
    
    func toString() -> String {
        
        return "Full Name : \(fullName)" + " age: \(age)"
    }
}
