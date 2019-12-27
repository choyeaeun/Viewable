//
//  MyPageVO.swift
//  Viewable
//
//  Created by deokwon on 28/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

struct MyPageVO: Codable {
    let success: Bool
    let status: Int
    let message: String
    let data: MyPageData
}

struct MyPageData: Codable {
    let userProfile: [MyPageUserProfile]
    let userReport: [MyPageUseReport]
}

struct MyPageUserProfile: Codable {
    let username: String
    let userImg: String?
}

struct MyPageUseReport: Codable {
    let title: String
    let contents: String
    let img: String
    let date: String
    let reception: String
    let name: String
}
