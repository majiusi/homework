//
//  DetailViewController.swift
//  Lesson4
//
//  Created by Margis on 2019/11/19.
//  Copyright © 2019 Margis. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webpage: WKWebView!
    var url: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url{
            if let url = URL(string: url){
                webpage.load(URLRequest(url: url))
            }
        }

    }
    


}
