//
//  ViewController.swift
//  QRScanner
//
//  Created by 马九思 on 2019/12/23.
//  Copyright © 2019 马九思. All rights reserved.
//
import AVFoundation
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var output: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            guard let destination = segue.destination as? WebViewController else { return }
            destination.url = output.text
        }
    }
    
    @IBAction func GoClicked(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    @IBAction func ClearClicked(_ sender: Any) {
        output.text = ""
        UserDefaults().removeObject(forKey: "url")
    }
    @IBAction func CameraClicked(_ sender: Any) {
        let cameraView = CameraViewController()
        navigationController?.pushViewController(cameraView , animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let result = UserDefaults().value(forKey: "url"){
            output.text = result as? String
        }
    }
}

