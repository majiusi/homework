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
        cell.textLabel?.text = "R:\(result[indexPath.row].red!) G:\(result[indexPath.row].green!) B:\(result[indexPath.row].blue!)"
        cell.textLabel?.backgroundColor = UIColor.darkGray
        cell.backgroundColor = UIColor(red: result[indexPath.row].red!, green: result[indexPath.row].green!, blue: result[indexPath.row].blue!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)}
}
