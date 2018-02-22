//
//  ViewController.swift
//  alamofireTest
//
//  Created by Margis on 2018/2/21.
//  Copyright © 2018年 Margis. All rights reserved.
//

import UIKit
import Alamofire


struct oneMoreTest:Decodable {
    let name:String
    let region:String
}
var structLibs = [oneMoreTest]()
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var structLibs = [oneMoreTest]()
        let url = URL(string: "https://restcountries.eu/rest/v2/all")
        Alamofire.request(url!).responseData{response in
            let result = response.data
            do{
                structLibs = try JSONDecoder().decode([oneMoreTest].self, from: result!)
                for structLib in structLibs{
                    print(structLib.name,"-",structLib.region)
                    print(structLibs.count)
                }
            }catch{
                print("ERROR!")
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushToTableView" {
            let theNextStructLibs = segue.destination as! TableViewController
            // 问题点 我想把structLibs传到tableViewControler 但好像传不过去 
            theNextStructLibs.structLibs = structLibs
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

