//
//  ImageTableViewCell.swift
//  Coupon App
//
//  Created by Sreekala Santhakumari on 4/11/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet var couponView : UIImageView!
    @IBOutlet var dateLabel : UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
