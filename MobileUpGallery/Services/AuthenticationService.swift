//
//  AuthenticationService.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 28.07.2021.
//

import Foundation
import VKSdkFramework

protocol AuthenticationServiceDelegate: class {
    func authenticationServiceShouldShow(viewController: UIViewController)
    func authenticationServiceSignIn()
    func authenticationSignInFailed()
}

class AuthenticationService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appID = "7912820"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    weak var delegate: AuthenticationServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    func wakeUpSession() {
        let scope = ["email"]
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            switch state {
            
            case .initialized:
                print("initialized and ready to be authorized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized and should present web view to sign in")
                delegate?.authenticationServiceSignIn()
            default:
                delegate?.authenticationSignInFailed()
            }
            
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.authenticationServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.authenticationSignInFailed()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authenticationServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
}
