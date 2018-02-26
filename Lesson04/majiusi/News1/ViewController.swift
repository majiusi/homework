//
//  ViewController.swift
//  News1
//
//  Created by Margis on 2018/2/24.
//  Copyright © 2018年 Margis. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UITableViewController {
    
    var articles:[articles] = []
//    var url:String = ""
    override func viewDidLoad() {
        self.tableView.rowHeight = 200
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        request()
    }

    private func request(){
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines") else {return}
        let parameters:Parameters = [
            "country":"jp",
            "apiKey":"a3f0288b4a6c433caff54995aea77974"
        ]
        Alamofire.request(url, method: .get, parameters: parameters).responseData { [weak self](responseData) in
            do{
                print(responseData.result)
                let result = try JSONDecoder().decode(NewsReponse.self, from: responseData.data!)
                self?.articles = result.articles
                self?.tableView.reloadData()
            }catch{
                print("Error!")
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "table", for: indexPath) as! ArticleCell
        cell.titleLabel.text = articles[indexPath.row].title
        cell.detailsLabel.text = articles[indexPath.row].description
        let imageUrl = URL(string: articles[indexPath.row].urlToImage!)
        Alamofire.request(imageUrl!).responseImage { (image) in
            if let targetImage = image.result.value{
                cell.newsImage.image = targetImage
            }
        }
        cell.newsImage.image = UIImage()
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
        guard let destination = segue.destination as? DetailViewController else { return }
        guard let article = sender as? articles else { return }
        destination.url = article.url
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        print("url is \(article.url) ")
        performSegue(withIdentifier: "segue", sender: article)
    }
}

