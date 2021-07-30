//
//  AlbumViewController.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 29.07.2021.
//

import UIKit

class AlbumViewController: UIViewController {

    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMMM YYYY"
        return dt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        fetcher.getResponse { (response) in
            guard let response = response else { return }
            response.items.map { (item) in
//                print(item.date)
                let date = Date(timeIntervalSince1970: item.date)
                let dateTitle = self.dateFormatter.string(from: date)
                print(dateTitle)
            
            }
        }
    }
}
