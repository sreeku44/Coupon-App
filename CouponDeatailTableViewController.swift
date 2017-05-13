//
//  CouponDeatailTableViewController.swift
//  Coupon App
//
//  Created by Sreekala Santhakumari on 4/18/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit

class CouponDeatailTableViewController: UITableViewController {

    var couponSelected :CouponDetails!
    
    
    @IBOutlet var CpnImageView: UIImageView!
   // @IBOutlet var shopNameLabel: UILabel!
    
    @IBOutlet var CpnNameCodeLabel: UILabel!
    
    @IBOutlet var ExpryDateLabel: UILabel!
    
    @IBOutlet var commentsLabel: UILabel!
    
   //@IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var imgLabel : UILabel!
    
    func mapView( mV : Shop){}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = couponSelected.shopName
        
        
       // self.shopNameLabel.text = couponSelected.shopName
        self.CpnNameCodeLabel.text = couponSelected.couponName
        self.commentsLabel.text = couponSelected.comments
       // self.nameLabel.text = couponSelected.shopName
        
        
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
        
        }
    
    @IBAction func nearYouBtn(_ sender: Any) {
        
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationC = segue.destination as! UINavigationController
        let mapVC = navigationC.viewControllers.first as! MapViewController
        mapVC.nameOfTheShop = couponSelected.shopName
        
        
    }
    
}
