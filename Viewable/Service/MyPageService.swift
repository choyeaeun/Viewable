//
//  MyPageService.swift
//  Viewable
//
//  Created by deokwon on 28/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

struct MyPageService: GettableService {
    typealias NetworkData = MyPageVO
    static let shareInstance = MyPageService()
    
    func getData(url: String, completion : @escaping (NetworkResult<Any>) -> Void) {
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "성공" :
                    completion(.networkSuccess(networkResult))
                case "Internal Server Error!" :
                    completion(.serverErr)
                default :
                    break
                }
                break
            case .error(let errMsg) :
                print(errMsg)
                break
            case .failure(_) :
                completion(.networkFail)
            }
        }
    }
}
