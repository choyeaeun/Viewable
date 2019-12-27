//
//  HttpResponseCode.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/28.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

enum HttpResponseCode: Int{
    case GET_SUCCESS = 200
    case POST_SUCCESS = 201
    case WRONG_REQUEST = 400
    case SERVER_ERROR = 500
}
