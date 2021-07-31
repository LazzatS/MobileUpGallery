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
//    let ownerId: String
//    let albumId: String
    let date: Double
    let sizes: [PhotoInfo]
}

struct PhotoInfo: Decodable {
    let url: String
    var type: String
}
