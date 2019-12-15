//
//  ViewController.swift
//  PhotoStack
//
//  Created by 马九思 on 2019/12/15.
//  Copyright © 2019 马九思. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var page = UIPageControl(frame: .zero)
    var scrollView: UIScrollView!
    let numOfPages = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.title = "PhotoStack"
        view.addSubview(page)
        page.numberOfPages = 5
        page.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-10)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(100)
        }
        let frame = self.view.bounds
        scrollView = UIScrollView(frame: frame)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = .zero
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(numOfPages), height: frame.size.height - 150)
        scrollView.delegate = self
        for index  in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "Image\(index + 1)"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height - 150)
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
        }
        self.view.insertSubview(scrollView, at: 0)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let offset = scrollView.contentOffset
           page.currentPage = Int(offset.x / view.bounds.width)

           if page.currentPage == numOfPages - 1 {
            UIView.animate(withDuration: 0.5) {
                
               }
           } else {
            UIView.animate(withDuration: 0.2) {

               }
           }
       }
   }
