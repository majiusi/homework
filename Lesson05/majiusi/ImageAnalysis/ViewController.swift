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
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func chooseImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
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
                                tagsReturn = tags.flatMap({ dict in
                                    return dict.tag
                                })
                                
                                completion(tagsReturn)
                                
                            }catch{
                                print("Json 2 Decoder Error!")
                            }
        }
        
        completion(tagsReturn)
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
                                //let image_colors = result.results.first?.info.image_colors
                                //for color in image_colors!{
                                //let r = Int(color.r)
                                //let g = Int(color.g)
                                //let b = Int(color.b)
                                //let name = color.closest_palette_color
                                //let colorInfo = PhotoColor(red: r, green: g, blue: b, colorName: name)
                                //colorsReturn.append(colorInfo)
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
        }) { (a, b) in
            self.tagsToDetailsPage = a
            print("\(a.count)")
            self.colorsToDetailsPage = b
            print("\(b.count)")
            self.performSegue(withIdentifier: "segue", sender: self)
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

