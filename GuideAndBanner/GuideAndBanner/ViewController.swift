//
//  ViewController.swift
//  GuideAndBanner
//
//
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

    // 4. 遵循UIScrollView的协议
class ViewController: UIViewController, UIScrollViewDelegate {

    // 1. 拖拽生成控件的outlet
    @IBOutlet weak var guideScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // 2. 定义两个常量保存屏幕的宽高
    let width = UIScreen.mainScreen().bounds.width
    let height = UIScreen.mainScreen().bounds.height
    
    // 7. 定义一个button
    var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        guideScrollView.delegate = self
        
        setGuidePages()
        
        addButton()
    }

    // 3. 配置guideScrollView
    func setGuidePages() {
    
        // a. 设置scrollview的内容大小
        guideScrollView.contentSize = CGSizeMake(width * 3.0, height)
        
        // b. 将引导页图片添加到scrollview中
        for i in 1...3 {
            let imageView = UIImageView(frame: CGRectMake(width * CGFloat(i - 1), 0, width, height))
            imageView.image = UIImage(named: "guide\(i)")
            guideScrollView.addSubview(imageView)
        }
    }
    
    // 5. 实现UIScrollView的代理方法
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // a. 获得当前显示的页面
        let currentPage = Int(scrollView.contentOffset.x / width)
        
        // b. 设置页面控制器的当前页属性
        pageControl.currentPage = currentPage
        
        // c. 呈现或隐藏button
        if currentPage == 2 {
            UIView.animateWithDuration(1.5, animations: { () -> Void in
                self.goButton.layer.opacity = 1
            })
        }
        else {
            UIView.animateWithDuration(1.5, animations: { () -> Void in
                self.goButton.layer.opacity = 0
            })
        }
    }
    
    // 8. 初始化定义的button,并将它添加到scrollview中
    func addButton() {
        // a. 创建一个button,宽度为100,高度为35
        goButton = UIButton(frame: CGRectMake(width * 2.0, height - 100.0, 100, 35))
        
        // b. 让button的中心点的横坐标位于第三个页面的中心
        goButton.center.x = self.view.center.x + width * 2.0
        
        // c. 设置button的背景图和标题,以及标题在不同状态下的颜色
        goButton.setBackgroundImage(UIImage(named: "bg"), forState: UIControlState.Normal)
        goButton.setTitle("开始体验", forState: UIControlState.Normal)
        goButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        goButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        
        goButton.addTarget(self, action: "goMainPage:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // d. 把button添加到guideScrollView中
        guideScrollView.addSubview(goButton)
    }
    
    // 9. 点击button跳转到新的页面
    func goMainPage(button: UIButton) {
        
        let mainPageVC = storyboard!.instantiateViewControllerWithIdentifier("mainPage")
        self.presentViewController(mainPageVC, animated: true, completion: nil)
    }
    
}

