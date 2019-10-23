//
//  DetailTableViewController.swift
//  MusicPlayer
//
//  Created by Margis on 2018/3/21.
//  Copyright © 2018年 Margis. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    var name: String?
    var artist: String?
    var publish: String?
    var image: String?
    var songs : [Song] = []
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ArtistLabel: UILabel!
    @IBOutlet weak var PublishLabel: UILabel!
    @IBOutlet weak var Image: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NameLabel.text = name
        ArtistLabel.text = artist
        PublishLabel.text = publish
        
        guard let img = image else {
            return
        }
        let subValues = img.split(separator: ".")
        let value = subValues.first?.description
        Image.image = UIImage(named: value!)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "table")!
        print(songs[indexPath.row].name)
        cell.textLabel?.text = songs[indexPath.row].name
        return cell
    }
}
