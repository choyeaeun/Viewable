//
//  ListVO.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/29.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

// MARK: - ListVO
struct ListVO: Codable {
    let success: Bool
    let status: Int
    let message: String
    let data: [StoreLine]
}

// MARK: - Datum
struct StoreLine: Codable {
    let storeIdx: Int
    let name: String
    let img: String
    let phone: String
    let address: String
    let operating: String
    let categoryIdx: Int
    let facility: [Int]
}
