//
//  ViewController.swift
//  CLLocationManager
//
//  Created by 马九思 on 2020/01/14.
//  Copyright © 2020 马九思. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var compassImageView: UIImageView!
    lazy var locationM: CLLocationManager = {
            let locationM = CLLocationManager()
            locationM.delegate = self
            return locationM
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            if CLLocationManager.headingAvailable() {
                locationM.startUpdatingHeading()
            }else {
                print("当前磁力计设备损坏 or 权限不够")
            }
        }
    }
     
    extension ViewController: CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
            print(newHeading)
            let angle = newHeading.magneticHeading//拿到当前设备朝向
            let arc = CGFloat(angle / 180 * Double.pi)//角度转换成为弧度
            UIView.animate(withDuration: 0.5, animations: {
                self.compassImageView.transform = CGAffineTransform(rotationAngle: -arc)
            })
        }
    }
