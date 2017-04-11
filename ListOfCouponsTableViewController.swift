//
//  ListOfCouponsTableViewController.swift
//  Coupon App
//
//  Created by Sreekala Santhakumari on 4/4/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit
import  CoreData

class ListOfCouponsTableViewController: UITableViewController, AddCouponSaveDelegate  {
    
    
    var coupons :[CouponDetails] = []
    
    var couponLists : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
    }
    func  addCouponSave(aCS:NSManagedObject) {
        
        couponLists.append(aCS)
        self.tableView.reloadData()
        
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
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return couponLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        //        var cell = tableView.dequeueReusableCell(withIdentifier: "CouponListCell") as! CouponListTableViewCell
        //
        //        let couponNameDetails = couponLists[indexPath.row]
        //
        //        //let coupon = self.coupons[indexPath.row]
        //
        //        if coupon.couponImage == nil {
        //
        //            cell = tableView.dequeueReusableCell(withIdentifier: "CouponListCell") as! CouponListTableViewCell
        //
        //        } else {
        //
        //        }
        
        // camra
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CouponListCell") as! CouponListTableViewCell
        
        let couponNameDetails = couponLists[indexPath.row]
        
        let imgData = couponNameDetails.value(forKey: "couponImage")
       
        if imgData != nil {
            print("image found")
        }
        
        cell.couponListLabel.text = couponNameDetails.value(forKeyPath: "couponName") as? String
        
        guard let expiryDate = couponNameDetails.value(forKeyPath: "expiryDate") as? Date else {
            return cell
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        let newexpirydate = dateFormatter.string(from: expiryDate)
        
        cell.dateLable.text = newexpirydate
        
        return cell
    }
    //Delete
    
    //      override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    //      if editingStyle == UITableViewCellEditingStyle.Delete {
    //            couponLists.removeAtIndex(indexPath.row)
    //            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    //        }
    //    }
    //
    
    //Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddCouponSegue"){
            let addCouponVC = segue.destination as! AddCouponViewController
            addCouponVC.delegate = self
        }
        else {}
        
        
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
