//
//  Model.swift
//  MusicPlayer
//
//  Created by Margis on 2018/3/18.
//  Copyright © 2018年 Margis. All rights reserved.
//

import Foundation

struct FileRoot: Codable {
    let albums: [album]
}
struct album: Codable {
    let name:String
    let artist:String
    let publish:String
    let cover:String
    let brief:String
    let songs: [Song]
}
struct Song:Codable {
    let name:String
}
