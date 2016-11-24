//
//  QJLoopScrollView.swift
//  day02
//
//  Created by Alex on 2016/11/24.
//  Copyright © 2016年 ShenZhenQinJin. All rights reserved.
//

/*
 注意点:
 1. 在声明属性时, 用的是var关键词
 2. 并且是可选类型
 3, 在定义变量时一定要初始化
 4, 如果是声明基本数据类型时,一定要进行初始化, 非基本数据类型一定是可选类型
 5, 在编写代码过程中尽量写let, 如果有值得改变, 系统会提示需要修改成var
 
 
 // 定义枚举的方式一
 enum QJPageContrilAlignment {
 
 // 左边
 case left
 
 // 中间
 case center
 
 // 右边
 case right
 }
 */

import UIKit
import Kingfisher


/// 定义枚举的方式二
/// 分页圆点的位置枚举
enum QJPageContrilAlignment {
    
    case left, center, right
}

/// 委托代理
protocol QJLoopScrollViewDelegate : NSObjectProtocol {

    /// 点击轮播器中对应的图片
    func didClickBannerIndex(index : Int)
}

class QJLoopScrollView: UIView {

    // MARK: - 声明属性
    
    /// 代理
    weak var delegate : QJLoopScrollViewDelegate?
    
    /// 占位图
    var placeHolderImage : UIImage?
    
    /// pageControl的位置(默认是中间)
    var pageAlignment : QJPageContrilAlignment = .center
    
    /// 宽
    fileprivate var kWidth: CGFloat = 0
    
    /// 高
    fileprivate var kHeight: CGFloat = 0
    
    /// 轮播器滚动时间间隔(默认是两秒)
    var timeInterval : TimeInterval = 2
    
    /// 定时器
    fileprivate var timer : Timer?
    
    /// 图片数组
    var imageArray: [String]? {
    
        didSet{
        
            setUpUI()
            
            // ?? : 表示如果数组中有值, 就返回数组的个数, 否则就返回0
            pages.numberOfPages = imageArray?.count ?? 0
        }
    }
    
    
    /// currentPageControl
    var currentPageColor: UIColor = UIColor.white {
        
        didSet {
            pages.currentPageIndicatorTintColor = currentPageColor
        }
    }
    
    /// pageControl的颜色(默认是白色)
    var pageColor: UIColor = UIColor.lightGray {
        
        didSet {
            pages.pageIndicatorTintColor = pageColor
        }
    }
    
    // MARK: -懒加载
    
    /// pageControl
    fileprivate lazy var pages: UIPageControl = {

        let page = UIPageControl()
        page.hidesForSinglePage = true
        return page
    }()

    
    /// scrollView
    fileprivate lazy var scrolliew: UIScrollView = {
    
        let view : UIScrollView = UIScrollView(frame: self.bounds)
        view.delegate = self
        view.autoresizesSubviews = true
        view.isPagingEnabled = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    /// 放图片的imageView
    fileprivate var rollImageView: UIImageView? {
    
        didSet {
        
            rollImageView?.isUserInteractionEnabled = true
            
            // 添加手势
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapBanner))
            rollImageView?.addGestureRecognizer(tap)
        }
    }
    
    /// 初始化
   override init(frame: CGRect) {
        
        super.init(frame: frame)
        kWidth = self.bounds.size.width
        kHeight = self.bounds.size.height
        addSubview(scrolliew)
        addSubview(pages)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - 事件处理
    @objc func tapBanner() {
    
        self.delegate?.didClickBannerIndex(index: pages.currentPage + 1)
    }
    
    @objc func nextPage() {
        
        if self.superview == nil {
            removeTimer()
        } else {
            self.scrolliew.scrollRectToVisible(CGRect(x:self.scrolliew.contentOffset.x + self.kWidth, y: 0, width: self.kWidth, height: self.kHeight), animated: true)
        }
    }
}

// MARK: -UIScrollViewDelegate
extension QJLoopScrollView : UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let count = imageArray?.count else {
            return
        }
        if scrollView.contentOffset.x == 0 {
            self.scrolliew.contentOffset = CGPoint(x: CGFloat(count) * kWidth, y: 0)
        } else if scrollView.contentOffset.x == (CGFloat(count) + 1) *   kWidth {
            self.scrolliew.contentOffset = CGPoint(x: kWidth, y: 0)
        } else {
            //修改pageControl的偏移
            let pageNum = Int(scrollView.contentOffset.x / kWidth) - 1
            pages.currentPage = pageNum
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}

/// 界面布局
extension QJLoopScrollView {

    fileprivate func setUpUI() {
    
        // 判断原来是否有值,如果有值就移除,再创建新值
        if scrolliew.subviews.count > 0 {
            
            for view in scrolliew.subviews {
                
                view.removeFromSuperview()
            }
        }
        self.backgroundColor = UIColor.lightGray
        guard let imageArray = imageArray else {
            return
        }
        
        // 数组中的count决定page的个数
        let count = imageArray.count
        
        // 设置pageControl
        pages.translatesAutoresizingMaskIntoConstraints = false
        
        // 判断pageControl的位置
        if pageAlignment == .center {
            
            addConstraints([NSLayoutConstraint(item: pages, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)])
            addConstraints([NSLayoutConstraint(item: pages, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)])
            
        } else if pageAlignment == .left {
            addConstraint(NSLayoutConstraint(item: pages, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 10))
            addConstraint(NSLayoutConstraint(item: pages, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        } else {
            addConstraint(NSLayoutConstraint(item: pages, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -10))
            addConstraint(NSLayoutConstraint(item: pages, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        }
        
        /// 第一个放最后一张图片
        
        var urls = imageArray[count - 1]
        rollImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeight))
        
        // 下载图片
        rollImageView?.kf.setImage(with: URL(string : urls), placeholder: placeHolderImage, options: nil, progressBlock: nil, completionHandler: nil)
        scrolliew.addSubview(rollImageView!)
        
        if count > 1 {
            
            scrolliew.contentSize = CGSize(width: (CGFloat(count) + 2) * kWidth, height: kHeight)
            scrolliew.contentOffset = CGPoint(x: kWidth, y: 0)
            
            /// 最后一个放第一张图片
            urls = imageArray[0]
            rollImageView = UIImageView(frame: CGRect(x: (CGFloat(count) + 1) * kWidth, y: 0, width: kWidth, height: kHeight))
            rollImageView?.kf.setImage(with: URL(string: urls), placeholder: placeHolderImage, options: nil, progressBlock: nil, completionHandler: nil)
            scrolliew.addSubview(rollImageView!)
            
            for i in 0..<count {
                
                urls = imageArray[i]
                rollImageView = UIImageView(frame: CGRect(x: kWidth * CGFloat(i + 1), y: 0, width: kWidth, height: kHeight))
                rollImageView?.kf.setImage(with: URL(string: urls), placeholder: placeHolderImage, options: nil, progressBlock: nil, completionHandler: nil)
                scrolliew.addSubview(rollImageView!)
        }
     }else {
            
            scrolliew.contentSize = CGSize(width: (CGFloat(count)) * kWidth, height: kHeight)
            scrolliew.contentOffset = CGPoint(x:0, y: 0)
        }
        
        if timer == nil {
            
            addTimer()
        }
    }
    
    /// 添加定时器
    fileprivate func addTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
    }
    /// 移除定时器
    fileprivate func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
}






















