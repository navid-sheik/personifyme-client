//
//  AppDelegate.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 24/07/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        let sendingAppID = options[.sourceApplication]
//        print("source application = \(sendingAppID ?? "Unknown")")
//
//        let pathComponents = url.pathComponents // array of path components
//
//        if url.host == "password-reset", pathComponents.count > 2 {
//            let firstComponent = pathComponents[1]
//            let secondComponent = pathComponents[2]
//            
//            print("firstComponent = \(firstComponent)")
//            print("secondComponent = \(secondComponent)")
//            
//            
//
//            // Assuming you have a reference to your UINavigationController
//            if let navigationController = self.window?.rootViewController.findNavController(){
//                let resetPasswordController = ResetPasswordViewController(userId: firstComponent, token: secondComponent)
//                navigationController.pushViewController(resetPasswordController, animated: true)
//            }
//        }
//
//        return true
//    }
    


}

