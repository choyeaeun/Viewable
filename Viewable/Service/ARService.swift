//
//  ARService.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/28.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ARService: GettableService {
    typealias NetworkData = ARVO
    static let shareInstance = ARService()
    
    func arInit(url : String, completion : @escaping (NetworkResult<Any>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                
                switch networkResult.message {
                case "success" :
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
