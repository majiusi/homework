//
//  MusicViewController.swift
//  musicPlayer
//
//  Created by 王山鷹 on 2018/03/18.
//  Copyright © 2018年 ousanyo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MusicViewController: UICollectionViewController {
    
    var fileData: FileRoot? {
        didSet {
            collectionView?.reloadSections([2])
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        if let path = Bundle.main.path(forResource: "albums", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                fileData =  try decoder.decode(FileRoot.self, from: data)
            }catch {
                print("parse error !!!")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using [segue destinationViewController].
         Pass the selected object to the new view controller.
    }
    */

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
            return 21
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        
        let cell: UICollectionViewCell
        
        switch indexPath.section {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "adCell", for: indexPath)
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath)
            if let cell = cell as? ButtonCell {
                switch indexPath.item {
                case 0:
                    cell.button.setBackgroundImage(#imageLiteral(resourceName: "fm"), for: .normal)
                    cell.button.setTitle(nil, for: UIControlState .normal)
                    cell.label.text="FM"
                case 1:
                    cell.button.setBackgroundImage(#imageLiteral(resourceName: "suggest"), for: .normal)
                    cell.button.setTitle(nil, for: UIControlState .normal)
                    cell.label.text="SUGGEST"
                case 2:
                    cell.button.setBackgroundImage(#imageLiteral(resourceName: "list"), for: .normal)
                    cell.button.setTitle(nil, for: UIControlState .normal)
                    cell.label.text = "LIST"
                case 2:
                    cell.button.setBackgroundImage(#imageLiteral(resourceName: "rank"), for: .normal)
                    cell.button.setTitle(nil, for: UIControlState .normal)
                    cell.label.text = "RANK"
                default:
                    break
                }
            }
            
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath)
        default:
            fatalError()
        }
    
        return cell
    }
    


    // MARK: UICollectionViewDelegate

   

}

extension MusicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: 500,height: 100)
        case 1:
            return CGSize(width: 80,height: 80)
        case 2:
            return CGSize(width: 100,height: 100)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 1:
            return 10
        case 2:
            return 5
        default:
            return 0
        }
    }
    
}

