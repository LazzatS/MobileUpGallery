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
        
        
        guard let token = authenticationService.token else { return }
        
        let parameters = ["photo_ids":""]
        var allParameters = parameters
        allParameters["access_token"] = token
        allParameters["v"] = API.version
        let url = self.url(from: API.photos, parameters: allParameters)
        print(url)
    }
    
    private func url(from path: String, parameters: [String: String]) -> URL {
        var components = URLComponents()
        
        // ptotocol
        components.scheme = API.scheme
        // website for request
        components.host = API.host
        // needed method
        components.path = API.photos
        // arrange order of parameters
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1)}
        
        return components.url!
    }
}
