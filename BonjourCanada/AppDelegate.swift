//
//  AppDelegate.swift
//  BonjourCanada
//
//  Created by Jyoti Saini on 24/09/20.
//  Copyright © 2020 Jyoti Saini. All rights reserved.
//

import UIKit
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var reachability: Reachability!
    
    func application(_
        application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupReachability()
        return true
    }
    
    func setupReachability() {
        
       reachability = try? Reachability()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
           
           let reachability = note.object as? Reachability
           
           switch reachability?.connection {
           case .wifi, .cellular: print("Reachable");NotificationCenter.default.post(name:
               Notification.Name("Online"), object: nil)
               
           case .unavailable: print("Network not reachable"); NotificationCenter.default.post(name:
               Notification.Name("Offline"), object: nil)
           case .some(.none):
               break
           case .none:
               break
           }
           
       }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded
        // while the application was not running, this
        // will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
