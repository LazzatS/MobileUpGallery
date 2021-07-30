//
//  Album.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 30.07.2021.
//

import Foundation

struct Response: Decodable {
    let response: Album
}

struct Album: Decodable {
    let items: [AlbumInfo]
}

struct AlbumInfo: Decodable {
    var title: String?
}
