//
//  Category.swift
//  Viewable
//
//  Created by 김덕원 on 25/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

struct Category {
    let image: UIImage
    let name: String
    let largeMarkers: [String]
    let smallMarkers: [String]
    
    init(image: UIImage, name: String, iconName: String) {
        self.image = image
        self.name = name
        
        var tempLargeMarkers: [String] = []
        ["mapBigRdStore@#@Ic", "mapBigYlStore@#@Ic", "mapBigBlStore@#@Ic"].forEach { largeMarkerName in
            tempLargeMarkers.append(largeMarkerName.replacingOccurrences(of: "@#@", with: iconName))
        }

        var tempSmallMakers: [String] = []
        ["mapRdStore@#@Ic", "mapYlStore@#@Ic", "mapBlStore@#@Ic"].forEach{ smallMarkerName in
            tempSmallMakers.append(smallMarkerName.replacingOccurrences(of: "@#@", with: iconName))
        }
        
        largeMarkers = tempLargeMarkers
        smallMarkers = tempSmallMakers
    }
}
