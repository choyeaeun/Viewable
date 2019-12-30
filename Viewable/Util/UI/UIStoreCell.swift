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
    @IBOutlet var categoryImageView: UIImageView!
    @IBOutlet var thumbnailImageView: UIRadiusImageView!
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var storeTimeLabel: UILabel!
    @IBOutlet var storeAddressLabel: UILabel!
    @IBOutlet var storePhoneLabel: UILabel!
    @IBOutlet var facilitiesImageView: [UIImageView]!
    
    let category = [
        #imageLiteral(resourceName: "listStoreFoodIc"),
        #imageLiteral(resourceName: "listStorePostofficeIc"),
        #imageLiteral(resourceName: "listStoreConveniencestoreIc"),
        #imageLiteral(resourceName: "listStoreCafeIc"),
        #imageLiteral(resourceName: "listStoreMartIc"),
        #imageLiteral(resourceName: "listStoreBankIc"),
        #imageLiteral(resourceName: "listStorePharmacyIc")
    ]
    
    static let identifier = "UIStoreCell"
    var data: StoreData? = nil {
        didSet {
            if let safeData = self.data {
                storeNameLabel.text = safeData.name
                storeAddressLabel.text = safeData.address
                storePhoneLabel.text = safeData.phone
                storeTimeLabel.text = safeData.operating
                if let url = URL(string: safeData.img) {
                    thumbnailImageView.downloadImage(from: url)
                }
                categoryImageView.image = category[safeData.categoryIdx - 1]
                facilitiesImageView.forEach { imageView in
                    imageView.image = nil
                }
                for (index, value) in safeData.facility.enumerated() {
                    if index >= 4 {
                        break
                    }
                    facilitiesImageView[index].image = Constants.facilities[value - 1].icon
                }
                if safeData.facility.count > 4 {
                    facilitiesImageView[facilitiesImageView.count - 1].image = #imageLiteral(resourceName: "facilitySmallBlEtcIc")
                }
            }
        }
    }

}
