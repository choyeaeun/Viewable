//
//  APIService.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/28.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

struct APIService {
    
    // 전역 변수로 사용할 수 있게 APIConstants 선언하여 사용
    static let BaseURL = "http://15.164.90.221:4000"
    
    /* 유저(User) */
    static let LoginURL = BaseURL + "/user" // 로그인
}
