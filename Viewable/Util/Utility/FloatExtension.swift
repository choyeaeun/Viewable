//
//  FloatExtension.swift
//  Viewable
//
//  Created by 김덕원 on 15/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

extension Float {
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}

extension CGFloat {
    func toFloat() -> Float {
        return Float(self)
    }
}
