//
//  ShopInfo.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/28.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

// MARK: - ShopInfoVO
struct ShopInfoVO: Codable {
    let success: Bool
    let status: Int
    let message: String
    let data: Detail
}

// MARK: - DataClass
struct Detail: Codable {
    let buildingIdx, storeIdx: Int
    let name: String
    let img: String
    let phone, address, operating, category: String
    let categoryIdx: Int
    let latitude, longitude: Double
    let facilities: [Int]
}
