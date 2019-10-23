//
//  ViewController.swift
//  Lession3_TableViewControl
//
//  Created by Margis on 2018/2/10.
//  Copyright © 2018年 Margis. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let array = ["张三,男","李四,女","王五,男","小六,女","小七,男","黑桃八,男"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 6 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Table1", for: indexPath)
            cell.textLabel?.text = "\(array[0].split(separator: ",")[0])"
            cell.detailTextLabel?.text = "\(array[0].split(separator: ",")[1])"
            return cell
        }else if indexPath.row % 6 == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Table2", for: indexPath)
            cell.textLabel?.text = "\(array[1].split(separator: ",")[0])"
            cell.detailTextLabel?.text = "\(array[1].split(separator: ",")[1])"
            return cell
        }else if indexPath.row % 6 == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Table1", for: indexPath)
            cell.textLabel?.text = "\(array[2].split(separator: ",")[0])"
            cell.detailTextLabel?.text = "\(array[2].split(separator: ",")[1])"
            return cell
        }else if indexPath.row % 6 == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Table2", for: indexPath)
            cell.textLabel?.text = "\(array[3].split(separator: ",")[0])"
            cell.detailTextLabel?.text = "\(array[3].split(separator: ",")[1])"
            return cell
        }else if indexPath.row % 6 == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Table1", for: indexPath)
            cell.textLabel?.text = "\(array[4].split(separator: ",")[0])"
            cell.detailTextLabel?.text = "\(array[4].split(separator: ",")[1])"
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Table2", for: indexPath)
            cell.textLabel?.text = "\(array[5].split(separator: ",")[0])"
            cell.detailTextLabel?.text = "\(array[5].split(separator: ",")[1])"
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }

}

