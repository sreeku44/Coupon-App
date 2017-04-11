//
//  AddCouponViewController.swift
//  Coupon App
//
//  Created by Sreekala Santhakumari on 4/4/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit
import CoreData

protocol AddCouponSaveDelegate  {
    func addCouponSave( aCS : NSManagedObject)
    
}

class AddCouponViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var delegate  : AddCouponSaveDelegate?
    var imagePicker :UIImagePickerController!
    var originalImage :UIImage!
    

    @IBOutlet var imageView1: UIImageView!
    
    
    @IBOutlet var addShopNameTxtField: UITextField!
    @IBOutlet var couponNameTxtField: UITextField!
    @IBOutlet var expiryDateTxtField: UITextField!
    @IBOutlet var couponCodeTxtField: UITextField!
    @IBOutlet var commentsTxtField: UITextField!
    @IBOutlet var useCamera: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        
        
        // set the curent date
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateStyle = DateFormatter.Style.medium
        //        expiryDateTxtField.text = dateFormatter.string(from: NSDate() as Date)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = self.originalImage
        self.imagePicker.dismiss(animated: true, completion: nil)

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePicker.dismiss(animated: true, completion: nil)
    }

    
    //datePicker
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        expiryDateTxtField.text = dateFormatter.string(from: sender.date)
    }
    //datepicker
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 1 {
            
            let datePicker: UIDatePicker = UIDatePicker()
            datePicker.datePickerMode = UIDatePickerMode.date
            self.expiryDateTxtField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(handleDatePicker), for: UIControlEvents.valueChanged)
        }
    }
    
    @IBAction func saveCouponBtnPressed(_ sender: Any) {
        
        let shopName = self.addShopNameTxtField.text!
        let couponName = self.couponNameTxtField.text!
        let comments = self.commentsTxtField.text!
        //let imageUrl = self.saveImage(intoDocumentsDirectoryAndReturnPath: imageView.image!)
        
        // dateFormatter
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        let expirydate = dateFormatter.date(from: expiryDateTxtField.text!)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //coreData
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CouponDetails", in: managedContext)!
        
        let cd = NSManagedObject(entity: entity, insertInto: managedContext)
        
        let img = UIImage(named: "camera.JPG")
        
        let imgData = UIImagePNGRepresentation(img!)
        
        
        
        cd.setValue(shopName, forKey: "shopName")
        cd.setValue(couponName, forKey: "couponName")
        cd.setValue(expirydate, forKey: "expiryDate")
        cd.setValue(comments, forKeyPath: "comments")
        cd.setValue(imgData!, forKey: "couponImage")
        
        //cd.setValue(imageUrl, forKey: "couponImageUrl")
        
        //self.myEvent.picture = UIImageJPEGRepresentation(chosenImage, 1);
        
        do {
            try managedContext.save()
        }
        catch let error as NSError { print("could not save")
        }
        
        //self.imageView1.image = self.loadImage(fromDocumentsDirectory: imageUrl)
        self.delegate?.addCouponSave(aCS: cd)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    //camera
    
    @IBAction func useCameraBtnPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Coupon App", message: "Select an option", preferredStyle: .actionSheet)
        
        let takePhotoAction = UIAlertAction(title: "Take a Photo", style: .default) { (action :UIAlertAction) in
            
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let pickFromLibraryAction = UIAlertAction(title: "Pick from Library", style: .default) { (action :UIAlertAction) in
            
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(takePhotoAction)
        alertController.addAction(pickFromLibraryAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    
    }
    
    
    //BackGround
    
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
    
    //Keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
}
