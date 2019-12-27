//
//  OneFacilityInfoVC.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/27.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import UIKit

class OneFacilityInfoVC: UIViewController {

    
    @IBOutlet var titleFacility: UILabel!
    @IBOutlet var contents: UILabel!
    @IBOutlet var img1: UIRadiusImageView!
    @IBOutlet var img2: UIRadiusImageView!
    @IBOutlet var img3: UIRadiusImageView!
    
    var index:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch index {
        case 1:
            titleFacility.text = "주,출입구 접근로 여부"
            contents.text = "-접근로의 유효폭 1.5미터이상 \n-접근로와 차도의 경계는 완전 분리하여 설치되어야 합니다.\n-대지 경계면에서 주출입구까지 점자 유도블록이\n설치되어야 합니다."
        case 2:
            titleFacility.text = "장애인용 승강기"
            contents.text = "-접근로의 유효폭 1.5미터이상 \n-접근로와 차도의 경계는 완전 분리하여 설치되어야 합니다.\n-대지 경계면에서 주출입구까지 점자 유도블록이\n설치되어야 합니다."
        case 3:
            titleFacility.text = "장애인용 화장실"
            contents.text = "-접근로의 유효폭 1.5미터이상 \n-접근로와 차도의 경계는 완전 분리하여 설치되어야 합니다.\n-대지 경계면에서 주출입구까지 점자 유도블록이\n설치되어야 합니다."
        case 4:
            titleFacility.text = "장애인 주차구역"
            contents.text = "-접근로의 유효폭 1.5미터이상 \n-접근로와 차도의 경계는 완전 분리하여 설치되어야 합니다.\n-대지 경계면에서 주출입구까지 점자 유도블록이\n설치되어야 합니다."
        default:
            titleFacility.text = "주,출입구 접근로 여부"
            contents.text = "-접근로의 유효폭 1.5미터이상 \n-접근로와 차도의 경계는 완전 분리하여 설치되어야 합니다.\n-대지 경계면에서 주출입구까지 점자 유도블록이\n설치되어야 합니다."
        }
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
