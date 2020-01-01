//
//  BuildInfo.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/28.
//  Copyright © 2019 Yeaeun. All rights reserved.
//
import Foundation

// MARK: - ShopInfoVO
struct BuildInfo: Codable {
    let success: Bool
    let status: Int
    let message: String
    let data: Facil
}

// MARK: - DataClass
struct Facil: Codable {
    let buildingIdx: Int
    let name: String
    let latitude, longitude: Double
    let address: String
    let facility: [Int]
    let light: Int
}
