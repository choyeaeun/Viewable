//
//  UISearchResultCell.swift
//  Viewable
//
//  Created by 김덕원 on 22/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation
import UIKit

class UISearchResultCell: UICollectionViewCell {
    
    static let identifier = "UISearchResultCell"
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.27).cgColor
        layer.shadowOffset = CGSize(width:2.0, height: 4.0)
        layer.shadowRadius = 2.5
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
}
