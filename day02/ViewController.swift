//
//  ViewController.swift
//  day02
//
//  Created by Alex on 2016/11/24.
//  Copyright © 2016年 ShenZhenQinJin. All rights reserved.
//
/*
 
图片轮播器的使用:
 注意下列几个关键之的含义以及使用:

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
 
 二, fileprivate和open
 两者都是Swift3.0中心增加的两种访问控制权限.类似OC中的public和private关键字
 filePrivate: 是swift3.0才有的, 它弥补了private的不足.在3.0之前, 当使用private修饰的属性后, 在同一个文件中的不同类中还是可以访问到的, 造成了不是正真的私有属性. 而 在3.0中只要是fileprivate修饰的属性就是真正的私有属性.只能在当前类中才能使用.
 open: 也是swift3.0中出现的, 它弥补了public的不足, 通过使用open和public标记来区别某个元素在其他类中是只能被访问还是可以不overrride(重写)
 
 final: 修饰的类时, 说明类不能够被继承, 修饰属性时说明该属性不能够被重写.
 
 
 guard: 
 _ :
 translatesAutoresizingMaskIntoConstraints: 如果要实现自动布局, 那么需要将之设置为false
 NSLayoutConstraint: 原生约束类
 
 autoresizesSubviews属性:
 如果视图的autoresizesSubviews属性声明被设置为YES，则其子视图会根据autoresizingMask属性的值自动进行尺寸调整。简单配置一下视图的自动尺寸调整掩码常常就能使应用程序得到合适的行为；否则，应用程序就必须通过重载layoutSubviews方法来提供自己的实现
 
 */



import UIKit

class ViewController: UIViewController, QJLoopScrollViewDelegate {

       
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let scrollView = QJLoopScrollView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 200))
        scrollView.pageColor = UIColor.white
        scrollView.currentPageColor = UIColor.orange
        scrollView.placeHolderImage = #imageLiteral(resourceName: "zhanwei")
        scrollView.timeInterval = 2.0
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
        
            scrollView.imageArray = ["http://bangimg1.dahe.cn/forum/201511/05/073002qffz5t9twjjbaz6m.jpg",
                                     "http://tupian.enterdesk.com/2015/gha/09/1502/01.jpg",
                                     "http://img.ithome.com/newsuploadfiles/2016/3/20160317_080446_325.jpg",
                                     "http://bangimg1.dahe.cn/forum/201511/05/073002qffz5t9twjjbaz6m.jpg",
                                     "http://tupian.enterdesk.com/2015/gha/09/1502/01.jpg",
                                     "http://img.ithome.com/newsuploadfiles/2016/3/20160317_080446_325.jpg"]
        })
    }

    func didClickBannerIndex(index: Int) {
        
        print(index)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let my = Person()
        my.firstName = "William"
        my.lastName = "Alex"
        my.nickName = "Uncle"
        my.age = 24
        
        print(my.toString())
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

