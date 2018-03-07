//
//  PhotoColor.swift
//  ImageAnalysis
//
//  Created by Margis on 2018/3/4.
//  Copyright © 2018年 Margis. All rights reserved.
//

import Foundation

struct PhotoColor{
    var red: Int?
    var green: Int?
    var blue: Int?
    var colorName: String?
}

struct colors:Codable {
    let results:[colors_results]
}

struct colors_results:Codable {
    let info:info
    let image:String
}
struct info:Codable {
    let image_colors:[image_colors]
}
struct image_colors:Codable {
    let r:String
    let g:String
    let b:String
    let closest_palette_color_html_code:String
    let closest_palette_color:String
}


struct uploadedResult : Codable {
    let status : String
    let uploaded:[uploadedStruct]
}
struct uploadedStruct : Codable {
    let id : String
    let filename: String
}

struct resultList: Codable {
    let results : [results]
}
struct results: Codable {
    let tagging_id: String?
    let image: String?
    let tags: [tags]
}
struct tags: Codable {
    let confidence: Float
    let tag: String
}
struct translate: Codable {
    let trans_result : [trans_result]
}
struct trans_result: Codable {
    let src:String
    let dst:String
}
