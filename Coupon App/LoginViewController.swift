//
//  LoginViewController.swift
//  Coupon App
//
//  Created by Sreekala Santhakumari on 4/3/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        
        // self.view.backgroundColor = UIColor(patternImage: UIImage(named : "background.jpeg")!)
        
    }
    
    func assignbackground(){
        let background = UIImage(named: "background.jpeg")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.alpha = 0.07
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    
    
}

// image saving in coredta & populate 
//func getUniqueIdentifier() -> String {
//    var uuid: CFUUID
//    var uuidStr: CFString
//    uuid = CFUUIDCreate(nil)
//    uuidStr = CFUUIDCreateString(nil, uuid)
//    return uuidStr as String
//}
//
//func saveImage(intoDocumentsDirectoryAndReturnPath imageToSave: UIImage) -> String {
//    //var imageToSave1 = imageToSave.sca(toSize: CGSize(width: CGFloat(320), height: CGFloat(480)))
//    var uniqueImageName: String = self.getUniqueIdentifier()
//    //uniqueImageName = uniqueImageName.appendingPathExtension("png")!
//    let paths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//    let documentsDirectory: String? = (paths[0] as? String)
//    let savedImagePath: URL = URL(fileURLWithPath: documentsDirectory!).appendingPathComponent("\(uniqueImageName)").appendingPathExtension("png")
//    let imageData: Data? = UIImagePNGRepresentation(imageToSave)
//    //imageData?.write(to: savedImagePath, options: true)
//    do {
//        try imageData?.write(to: savedImagePath)
//    }
//    catch
//        let error as NSError { print("could not save")
//    }
//    return uniqueImageName
//}
//
//func loadImage(fromDocumentsDirectory imageUrl: String) -> UIImage {
//    let paths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//    let documentsDirectory: String? = (paths[0] as? String)
//    let savedImagePath: String = URL(fileURLWithPath: documentsDirectory!).appendingPathComponent("\(imageUrl)").appendingPathExtension("png").absoluteString
//    let image = UIImage(contentsOfFile: savedImagePath)
//    
//    return image! // check
//}
