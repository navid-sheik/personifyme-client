//
//  SceneDelegate.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 24/07/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window =  UIWindow(windowScene: windowScene)
        
        let vc  =  BuyerTabController()
//        let nav  = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle =  .fullScreen
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("Open")
        guard let url = URLContexts.first?.url else {
            return
        }
        
        print(url)

        let pathComponents = url.pathComponents
        
        print(pathComponents)
        
        print("host = \(url.host)")
        
        if url.host == "payment-result" {
            
            print("payment result")
            
        }
        

        
        if url.host == "password-reset", pathComponents.count > 2 {
            let userId = pathComponents[1]
            let token = pathComponents[2]
            
            print("userId = \(userId)")
            print("token = \(token)")
            
            guard let windowScene = (scene as? UIWindowScene) else { return }
            guard let topController = windowScene.windows.first?.rootViewController?.findTopController() else {return}
            let resetPasswordController = ResetPasswordViewController(userId: userId, token: token)
            
            
            Service.shared.verifyPasswordLink(userId, token, expecting: ApiResponse<[String: String]>.self) {[weak self] result in
                guard let strongSelf = self else { return }
                
                switch result {
                case .success(let response):
                    
                    
                    let success = response.status
                    
                    print(success)
        
                    
                    if success  == "success"{
                        DispatchQueue.main.async {
                            if topController is ForgotPasswordController, let navigationController = topController.navigationController {
                                navigationController.pushViewController(resetPasswordController, animated: true)
                            } else {
                                
                                let navReset = UINavigationController(rootViewController: resetPasswordController)
                                navReset.modalPresentationStyle = .fullScreen
                                topController.present(navReset, animated: true, completion: nil)
                            }
                        }
                        
                      
                        
                    } else {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Error", message: "Expired link, please try again", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                            topController.present(alert, animated: true, completion: nil)
                        }
                    
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: "Expired link, please try again", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        topController.present(alert, animated: true, completion: nil)
                    }
                
                }
            }
//
//            if let windowScene = scene as? UIWindowScene {
//                if let topController = windowScene.windows.first?.rootViewController?.findTopController() {
//
//
//                       let resetPasswordController = ResetPasswordViewController(userId: userId, token: token)
//                       if topController is ForgotPasswordController, let navigationController = topController.navigationController {
//                           navigationController.pushViewController(resetPasswordController, animated: true)
//                       } else {
//                           topController.present(resetPasswordController, animated: true, completion: nil)
//                       }
//
//                }
//            }
            
            
        }
    }


}

