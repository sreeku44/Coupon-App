//
//  CouponDetailsViewController.swift
//  Coupon App
//
//  Created by Sreekala Santhakumari on 4/10/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit

class CouponDetailsViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

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

}
