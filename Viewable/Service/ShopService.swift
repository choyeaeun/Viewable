//
//  ShopService.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/28.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation
struct ShopService: GettableService {
    typealias NetworkData = ShopInfoVO
    static let shareInstance = ShopService()
    
    func shopBoardInit(url : String, completion : @escaping (NetworkResult<Any>) -> Void){
        
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
