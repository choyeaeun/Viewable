//
//  ReportService.swift
//  Viewable
//
//  Created by deokwon on 28/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

struct ReportService: PostableService {
    typealias NetworkData = ReportVO
    static let shareInstance = ReportService()
    
    func sendReport(url : String, title: String, contents: String) {
        post(url, params: ["title": title, "contents": contents]) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "success" :
                    break
                case "Internal Server Error!" :
                    break
                default :
                    break
                }
                break
            case .error(let errMsg) :
                print(errMsg)
                break
            case .failure(_) :
                break
            }
        }
    }
}
