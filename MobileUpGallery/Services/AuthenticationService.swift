//
//  AuthenticationService.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 28.07.2021.
//

import Foundation
import VKSdkFramework

class AuthenticationService: NSObject {
    
    private let appID = "7912820"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
    }
}
