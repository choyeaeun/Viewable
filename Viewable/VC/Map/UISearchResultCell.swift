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
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var operationLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var imageView: UIRadiusImageView!
    @IBOutlet var facilityImageViews: [UIImageView]!
    
    var data: StoreData? {
        didSet {
            if let safeData = data {
                nameLabel.text = safeData.name
                addressLabel.text = safeData.address
                operationLabel.text = safeData.operating
                phoneLabel.text = safeData.phone
                if let url = URL(string: safeData.img) {
                    imageView.downloadImage(from: url)
                }
                facilityImageViews.forEach { imageView in
                    imageView.image = nil
                }

                for (index, value) in safeData.facility.enumerated() {
                    if index >= 3 {
                        break
                    }
                    facilityImageViews[index].image = Constants.facilities[value - 1].icon
                }
                if safeData.facility.count > 3 {
                    facilityImageViews[facilityImageViews.count - 1].image = #imageLiteral(resourceName: "facilitySmallBlEtcIc")
                }
            }
        }
    }
    
    @IBAction func didClickedPathFind(_ sender: Any) {
        let urlString = "kakaomap://search?q=\(data!.name)&p=\(data!.latitude),\(data!.longitude)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // app store 이동 openURLToAppStore(urlPath: name)
        }
    }
    
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
