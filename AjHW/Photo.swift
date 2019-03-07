//
//  Photos.swift
//  AjHW
//
//  Created by 劉芳瑜 on 2019/3/5.
//  Copyright © 2019 Fang-Yu. Liu. All rights reserved.
//

import Foundation

struct PhotoResponse: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [photo]
}

struct photo: Codable {
    let id: String
    let title: String
    let server: String
    let farm: Int
    let secret: String
    
    var imageURLString: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg"
    }
    var isFavorite: Bool?
}
