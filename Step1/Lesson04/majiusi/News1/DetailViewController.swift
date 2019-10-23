//
//  DetailViewController.swift
//  News1
//
//  Created by Margis on 2018/2/25.
//  Copyright © 2018年 Margis. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet weak var web: WKWebView!
    var url: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url{
            if let url = URL(string: url){
                web.load(URLRequest(url: url))
            }
        }
    }
}
