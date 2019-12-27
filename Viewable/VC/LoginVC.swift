//
//  LoginVC.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/28.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import UIKit
import KakaoOpenSDK

class LoginVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func kakaoLogin(_ sender: Any) {
           //이전 카카오톡 세션 열려있으면 닫기
           guard let session = KOSession.shared() else {
               return
           }
           if session.isOpen() {
               session.close()
           }
           session.open(completionHandler: { (error) -> Void in
               if error == nil {
                   if session.isOpen() {
                       //accessToken
                       print(session.token?.accessToken)
                   } else {
                       print("Login failed")
                   }
               } else {
                   print("Login error : \(String(describing: error))")
               }
               if !session.isOpen() {
                   if let error = error as NSError? {
                       switch error.code {
                       case Int(KOErrorCancelled.rawValue):
                           break
                       default:
                           //간편 로그인 취소
                           print("error : \(error.description)")
                       }
                   }
               }
           })
       }

}
