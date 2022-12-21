//
//  AppDelegate.swift
//  NPaySDKDemo
//
//  Created by Vu Pham on 13/06/2022. 
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: TestViewController(nibName: "TestViewController", bundle: nil))
        window?.makeKeyAndVisible()
        return true
    }


}

