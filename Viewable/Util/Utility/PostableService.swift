//
//  PostableService.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/28.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


protocol PostableService {
    
    associatedtype NetworkData : Codable
    
    func post(_ URL:String, params : [String : Any], completion : @escaping (Result<NetworkData>)->Void)
    
    func delete(_ URL:String, params : [String : Any], completion : @escaping (Result<NetworkData>)->Void)
}

extension PostableService {
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    
    func post(_ URL:String, params : [String : Any], completion : @escaping (Result<NetworkData>)->Void){
        
        Alamofire.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseData(){
            res in
            
            switch res.result {
            case .success:
              
                if let value = res.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                         let data = try decoder.decode(NetworkData.self, from: value)
                        completion(.success(data))
                       
                    }catch{
                       
                        completion(.error("error"))
                    }
                }
                break
            case .failure(let err):
                completion(.failure(err))
                break
            }
        }
        
       
    }
    
    
    func delete(_ URL:String, params : [String : Any], completion : @escaping (Result<NetworkData>)->Void){
        
        Alamofire.request(URL, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: nil).responseData(){
            res in
            switch res.result {
            case .success:
                
                if let value = res.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let data = try decoder.decode(NetworkData.self, from: value)
                        completion(.success(data))
                        
                    }catch{
                        
                        completion(.error("error"))
                    }
                }
                break
            case .failure(let err):
                completion(.failure(err))
                break
            }
        }
        
        
    }
}
