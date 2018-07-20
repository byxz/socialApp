//
//  AppDelegate.swift
//  socialApp
//
//  Created by Mac on 10.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        AuthScreen().start(on: window)
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}
