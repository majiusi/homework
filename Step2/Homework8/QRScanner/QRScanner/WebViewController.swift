//
//  WebViewController.swift
//  QRScanner
//
//  Created by 马九思 on 2019/12/23.
//  Copyright © 2019 马九思. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
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
