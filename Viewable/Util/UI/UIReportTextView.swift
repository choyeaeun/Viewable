//
//  UIReportTextView.swift
//  Viewable
//
//  Created by deokwon on 27/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

@IBDesignable
class UIReportTextView: UITextView {

    @IBInspectable var placeholder: String = ""
    @IBInspectable var placeholderColor: UIColor = UIColor.gray
    @IBInspectable var normalColor: UIColor = UIColor.black
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        delegate = self
//        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextValue() {
        if text == placeholder {
            text = ""
            textColor = normalColor
        } else if text == "" {
            text = placeholder
            textColor = placeholderColor
        }
    }
    
    override func layoutSubviews() {
        let color = CGFloat(155 / 255)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: color, green: color, blue: color, alpha: 1).cgColor
    }
}

extension UIReportTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        setTextValue()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if text == "" {
            setTextValue()
        }
    }
}
