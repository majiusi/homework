//
//  ViewController.swift
//  Lesson4
//
//  Created by Margis on 2019/11/17.
//  Copyright © 2019 Margis. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article]?{
        didSet{
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        repeatNews()
    }
    private func repeatNews() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines/")!
        
        let parameters:Parameters = [
            "country": "us",
            "apiKey": "a32fccf9076e41b1ae21b28e40e749fc",
        ]
        Alamofire.request(url, method: .get, parameters: parameters).responseData { (response) in
            let decoder = JSONDecoder()
            if let data = response.data {
                do {
                    let result = try decoder.decode(NewsResponse.self, from: data)
                    self.articles = result.articles
                    print(result.articles.count)
                }catch{
                    //json decode error
                }
            }else{
                //no data response
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let articles = self.articles{
            return articles.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.title.text = self.articles![indexPath.row].title
        cell.details.text = self.articles![indexPath.row].description
        if let urlToImage = self.articles![indexPath.row].urlToImage {
                if let imageUrl = URL(string: urlToImage){
                    Alamofire.request(imageUrl).responseImage { (image) in
                        if let targetImage = image.result.value{
                            cell.images.image = targetImage
                        }
                    }
                }
            }
            cell.images.image = UIImage()
            cell.images.backgroundColor = UIColor.gray
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            guard let destination = segue.destination as? DetailViewController else { return }
            guard let article = sender as? Article else { return }
            destination.url = article.url
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = self.articles![indexPath.row]
        print("url is \(article.url) ")
        performSegue(withIdentifier: "segue", sender: article)
    }
    
    
}

