//
//  AppDelegate.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/02/23.
//  Copyright © 2016年 yuki. All rights reserved.
//

import UIKit
import Parse


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
        var window: UIWindow?
    
    // View間受け渡し変数
    var userName: String?
    var userId: String?
    var password: String?
    var companyName: String?
    var companyId: String?
    var hourlyWage: String?
    


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        /* ここから */
        let storyboard: UIStoryboard = StoryboardHelper.adjust()
        print(storyboard)
        window!.rootViewController = storyboard.instantiateInitialViewController()! as UIViewController
        self.window?.makeKeyAndVisible()
        /* ここまで */
        
        Parse.setApplicationId("IXto1U8ylP17a9DDhVECVlRnI9sl7zTgIfMOLlTf",clientKey:"QmykQGFzz6Df5YC5N9ZGXBneLDmrGNvsF0DmhLA5")
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

