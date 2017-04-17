//
//  ShopNameTableViewController.swift
//  Coupon App
//
//  Created by Sreekala Santhakumari on 4/4/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit
import CoreData

class ShopNameTableViewController: UITableViewController , AddCouponSaveDelegate {
    
     var couponLists : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        
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
    
    func addCouponSave(aCS: NSManagedObject){
        
    self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

   guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
    else {
        return
        }
let managedContext = appDelegate.persistentContainer.viewContext
        
       let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CouponDetails")
        
        let sortDescriptor = NSSortDescriptor(key: "expiryDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            couponLists = try managedContext.fetch(fetchRequest)
            
        }
        catch let error as NSError {
        print("Could not fetch . \(error), \(error.userInfo)")
        
        }
       
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return couponLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopNameCell", for: indexPath)
        
       let displayShopName = couponLists[indexPath.row]
       cell.textLabel?.text = displayShopName.value(forKeyPath: "shopName") as? String
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddShopSegue"){
            let addCouponVC = segue.destination as! AddCouponViewController
            addCouponVC.delegate = self
        }
        else {
        
            
//            let ShopDetailVC = segue.destination as! ShopDetailViewController
//            
//            let indexPath = self.tableView.indexPathForSelectedRow
//            
//            ShopDetailVC.selectedShop = couponLists[(indexPath?.row)!]
//            

        
        }
    }
    
    
}
