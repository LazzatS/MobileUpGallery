//
//  AuthenticationService.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 28.07.2021.
//

import Foundation
import VKSdkFramework

class AuthenticationService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appID = "7912820"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["email"]
        VKSdk.wakeUpSession(scope) { (state, error) in
            switch state {
            
            case .initialized:
                print("initialized and ready to be authorized")
//                VKSdk.authorize(scope)
            case .authorized:
                print("authorized and should present web view to sign in")
            default:
                fatalError(error!.localizedDescription)
            }
            
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        
    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
}
