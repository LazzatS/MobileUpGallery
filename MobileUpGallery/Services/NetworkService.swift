//
//  NetworkService.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 29.07.2021.
//

import Foundation

protocol Networking {
    func request(path: String, parameters: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
    
    private let authenticationService: AuthenticationService
    
    init(authenticationService: AuthenticationService = SceneDelegate.shared().authenticationService) {
        self.authenticationService = authenticationService
    }
    
    func request(path: String, parameters: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authenticationService.token else { return }
        var allParameters = parameters
        allParameters["access_token"] = token
        allParameters["v"] = API.version
        let url = self.url(from: path, parameters: allParameters)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
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
