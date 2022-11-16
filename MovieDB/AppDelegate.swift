//
//  AppDelegate.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NetworkMonitorService.shared.monitorNetwork()
        return true
    }
}

