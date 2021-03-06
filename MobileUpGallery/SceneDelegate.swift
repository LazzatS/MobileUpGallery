//
//  SceneDelegate.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 27.07.2021.
//

import UIKit
import VKSdkFramework

class SceneDelegate: UIResponder, UIWindowSceneDelegate, AuthenticationServiceDelegate {

    var window: UIWindow?
    var authenticationService: AuthenticationService!
    
    static func shared() -> SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        let sd: SceneDelegate = ((scene?.delegate as? SceneDelegate)!)
        return sd
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        authenticationService = AuthenticationService()
        authenticationService.delegate = self
        if !VKSdk.initialized() {
            let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
            let nav = UINavigationController(rootViewController: loginVC)
            window?.rootViewController = nav
        } else {
            authenticationService.wakeUpSession()
            let albumVC = AlbumViewController(nibName: "AlbumViewController", bundle: nil)
            let nav = UINavigationController(rootViewController: albumVC)
            window?.rootViewController = nav
        }
        window?.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
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

    
    // MARK: Authentication Service Delegate functions
    func authenticationServiceShouldShow(viewController: UIViewController) {
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authenticationServiceSignIn() {
        let albumVC = AlbumViewController(nibName: "AlbumViewController", bundle: nil)
        let navVC = UINavigationController(rootViewController: albumVC)
        window?.rootViewController = navVC
    }
    
    func authenticationSignInFailed() {
        
    }

}

