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
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        
    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
}
