//
//  BuildInfo.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/28.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

// MARK: - BuildInfo
struct BuildInfo: Codable {
    let success: Bool
    let status: Int
    let message: String
    let data: [Facil]
}

// MARK: - Datum
struct Facil: Codable {
    let buildingIdx, facilityIdx: Int
    let name: String
}
