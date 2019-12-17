//
//  UIStoreCell.swift
//  Viewable
//
//  Created by 김덕원 on 16/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation
import UIKit

class UIStoreCell: UITableViewCell {

    // MARK:- Property
    @IBOutlet var thumbnailImageView: UIRadiusImageView!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var storeAddressLabel: UILabel!
    @IBOutlet var storePhoneLabel: UILabel!
    @IBOutlet var facilitiesImageView: [UIView]!
    
    static let identifier = "UIStoreCell"
    var data: StoreInformation? = nil {
        didSet {
            if let information = self.data {
                storeNameLabel.text = information.name
                storeAddressLabel.text = information.address
                storePhoneLabel.text = information.phone
                // 나머지는 상황보고 추가
            }
        }
    }

}
