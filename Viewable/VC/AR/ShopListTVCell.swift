//
//  ShopListTVCell.swift
//  Viewable
//
//  Created by 조예은 on 24/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import UIKit

class ShopListTVCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var number: UILabel!
    @IBOutlet var storeImg: UIImageView!
    @IBOutlet var facilitiesImageView: [UIImageView]!
    @IBOutlet var categoryImageView: UIImageView!
    
    let category = [
        #imageLiteral(resourceName: "listStoreFoodIc"),
        #imageLiteral(resourceName: "listStorePostofficeIc"),
        #imageLiteral(resourceName: "listStoreConveniencestoreIc"),
        #imageLiteral(resourceName: "listStoreCafeIc"),
        #imageLiteral(resourceName: "listStoreMartIc"),
        #imageLiteral(resourceName: "listStoreBankIc"),
        #imageLiteral(resourceName: "listStorePharmacyIc")
    ]
    
    var data: StoreLine? {
        didSet {
            if let safeData = data {
                name.text = safeData.name
                time.text = safeData.operating
                number.text = safeData.phone
                categoryImageView.image = category[safeData.categoryIdx - 1]
                if let url = URL(string: safeData.img) {
                    storeImg.downloadImage(from: url)
                }
                
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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
