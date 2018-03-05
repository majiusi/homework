//
//  ColorTableViewController.swift
//  ImageAnalysis
//
//  Created by Margis on 2018/3/5.
//  Copyright © 2018年 Margis. All rights reserved.
//

import UIKit

class ColorTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var result:[PhotoColor] = [PhotoColor]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as UITableViewCell
//      cell.textLabel?.text = "我是第 \(indexPath.row) 个Cell"
        cell.textLabel?.text = result[indexPath.row].colorName
        cell.textLabel?.backgroundColor = UIColor(red: CGFloat(result[indexPath.row].red!)/255,
                              green: CGFloat(result[indexPath.row].green!)/255,
                              blue: CGFloat(result[indexPath.row].blue!)/255,
                              alpha: 1.0)
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

