//
//  UIStoreCell.swift
//  Viewable
//
//  Created by 김덕원 on 16/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation
import UIKit

class UIStoreCell: UICollectionViewCell {
    
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
    
    // MARK:- Property
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var storeAddressLabel: UILabel!
    @IBOutlet var storePhoneLabel: UILabel!
    @IBOutlet var facilitiesImageView: [UIView]!
    
    // MARK:- Method
    override func layoutSubviews() {
        contentView.layer.cornerRadius = 7
        contentView.layer.masksToBounds = true
        
        let color = CGFloat(201 / 255)
        layer.shadowColor = UIColor(red: color, green: color, blue: color, alpha: 0.5).cgColor
//        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
}
