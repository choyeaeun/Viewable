//
//  UIRadiusView.swift
//  Viewable
//
//  Created by 김덕원 on 17/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class UIRadiusView: UIButton {
    
    // MARK:- Property
    @IBInspectable var cornerRadius: Float = 0.0
    @IBInspectable var borderWidth: Float = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.black
    @IBInspectable var isPercentRadius: Bool = false
    
    // MARK:- Custom method
    override func layoutSubviews() {
        var radius: Float = cornerRadius
        if (isPercentRadius) {
            radius = self.layer.bounds.width.toFloat() * 0.5
        }

        layer.cornerRadius = radius.toCGFloat()
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth.toCGFloat()
        clipsToBounds = true
    }
}
