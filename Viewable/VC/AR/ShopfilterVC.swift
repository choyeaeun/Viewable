//
//  ShopfilterVC.swift
//  Viewable
//
//  Created by 조예은 on 22/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import UIKit

class ShopfilterVC: UIViewController {
    
    @IBOutlet var collection:[UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func selectedBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func resetFilter(_ sender: UIButton) {
        if let buttons = collection {
            for i in 0 ... buttons.count-1{
                collection[i].isSelected = false
            }
        }
    }
    @IBAction func adjustFilter(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

