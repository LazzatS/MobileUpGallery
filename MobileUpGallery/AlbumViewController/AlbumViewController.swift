//
//  AlbumViewController.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 29.07.2021.
//

import UIKit

class AlbumViewController: UIViewController {

    private let networkService: Networking = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parameters = ["album_ids": ""]
        networkService.request(path: API.photos, parameters: parameters, completion: { (data, error) in
            if let error = error {
                print("error while receiving data: \(error.localizedDescription)")
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let data = data else { return }
//            let json = try? JSONSerialization.jsonObject(with: data, options: [])
//            print("json: \(String(describing: json))")
            let response = try? decoder.decode(Response.self, from: data)
            print(response)
            response?.response.items.map({ (albumItem) in
                print(albumItem.title)
            })
        })
    }
}
