//
//  ObjectTableViewController.swift
//  ImageAnalysis
//
//  Created by Margis on 2018/3/5.
//  Copyright © 2018年 Margis. All rights reserved.
//

import UIKit

class ObjectTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var result:[String] = [String]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectCell", for: indexPath) as UITableViewCell
//        cell.textLabel?.text = "我是第 \(indexPath.row) 个Cell"
        cell.textLabel?.text = result[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
