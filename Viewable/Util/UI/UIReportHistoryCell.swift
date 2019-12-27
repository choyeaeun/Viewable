//
//  UIReportHistoryCell.swift
//  Viewable
//
//  Created by deokwon on 28/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation
import UIKit

class UIReportHistoryCell: UICollectionViewCell {
    
    static let identifier = "UIReportHistoryCell"

    @IBOutlet var reportImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    
    var data: MyPageUseReport? {
        didSet {
            if let safeData = data {
                if let url = URL(string: safeData.img) {
                    reportImageView.downloadImage(from: url)
                }
                titleLabel.text = safeData.title
                dateLabel.text = safeData.date
                contentLabel.text = safeData.contents
                positionLabel.text = safeData.name
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = UIColor.white
        self.contentView.layer.cornerRadius = 7.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        let color = CGFloat(77 / 255)
        self.layer.shadowColor = UIColor(red: color, green: color, blue: color, alpha: 0.27).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 3.5
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
