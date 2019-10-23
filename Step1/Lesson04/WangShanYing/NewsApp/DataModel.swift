//
//  DataModel.swift
//  NewsApp
//
//  Created by 王山鷹 on 2018/03/03.
//  Copyright © 2018年 ousanyo. All rights reserved.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: ArticleSource
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
}

struct ArticleSource: Codable {
    let name: String
}
