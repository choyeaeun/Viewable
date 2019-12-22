//
//  ShopfilterVC.swift
//  Viewable
//
//  Created by 조예은 on 21/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import UIKit

class ShopfilterVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func selectedBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
}
