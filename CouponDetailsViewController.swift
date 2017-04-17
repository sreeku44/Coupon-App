//
//  CouponDetailsViewController.swift
//  Coupon App
//
//  Created by Sreekala Santhakumari on 4/10/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit

class CouponDetailsViewController: UIViewController, mapViewDelegate {
    
    var couponSelected :CouponDetails!
    
    
    @IBOutlet var CpnImageView: UIImageView!
    @IBOutlet var shopNameLabel: UILabel!
    
    @IBOutlet var CpnNameCodeLabel: UILabel!
    
    @IBOutlet var ExpryDateLabel: UILabel!
    
    @IBOutlet var commentsLabel: UILabel!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var imgLabel : UILabel!
    
    func mapView( mV : Shop){}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shopNameLabel.text = couponSelected.shopName
        self.CpnNameCodeLabel.text = couponSelected.couponName
        self.commentsLabel.text = couponSelected.comments
        self.nameLabel.text = couponSelected.shopName
    
        let imgData = couponSelected.value(forKey: "couponImage")
        if (imgData != nil) {
        let newImage = UIImage(data:imgData as! Data,scale:1.0)
        self.CpnImageView.image = newImage
        }
        
        else  {
            self.imgLabel.text = " No Image "
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let newexpirydate = dateFormatter.string(from: couponSelected.expiryDate as! Date)
        self.ExpryDateLabel.text = newexpirydate

        print(couponSelected.couponName)
        
        
    }

    @IBAction func nearYouBtn(_ sender: Any) {
        
    }

    @IBAction func doneBtnPressed(_ sender: Any) {
        
         dismiss(animated: true, completion: nil)
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let mapVC = segue.destination as! MapViewController
         mapVC.nameOfTheShop = couponSelected.shopName
        
        
    }

}

//    class func getUniqueIdentifier() -> String {
//        var uuid: CFUUIDRef
//        var uuidStr: CFString
//        uuid = CFUUIDCreate(nil)
//        uuidStr = CFUUIDCreateString(nil, uuid)
//        return ((uuidStr) as? String)!
//    }
    // user generated images are stored in the documents directory
    
//    class func loadImage(fromDocumentsDirectory imageUrl: String) -> UIImage {
//        let paths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        let documentsDirectory: String? = (paths[0] as? String)
//        let savedImagePath: String = URL(fileURLWithPath: documentsDirectory!).appendingPathComponent("\(imageUrl)").absoluteString
//        let image = UIImage(contentsOfFile: savedImagePath)
//        return image!
//
//        // save user's image into the documents directory
//        +(NSString *) saveImageIntoDocumentsDirectoryAndReturnPath:(UIImage *)imageToSave
//        {
//            imageToSave = [imageToSave imageByScalingProportionallyToSize:CGSizeMake(320, 480)];
//            NSString *uniqueImageName = [self getUniqueIdentifier];
//            uniqueImageName = [uniqueImageName stringByAppendingPathExtension:@"png"];
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//            NSString *documentsDirectory = [paths objectAtIndex:0];
//            NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",uniqueImageName]];
//            NSData *imageData = UIImagePNGRepresentation(imageToSave);
//            [imageData writeToFile:savedImagePath atomically:YES];
//            return uniqueImageName;
//        }
//        Add Comment Collapse


