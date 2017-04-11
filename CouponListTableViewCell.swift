//
//  CouponListTableViewCell.swift
//  Coupon App
//
//  Created by Sreekala Santhakumari on 4/11/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit

class CouponListTableViewCell: UITableViewCell {
    
    @IBOutlet var couponListLabel : UILabel!
    @IBOutlet var dateLable : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
            }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

            }

}
