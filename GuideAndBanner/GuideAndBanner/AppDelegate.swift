//
//  AppDelegate.swift
//  GuideAndBanner
//
//  
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 10. 检测是否第一次运行
        let firstLuanch = !NSUserDefaults.standardUserDefaults().boolForKey("notFirstLuanch")
        
        if firstLuanch == true {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "notFirstLuanch")
        }
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainPageVC = storyboard.instantiateViewControllerWithIdentifier("mainPage")
            window?.rootViewController = mainPageVC
        }
        
        return true
    }

}

