//
//  ViewController.swift
//  tableViewPro
//
//  Created by 王山鷹 on 2018/02/10.
//  Copyright © 2018年 ousanyo. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.row % 2 == 0 {
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
//            return cell
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "identifier2", for: indexPath)
//            return cell
//        }

//    }
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        
        let title = cell.viewWithTag(100) as! UILabel
        let detail = cell.viewWithTag(200) as! UILabel
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.brown
        }
        
        if indexPath.row % 6 == 0 {
            title.text = "王　山鷹"
            detail.text = "男"
        }else if indexPath.row % 6 == 1 {
            title.text = "ma jiusi"
            detail.text = "男"
        }else if indexPath.row % 6 == 2 {
            title.text = "yan xiaoning"
            detail.text = "女"
        }else if indexPath.row % 6 == 3 {
            title.text = "na renhu"
            detail.text = "女"
        }else if indexPath.row % 6 == 4 {
            title.text = "wang hongzhang"
            detail.text = "男"
        }else if indexPath.row % 6 == 5 {
            title.text = "wu han"
            detail.text = "男"
        }
        return cell
    }
}

