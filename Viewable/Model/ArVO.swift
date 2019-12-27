//
//  ArVO.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/28.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

// MARK: - ARVO
struct ARVO: Codable {
    let success: Bool
    let status: Int
    let message: String
    let data: [Data]
}

// MARK: - Data
struct Data: Codable {
    let buildingIdx: Int
    let name, address: String
    let latitude, longitude, distance: Double
}
