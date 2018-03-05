//
//  ViewController.swift
//  NewsApp
//
//  Created by 王山鷹 on 2018/02/24.
//  Copyright © 2018年 ousanyo. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UITableViewController {
    
    var articles = [Article](){
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        request()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    private func request(){
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines")
            else {return}
        
//        if let url = URL(string: "https://newsapi.org/v2/top-headlines") {
//
//        } else {
//
//        }
        
        let parameters: Parameters = [
            "country": "jp",
            "apiKey": "8d011d80070749118f2e59f8f1ec4d62"
        ]
        
        Alamofire
            .request(url,
                     method: .get,
                     parameters: parameters)
            .responseData(completionHandler: { [weak self] responseData in
                let decoder = JSONDecoder()
                if let data = responseData.data {
                    do {
                        let result = try decoder.decode(NewsResponse.self, from: data)
                        self?.articles = result.articles
                    } catch {
                        // json decode error
                    }
                    
                } else {
                    // no data response
                }
            })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath) as! ArticleCell
        
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        cell.contentLabel.text = article.description
        
        return cell
    }
    
    //prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushToDetail" {
            guard let destination = segue.destination as? DetailViewController else { return }
            guard let article = sender as? Article else { return }
            
            destination.urlString = article.url
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        performSegue(withIdentifier: "pushToDetail", sender: article)
    }
    
}

