//
//  Facilitie.swift
//  Viewable
//
//  Created by 김덕원 on 25/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

struct Facilitie {
    let icon: UIImage
    let name: String
    let info: String
    
    init(icon: UIImage, name: String, info: String) {
        self.icon = icon
        self.name = name
        self.info = info
    }
}
