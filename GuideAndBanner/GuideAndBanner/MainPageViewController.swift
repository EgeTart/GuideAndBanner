//
//  MainPageViewController.swift
//  GuideAndBanner
//
//  
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UIScrollViewDelegate {

    // 1. 与控件绑定的outlet
    @IBOutlet weak var bannerScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // 2. 指示当前页面变量
    var currentPage = 0
    
    // 5. 定义一个定时器变量
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBanner()
        
        addTimer()
    }
    
    // 3. 配置广告栏
    func configureBanner() {
        
        let width = self.view.frame.width
        let height = width / 32.0 * 13
        
        bannerScrollView.delegate = self
        bannerScrollView.contentSize = CGSizeMake(width * 5.0, height)
        
        for i in 1...5 {
            
            let imageView = UIImageView(frame: CGRectMake(width * CGFloat(i - 1), 0, width, height))
            imageView.image = UIImage(named: "banner\(i)")
            bannerScrollView.addSubview(imageView)
            
        }
    }
    
    // 4. 实现UIScrollView的代理方法
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / self.view.frame.width)
        pageControl.currentPage = currentPage
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
    // 6. 使用定时器实现广告轮播
    func addTimer() {
        // 构造一个定时器,每个3秒调用nextBanner()函数.这个操作会重复执行
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "nextBanner", userInfo: nil, repeats: true)
    }
    
    func removeTimer() {
        // 让定时器不可用
        timer.invalidate()
    }
    
    // 7. 呈现下一个广告
    func nextBanner() {
        
        if currentPage == 4 {
            currentPage = 0
        }
        else {
            currentPage++
        }
        
        pageControl.currentPage = currentPage
        
        let offset = CGFloat(currentPage) * self.view.frame.width
        bannerScrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }

}
