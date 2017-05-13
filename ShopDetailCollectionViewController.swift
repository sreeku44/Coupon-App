//
//  ShopDetailCollectionViewController.swift
//  Coupon App
//
//  Created by Sreekala Santhakumari on 4/17/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit
import  CoreData

private let reuseIdentifier = "Cell"

class ShopDetailCollectionViewController: UICollectionViewController {
    
    var shopSelected : String = ""
    var coupons :[NSManagedObject] = []
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        
        
        dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = shopSelected        
        //future check
        // checking the shop name in coreData getting all the coupons for the shop
        let x = coupons.filter{
            (($0 as! CouponDetails).shopName?.contains(shopSelected))!
        }
        
        coupons = x;
        
        self.collectionView?.reloadData()
        
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return coupons.count
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let couponNameDetails = coupons[indexPath.item]
        
        let imgData = couponNameDetails.value(forKey: "couponImage")
        
        
        if (imgData == nil) {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopTextCell", for: indexPath) as! ShopTextCollectionViewCell
            
            cell.couponName.text = couponNameDetails.value(forKeyPath: "couponName") as? String
            
            guard let expiryDate = couponNameDetails.value(forKeyPath: "expiryDate") as? Date else {
                return cell
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            
            let newexpirydate = dateFormatter.string(from: expiryDate)
            cell.expryDateLbl.text = newexpirydate
            return cell
        }
        else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopImageCell", for: indexPath) as! ShopNameCollectionViewCell
            
            let newImage = UIImage(data:imgData as! Data,scale:1.0)
            
            cell.cpnImgView.image = newImage
            guard let expiryDate = couponNameDetails.value(forKeyPath: "expiryDate") as? Date else {
                return cell
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            
            let newexpirydate = dateFormatter.string(from: expiryDate)
            cell.expryDateLbl.text = newexpirydate
            return cell
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationC = segue.destination as! UINavigationController
        let couponDetailVC = navigationC.viewControllers.first as! CouponDeatailTableViewController
        let indexPath = self.collectionView?.indexPathsForSelectedItems?.first
        //let selCoupon = coupons[(indexPath?.row)!]
        couponDetailVC.couponSelected =  coupons[(indexPath?.row)!] as! CouponDetails
    }
    
    
    
    
}


