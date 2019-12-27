//
//  GettableService.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/28.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON

protocol GettableService {
    associatedtype NetworkData : Codable
    func get(_ URL:String, completion : @escaping (Result<NetworkData>)->Void)
    
}

extension GettableService {

    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    
    
    func get(_ URL:String, completion : @escaping (Result<NetworkData>)->Void){
        Alamofire.request(URL).responseData {(res) in
            switch res.result {
            case .success :
                
                if let value = res.result.value {
        
                    let decoder = JSONDecoder()
                
                    
                    //do try catch 아예 컴플리션 쪽에서 처리가능
                    // 통신 성공 자체를 .success 로 본다면.
                    do {
                        let data = try decoder.decode(NetworkData.self, from: value)
                        
                            completion(.success(data))

                    }catch{
                        
                        completion(.error("에러"))
                    }
                }
                break
            case .failure(let err) :
                completion(.failure(err))
                break
            }
            
        }
    }
}
