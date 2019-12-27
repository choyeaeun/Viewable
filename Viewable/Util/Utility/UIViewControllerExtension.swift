//
//  UIViewControllerExtension.swift
//  Viewable
//
//  Created by deokwon on 28/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func touchToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
