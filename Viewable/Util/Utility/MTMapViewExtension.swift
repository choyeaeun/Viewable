//
//  MTMapViewExtension.swift
//  Viewable
//
//  Created by 김덕원 on 18/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation
import UIKit

extension MTMapView {
    
    static func create(delegate: MTMapViewDelegate, bound: CGRect) -> MTMapView {
        let result = MTMapView(frame: bound)
        result.delegate = delegate
        result.baseMapType = .standard
        return result
    }
}
