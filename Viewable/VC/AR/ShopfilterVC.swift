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
    @IBOutlet var category:[UIButton]!
    @IBOutlet var facility:[UIButton]!
    
    var facilityArr: [Int] = []
    var categoryArr: [Int] = []
    
    var delegate: SendDataDelegate?
    
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
        if let facilityBtns = facility {
            for i in 0...facilityBtns.count-1{
                if facilityBtns[i].isSelected == true{
                    facilityArr.append(i)
                }
            }
            if facilityArr == []{
                facilityArr = [0,1,2,3,4,5,6,7,8]
            }
        }
        if let categoryBtns = category {
            for i in 0...categoryBtns.count-1{
                if categoryBtns[i].isSelected == true{
                    categoryArr.append(i)
                }
            }
            if categoryArr == []{
                categoryArr = [0,1,2,3,4,5,6]
            }
        }
        let filterFac:String = facilityArr.map { String($0) }.joined(separator: ",")
        let filterCat: String = categoryArr.map { String($0) }.joined(separator: ",")
        print("filter data:",filterFac, filterCat)
        
        delegate?.sendData(facility: filterFac, category: filterCat)
        self.dismiss(animated: true)
    }
}

