//
//  Albums.swift
//  musicPlayer
//
//  Created by 王山鷹 on 2018/03/18.
//  Copyright © 2018年 ousanyo. All rights reserved.
//

import Foundation

struct FileRoot: Codable {
    let albums: [Album]
}

struct Album: Codable {
    let name: String
    let artist: String
    let publish: String
    let cover: String
    let brief: String
    let songs: [Song]
}

struct Song: Codable {
    let name: String
}
