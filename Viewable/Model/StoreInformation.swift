//
//  StoreInformation.swift
//  Viewable
//
//  Created by 김덕원 on 16/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

struct StoreInformation: Codable {
    var name: String
    var address: String
    var phone: String
    var facilities: [Int]
    var category: Int
    var thumbnail: String
    
//    추후 필요하다면 이용
//    enum CodingKeys: String, CodingKey {
//        case cityName = "city_name"
//        case rainfallProbability = "rainfall_probability"
//        case celsius
//        case state
//    }
}
