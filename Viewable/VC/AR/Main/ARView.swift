//
//  ARView.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/29.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import UIKit

class ARView: UIView {
    private let xibName = "ARView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
