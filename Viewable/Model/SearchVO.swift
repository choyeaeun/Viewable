//
//  SearchVO.swift
//  Viewable
//
//  Created by deokwon on 28/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

struct SearchCategoryVO: Codable {
    let success: Bool
    let status: Int
    let message: String
    let data: StoreListData
}

struct StoreListData: Codable {
    let storeList: [StoreData]
}

struct StoreData: Codable {
    let address: String
    let buildingIdx: Int
    let buildingName: String
    let categoryIdx: Int
    let img: String
    let name: String
    let operating: String
    let phone: String
    let storeIdx: Int
    let latitude: Double // 위도
    let longitude: Double // 경도
    let light: Int // 3 = 파란불, 2 = 노란불, 1 = 빨간불
    let facility: [Int]
}
