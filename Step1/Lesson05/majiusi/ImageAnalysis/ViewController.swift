//
//  ViewController.swift
//  ImageAnalysis
//
//  Created by Margis on 2018/3/4.
//  Copyright © 2018年 Margis. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var tagsToDetailsPage: [String]?
    var colorsToDetailsPage: [PhotoColor]?
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.View1.layer.borderWidth = 1
        self.View1.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        self.View2.layer.borderWidth = 1
        self.View2.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func chooseCamera(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            let message = UIAlertController.init(title: "Error", message: "Can't Open your Camara", preferredStyle: .alert)
            let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            message.addAction(action)
            present(message, animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    @IBAction func chooseImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func upload(image:UIImage,
                progressCompletion: @escaping(_ precent: Float) -> Void,
                completion: @escaping(_ tags: [String],_ colors: [PhotoColor]) -> Void) {
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {
            print("Could not get JPEG Representation")
            return
        }
        // 选择最长的Upload,最后一个是匿名函数（闭包）已函数作为参数 最后一个闭包 可以写在外面
        Alamofire.upload(multipartFormData: { (multipartFromData) in
            multipartFromData.append(imageData, withName: "imagefile", fileName: "image.jpg", mimeType: "image/jpeg")
        },
                         to: "http://api.imagga.com/v1/content",
                         headers: ["Authorization" : "Basic YWNjX2NlYzFiOTM1YTYwNDBiYjpkOWUxMmNjNmM5M2Q1ZTk3YTJiNzFlOGJkMGM2MmNiNQ=="]) { (encodingResult) in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.uploadProgress(closure: { (progress) in
                                    progressCompletion(Float(progress.fractionCompleted))
                                })
                                upload.validate()
                                upload.responseJSON(completionHandler: { (response) in
                                    guard response.result.isSuccess else{
                                        print("Error with the response result! Error detail: \(response.result.error.debugDescription)")
                                        completion([String](), [PhotoColor]())
                                        return
                                    }
                                    do{
                                        let responseJson = try JSONDecoder().decode(uploadedResult.self, from: response.data!)
                                        print(responseJson.status)
                                        guard let id = responseJson.uploaded.first?.id else{return}
                                        self.downloadTags(id: id, completion: { tags in
                                            self.downloadColors(id: id, completion: { colors in
                                                completion(tags, colors)
                                            })
                                        })
                                    }catch{
                                        print("Json 1 decoder Error!")
                                    }
                                    
                                }
                                )
                            case .failure(let Error):
                                print(Error)
                            }
        }
    }

    func downloadTags(id:String, completion:@escaping ([String])->Void) {
        var tagsReturn = [String]()
        
        Alamofire.request("http://api.imagga.com/v1/tagging",
                          parameters: ["content":id],
                          headers: ["Authorization": "Basic YWNjX2NlYzFiOTM1YTYwNDBiYjpkOWUxMmNjNmM5M2Q1ZTk3YTJiNzFlOGJkMGM2MmNiNQ=="]).responseJSON { (response) in
                            guard response.result.isSuccess else {
                                print("Error while fetching tags: \(response.result.error.debugDescription)")
                                return 
                            }
                            do{
                                let result = try JSONDecoder().decode(resultList.self, from: response.data!)
                                guard let tags = result.results.first?.tags else{
                                    return
                                }
                                
                                let baidu = BaiduTranslate ()
                                baidu.getCNTags(tags: tags, level: 70.0) { (returns) in
                                    tagsReturn = returns
                                    completion(returns)
                                }
                                
//                                tagsReturn = tags.flatMap({ dict in
//                                    if dict.confidence > 40.0{
//                                        return dict.tag
//                                    }
//                                    return nil
//                                    }
//                                )
                                completion(tagsReturn)
                                
                            }catch{
                                print("Json 2 Decoder Error!")
                            }
        }
        
        //        completion(tagsReturn)
    }
    
    func downloadColors(id:String, completion:@escaping ([PhotoColor])->Void){
        var colorsReturn = [PhotoColor]()
        Alamofire.request("http://api.imagga.com/v1/colors",
                          parameters: ["content":id, "extract_object_colors": 0],
                          headers: ["Authorization": "Basic YWNjX2NlYzFiOTM1YTYwNDBiYjpkOWUxMmNjNmM5M2Q1ZTk3YTJiNzFlOGJkMGM2MmNiNQ=="]).responseJSON { (response) in
                            guard response.result.isSuccess else {
                                print("Error while fetching tags: \(response.result.error.debugDescription)")
                                completion([PhotoColor]())
                                return
                            }
                            do{
                                let result = try JSONDecoder().decode(colors.self, from: response.data!)
                                guard let image_colors = result.results.first?.info.image_colors else {
                                    return
                                }
                                colorsReturn = image_colors.flatMap({ (dict) -> PhotoColor? in
                                    guard let r = Int(dict.r),
                                        let g = Int(dict.g),
                                        let b = Int(dict.b)
                                        else {
                                            return nil
                                    }
                                    print(r,g,b,dict.closest_palette_color)
                                    
                                    return PhotoColor(red: r,
                                                      green: g,
                                                      blue: b,
                                                      colorName: dict.closest_palette_color)
                                    
                                })
                                completion(colorsReturn)
                            }catch{
                                print("Json 3 Decoder Error!")
                                let alert = UIAlertController.init(title: "Error", message: "Server error, try again later", preferredStyle: .alert)
                                let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            }
        }
        
    }
    
}
extension ViewController:UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("Info did not have the required UIImage for the Original Image")
            dismiss(animated: true)
            return
        }
        imageView.image = image
        upload(image: image, progressCompletion: { (progress) in
            print(progress)
            self.progressView.progress = progress
        }) { (a, b) in
            self.tagsToDetailsPage = a
            print("\(a.count)")
            self.colorsToDetailsPage = b
            print("\(b.count)")
            self.progressView.progress = 0.0
            if (a.count != 0 && b.count != 0){
                self.performSegue(withIdentifier: "segue", sender: self)
            }
        }
        dismiss(animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! UITabBarController
        let objectView = destination.viewControllers![0] as! ObjectTableViewController
        objectView.result = tagsToDetailsPage!
        let colorView = destination.viewControllers![1] as! ColorTableViewController
        colorView.result = colorsToDetailsPage!
    }
}
extension ViewController:UINavigationControllerDelegate{
}

