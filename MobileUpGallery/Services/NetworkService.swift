//
//  NetworkService.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 29.07.2021.
//

import Foundation

final class NetworkService {
    
    private let authenticationService: AuthenticationService
    
    init(authenticationService: AuthenticationService = SceneDelegate.shared().authenticationService) {
        self.authenticationService = authenticationService
    }
    
    func getPhotos() {
        var components = URLComponents()
        
        guard let token = authenticationService.token else { return }
        
        let parameters = ["photo_ids":""]
        var allParameters = parameters
        allParameters["access_token"] = token
        allParameters["v"] = API.version
        // ptotocol
        components.scheme = API.scheme
        // website for request
        components.host = API.host
        // needed method
        components.path = API.photos
        // arrange order of parameters
        components.queryItems = allParameters.map { URLQueryItem(name: $0, value: $1)}
        
        let url = components.url!
        print(url)
    }
}
