//
//  CouponCollectionViewController.swift
//  Coupon App
//
//  Created by Sreekala Santhakumari on 4/12/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit
import  CoreData

private let reuseIdentifier = "Cell"

class CouponCollectionViewController: UICollectionViewController, AddCouponSaveDelegate {

    //var coupons :[CouponDetails] = []
    
    
    var couponLists : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assignbackground ()
        
        
    }
    func  addCouponSave(aCS:NSManagedObject) {
        
        couponLists.append(aCS)
        self.collectionView?.reloadData()
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
            else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "CouponDetails")
        let sortDescriptor = NSSortDescriptor(key: "expiryDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            couponLists = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.couponLists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponCell", for : indexPath) as! CouponCollectionViewCell
        
        let couponNameDetails = couponLists[indexPath.row]
        let imgData = couponNameDetails.value(forKey: "couponImage")
        if imgData != nil {
        let newImage = UIImage(data:imgData as! Data,scale:1.0)
            cell.cpnImgView.image = newImage
        }
    
       // cell.cpnImgView.image =
        guard let expiryDate = couponNameDetails.value(forKeyPath: "expiryDate") as? Date else {
            return cell
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        let newexpirydate = dateFormatter.string(from: expiryDate)
        cell.expryDateLbl.text = newexpirydate
        return cell
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddCouponsSegue"){
            let addCouponVC = segue.destination as! AddCouponViewController
            addCouponVC.delegate = self
        }
        else {}
        


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
}
