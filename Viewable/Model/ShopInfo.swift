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
    let data: DataStore
}

// MARK: - DataClass
struct DataStore: Codable {
    let storeList: [StoreList]
}

// MARK: - StoreList
struct StoreList: Codable {
    let storeIdx: Int
    let name: String
    let img: String
    let phone, address, operating: String
    let buildingIdx, categoryIdx, storeFacilityIdx: Int
    let facility: [Int]
}
