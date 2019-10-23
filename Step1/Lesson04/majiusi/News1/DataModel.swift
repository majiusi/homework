//
//  DataModel.swift
//  News1
//
//  Created by Margis on 2018/2/24.
//  Copyright © 2018年 Margis. All rights reserved.
//

struct NewsReponse: Codable {
    let status:String
    let totalResults:Int
    let articles:[articles]
}
struct articles: Codable {
    let source: ArticleSource
    let author:String?
    let title:String
    let description:String?
    let url:String
    let urlToImage:String?
    let publishedAt:String
}
struct ArticleSource:Codable {
    let name:String
}


