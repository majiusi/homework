//
//  DetailViewController.swift
//  NewsApp
//
//  Created by 王山鷹 on 2018/03/03.
//  Copyright © 2018年 ousanyo. All rights reserved.
//

import WebKit
import UIKit

class DetailViewController: UIViewController {
    
    var urlString: String?

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let urlString = urlString,
            let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        
    }
}

