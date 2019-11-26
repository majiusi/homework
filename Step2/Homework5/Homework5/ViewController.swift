//
//  ViewController.swift
//  Homework5
//
//  Created by Margis on 2019/11/26.
//  Copyright © 2019 Margis. All rights reserved.
//
import Alamofire
import CryptoSwift
import SnapKit
import UIKit

class ViewController: UIViewController {
    
    var text1:UITextView
    var text2:UITextView
    var translate:UIButton
    var clear:UIButton
    var titleLabel:UILabel
    var trans_results:[Trans_result]?{
        didSet{
            text2.reloadInputViews()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        text1 = UITextView(frame: .zero)
        text2 = UITextView(frame: .zero)
        translate = UIButton(frame: .zero)
        clear = UIButton(frame: .zero)
        titleLabel = UILabel(frame: .zero)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
        view.addSubview(titleLabel)
        view.addSubview(text1)
        view.addSubview(text2)
        view.addSubview(translate)
        view.addSubview(clear)
        translate.backgroundColor = .gray
        clear.backgroundColor = .gray
        
        translate.setTitleColor(.white, for: .normal)
        translate.setTitle("Translate", for: .normal)
        clear.setTitleColor(.white, for: .normal)
        clear.setTitle("Clear", for: .normal)
        titleLabel.text = "Translator"
        titleLabel.font = titleLabel.font.withSize(35)
        titleLabel.textColor = .white
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.center)
            make.top.equalTo(additionalSafeAreaInsets.top).offset(100)
        }
        text1.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.center)
            make.height.equalTo(200)
            make.width.equalTo(300)
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
        }
        translate.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.center)
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.top.equalTo(text1.snp.bottom).offset(25)
        }
        text2.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.center)
            make.height.equalTo(200)
            make.width.equalTo(300)
            make.top.equalTo(translate.snp.bottom).offset(25)
        }
        clear.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.center)
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.top.equalTo(text2.snp.bottom).offset(25)
        }
        translate.addTarget(self, action: #selector(didTranslateButtonClick), for: .touchUpInside)
        clear.addTarget(self, action: #selector(didClearButtonClick), for: .touchUpInside)
    }
    @objc func didTranslateButtonClick(_ sender: UIButton) {
        //APP ID：20180306000131844
        //密钥：QRjrVKE2wmDirSJxRz5k
        self.text2.text = "Loading....."
        if let text = text1.text{
            let passcode = "20180306000131844\(text)12345678QRjrVKE2wmDirSJxRz5k".md5()
            print(passcode)
            let url = "https://fanyi-api.baidu.com/api/trans/vip/translate?q=\(text)&from=auto&to=zh&appid=20180306000131844&salt=12345678&sign=\(passcode)"
            print(url)
            Alamofire.request(url, method: .get).responseData { (response) in
                let decoder = JSONDecoder()
                if let data = response.data {
                    do {
                        let result = try decoder.decode(Response.self, from: data)
                        self.trans_results = result.trans_result
                        print(result.trans_result[0].dst)
                        self.text2.text = result.trans_result[0].dst
                    }catch{
                        //json decode error
                    }
                }else{
                    //no data response
                }
            }
        }
    }
    
    @objc func didClearButtonClick(_ sender: UIButton) {
        text1.text = ""
        text2.text = ""
    }
}

