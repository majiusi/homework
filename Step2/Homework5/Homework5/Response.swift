//
//  Response.swift
//  Homework5
//
//  Created by Margis on 2019/11/26.
//  Copyright © 2019 Margis. All rights reserved.
//

import Foundation

struct Response: Codable {
    let from: String
    let to: String
    let trans_result: [Trans_result]
}
struct Trans_result: Codable {
    let src: String
    let dst: String
}
