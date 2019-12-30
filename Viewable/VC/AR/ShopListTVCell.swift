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
    @IBOutlet var facil1: UIImageView!
    @IBOutlet var facil2: UIImageView!
    @IBOutlet var facil3: UIImageView!
    @IBOutlet var facil4: UIImageView!
    @IBOutlet var facil5: UIImageView!
    @IBOutlet var storeImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
