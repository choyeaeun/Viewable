    //
    //  UIToggleButton.swift
    //  Viewable
    //
    //  Created by 김덕원 on 25/12/2019.
    //  Copyright © 2019 Yeaeun. All rights reserved.
    //

    import Foundation
    import UIKit

    @IBDesignable
    class UIToggleButton: UIButton {

    // MARK:- Property
    @IBInspectable var isOn: Bool = false {
        didSet {
            updateImage()
        }
    }
    @IBInspectable var autoToggle: Bool = true
    @IBInspectable private(set) var onImage: UIImage? = nil
    @IBInspectable private(set) var offImage: UIImage? = nil

    // MARK:- Method
    public func toggle() {
        isOn.toggle()
    }

    private func updateImage() {
        if let onImage = onImage, isOn {
            setBackgroundImage(onImage, for: .normal)
        } else if let offImage = offImage, !isOn {
            setBackgroundImage(offImage, for: .normal)
        }
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        if (autoToggle) {
            toggle()
        }
    }
}
