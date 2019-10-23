//
//  MusicViewController.swift
//  MusicPlayer
//
//  Created by Margis on 2018/3/18.
//  Copyright © 2018年 Margis. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MusicViewController: UICollectionViewController {
    var fileData: FileRoot!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "albums", ofType: "json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath:path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                fileData = try decoder.decode(FileRoot.self, from: data)
                
            }catch{
                print("parse error")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        case 2:
            return fileData.albums.count
        default:
            return 0   
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell
        
        // Configure the cell
        switch indexPath.section {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "adCell", for: indexPath)
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath)
            if let cell = cell as? ButtonCell{
                switch indexPath.item{
                case 0:
                    cell.buttonViewLabel.text = "私人FM"
                    cell.buttonViewButton.setTitle(nil, for: .normal)
                    cell.buttonViewButton.setBackgroundImage(#imageLiteral(resourceName: "fm"), for: .normal)
                case 1:
                    cell.buttonViewLabel.text = "每日推荐"
                    let calendar = Calendar.current
                    let now = Date()
                    let day = calendar.component(.day, from: now)
                    cell.buttonViewButton.setTitle("\(day)", for: .normal)
                    cell.buttonViewButton.setBackgroundImage(#imageLiteral(resourceName: "suggest"), for: .normal)
                case 2:
                    cell.buttonViewLabel.text = "歌单"
                    cell.buttonViewButton.setTitle(nil, for: .normal)
                    cell.buttonViewButton.setBackgroundImage(#imageLiteral(resourceName: "list"), for: .normal)
                case 3:
                    cell.buttonViewLabel.text = "排行榜"
                    cell.buttonViewButton.setTitle(nil, for: .normal)
                    cell.buttonViewButton.setBackgroundImage(#imageLiteral(resourceName: "rank"), for: .normal)
                default:
                    break
                }
            }
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath)
            if let cell = cell as? AlbumCell{
                cell.albumCellImage.image = UIImage(named: "cover\(indexPath.row + 1)")
                cell.albumCellLabel.text = fileData.albums[indexPath.row].name
            }
        default:
            fatalError()
        }
        
        return cell
    }
    
}
extension MusicViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        switch indexPath.section {
        case 0:
            let ratio = CGFloat(170)/CGFloat(740)
            return CGSize(width: screenWidth, height: screenWidth * ratio)
        case 1:
            let cellWidth = (screenWidth - 30)/4
            let cellHeight = cellWidth
            return CGSize(width: cellWidth, height: cellHeight)
        case 2:
            let cellWidth = (screenWidth - 20)/3
            let cellHeight = cellWidth + 44
            return CGSize(width: cellWidth, height: cellHeight)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 2:
            return 10
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 1:
            return 10
        case 2:
            return 10
        default:
            return 0
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let data = sender as! album
            print(data.artist)
            print(data.name)
            print(data.cover)
            let target = segue.destination as! DetailTableViewController
            target.artist = data.artist
            target.name = data.name
            target.publish = data.publish
            target.image = data.cover
            target.songs = data.songs
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
//            print(indexPath.row)
            performSegue(withIdentifier: "segue", sender: fileData.albums[indexPath.row])
        }
    }
    
    
}
