//
//  FilterVO.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/28.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

// MARK: - FilterVO
struct FilterVO: Codable {
    let success: Bool
    let status: Int
    let message: String
    let data: FilterStore
}

// MARK: - DataClass
struct FilterStore: Codable {
    let storeList: [FilterList]
}

// MARK: - StoreList
struct FilterList: Codable {
    let storeIdx: Int
    let name: String
    let img: String
    let phone, address, operating: String
    let buildingIdx, categoryIdx, storeFacilityIdx: Int
    let facility: [Int]
}
