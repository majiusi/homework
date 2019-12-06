//
//  CalendarController.swift
//  Homework6
//
//  Created by Margis on 2019/12/01.
//  Copyright © 2019 Margis. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "Cell"

class CalendarController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var monthView = UIView()
    var monthLabel = UILabel()
    var buttonleft = UIButton()
    var buttonright = UIButton()
    var Mon = UILabel()
    var Tue = UILabel()
    var Wes = UILabel()
    var Thu = UILabel()
    var Fri = UILabel()
    var Sat = UILabel()
    var Sun = UILabel()
    
    var collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        monthView = UIView(frame: .zero)
        monthLabel = UILabel(frame: .zero)
        buttonleft = UIButton(frame: .zero)
        buttonright = UIButton(frame: .zero)
        Mon = UILabel(frame: .zero)
        Tue = UILabel(frame: .zero)
        Wes = UILabel(frame: .zero)
        Thu = UILabel(frame: .zero)
        Fri = UILabel(frame: .zero)
        Sat = UILabel(frame: .zero)
        Sun = UILabel(frame: .zero)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(monthView)
        view.addSubview(monthLabel)
        view.addSubview(buttonleft)
        view.addSubview(buttonright)
        view.addSubview(Mon)
        view.addSubview(Tue)
        view.addSubview(Wes)
        view.addSubview(Thu)
        view.addSubview(Fri)
        view.addSubview(Sat)
        view.addSubview(Sun)
        view.addSubview(collection)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collection.dataSource = self
        collection.delegate = self
        monthView.backgroundColor = .lightGray
        monthView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(150)
        }
        monthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(monthView.snp.top).offset(100)
            make.centerX.equalTo(monthView.snp.centerX)
        }
        monthLabel.text = "2019/12"
        monthLabel.textColor = .white
        buttonleft.snp.makeConstraints { (make) in
            make.top.equalTo(monthView.snp.top).offset(90)
            make.left.equalTo(monthView.snp.left)
        }
        buttonleft.setTitle("<", for: .normal)
        buttonright.snp.makeConstraints { (make) in
            make.top.equalTo(monthView.snp.top).offset(90)
            make.right.equalTo(monthView.snp.right)
        }
        buttonright.setTitle(">", for: .normal)
        
        
        Sun.text = "日"
        Sun.textColor = .white
        Sun.snp.makeConstraints { (make) in
            make.top.equalTo(monthLabel.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(38)
        }
        Mon.text = "月"
        Mon.textColor = .white
        Mon.snp.makeConstraints { (make) in
            make.top.equalTo(monthLabel.snp.bottom).offset(10)
            make.left.equalTo(Sun.snp.right).offset(38)
        }
        Tue.text = "火"
        Tue.textColor = .white
        Tue.snp.makeConstraints { (make) in
            make.top.equalTo(monthLabel.snp.bottom).offset(10)
            make.left.equalTo(Mon.snp.right).offset(38)
        }
        Wes.text = "水"
        Wes.textColor = .white
        Wes.snp.makeConstraints { (make) in
            make.top.equalTo(monthLabel.snp.bottom).offset(10)
            make.left.equalTo(Tue.snp.right).offset(38)
        }
        Thu.text = "木"
        Thu.textColor = .white
        Thu.snp.makeConstraints { (make) in
            make.top.equalTo(monthLabel.snp.bottom).offset(10)
            make.left.equalTo(Wes.snp.right).offset(38)
        }
        Fri.text = "金"
        Fri.textColor = .white
        Fri.snp.makeConstraints { (make) in
            make.top.equalTo(monthLabel.snp.bottom).offset(10)
            make.left.equalTo(Thu.snp.right).offset(38)
        }
        Sat.text = "土"
        Sat.textColor = .white
        Sat.snp.makeConstraints { (make) in
            make.top.equalTo(monthLabel.snp.bottom).offset(10)
            make.left.equalTo(Fri.snp.right).offset(38)
        }
        
        collection.backgroundColor = .lightGray
        collection.snp.makeConstraints { (make) in
            make.top.equalTo(monthView.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 31
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let title = UILabel(frame: .zero)
        cell.contentView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.equalTo(cell.snp.left).offset(45)
        }
        if let textLabel = cell.contentView.subviews[0] as? UILabel{
          textLabel.text = "\(indexPath.row + 1)"
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
