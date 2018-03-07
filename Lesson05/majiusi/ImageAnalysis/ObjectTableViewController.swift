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
        
        cell.textLabel?.text = result[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
