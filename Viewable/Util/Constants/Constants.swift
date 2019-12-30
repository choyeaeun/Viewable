//
//  Constants.swift
//  Viewable
//
//  Created by 김덕원 on 16/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

struct Constants {
    static let facilities = [
        Facilitie(icon: #imageLiteral(resourceName: "facilitySmallBlAccessRoadIc"), name: "주,출입구 접근로", info: "접근로의 유효폭 1.5미터이상 확보되어야 합니다.\n접근로는 단차 없이 기울기 1/18이하로 설치되어야 합니다.\n접근로와 차도의 경계는 완전 분리하여 설치되어야 합니다.\n대지 경계면에서 주출입구까지 점자 유도블록 설치되어야 합니다."),
        Facilitie(icon: #imageLiteral(resourceName: "facilitySmallBlLiftIc"), name: "장애인용 승강기", info: "장애인용승강기 전용 호출버튼을 구분하여 설치되어야합니다.\n장애인용승강기 호출버튼(외부) 층수안내점자표지판을 부착해야합니다.\n장애인용승강기 내부 후면거울이 설치되어 있어야합니다."),
        Facilitie(icon: #imageLiteral(resourceName: "facilitySmallBlBathroomIc"), name: "장애인용 화장실", info: "장애인용화장실 위치 및 유도안내표지판 설치되어 있어야합니다.\n장애인용화장실 대변기출입문까지 통로구간의 유효폭은 1.2미터 이상 확보되어야 합니다.\n장애인용화장실 대변기 유효바닥면적 폭1.6미터, 깊이 2.0미터이상이어야 합니다.\n(단, 기존건물에 설치시 유효바닥면적 폭 1.0미터 이상, 깊이 1.8미터 이상)\n장애인용화장실 대변기출입문은 자동문으로 설치해야 합니다.\n장애인용화장실 세정장치는 광감지식 설치해야합니다.\n장애인용화장실 대변기에는 비데 및 등받이를 설치해야합니다.\n장애인전용화장실 내 세면대를 설치(거울 및 회전식수평손잡이포함)해야합니다.\n장애인용화장실 대변기 측면에는 비상용벨 및 통화장치를 설치해야합니다.\n소변기손잡이는 각 층별 일반화장실 내에 1개소이상 설치해야합니다.\n화장실 입구 점자 안내판 설치해야합니다."),
        Facilitie(icon: #imageLiteral(resourceName: "facilitySmallBlParkingIc"), name: "장애인 주차구역", info: "장애인전용주차구역 위치(층수표기) 및 유도안내표지판 설치해야합니다.\n장애인전용주차구역 내 감시카메라(CCTV) 설치해야합니다."),
        Facilitie(icon: #imageLiteral(resourceName: "facilitySmallBlRemoveHightIc"), name: "주,출입구 높이차이 제거", info: "주출입구는 높이차이(단차) 없이 설치해야합니다.\n(다만, 단차이로 인한 경사로 설치시 기울기 1/18이하로 설치)"),
        Facilitie(icon: #imageLiteral(resourceName: "facilitySmallBlInfoServiceIc"), name: "안내 서비스", info: "음성안내 및 호출버튼이 설치된 촉지도식(반구형) 안내판이 설치되어야합니다\n* 호출시 보조안내서비스 제공\n청각장애인 이용 가능한 문자안내표지판이 설치되어야합니다.\n비상(화재) 대비용 시각경보기가 설치되어야합니다.\n주요 실명 점자표지판 출입문 옆 측면에 부착되어야합니다."),
        Facilitie(icon: #imageLiteral(resourceName: "facilitySmallBlChargerIc"), name: "휠체어 충전", info: "전동휠체어 급속충전기(공기주입 일체형)가 설치되어 있어야합니다."),
        Facilitie(icon: #imageLiteral(resourceName: "facilitySmallBlEntranceIc"), name: "출입구", info: "주출입문은 자동문으로 설치되어야 합니다.\n(다만, 자동문이 아닐 경우 비상통화장치 설치)"),
        Facilitie(icon: #imageLiteral(resourceName: "facilitySmallBlFirstFloorIc"), name: "1층", info: "1층에 위치하여 접근성이 편리합니다."),
    ]
    
    static let categories = [
        Category(image: #imageLiteral(resourceName: "searchStoreFoodBt"), name: "음식점", iconName: "Food"),
        Category(image: #imageLiteral(resourceName: "searchStorePostofficeBt"), name: "우체국", iconName: "Postoffice"),
        Category(image: #imageLiteral(resourceName: "searchStoreConveniencestoreBt"), name: "편의점", iconName: "Conveniencestore"),
        Category(image: #imageLiteral(resourceName: "searchStoreCafeBt"), name: "카페", iconName: "Cafe"),
        Category(image: #imageLiteral(resourceName: "searchStoreMartBt"), name: "마트", iconName: "Mart"),
        Category(image: #imageLiteral(resourceName: "searchStoreBankBt"), name: "은행", iconName: "Bank"),
        Category(image: #imageLiteral(resourceName: "searchStorePharmacyBt"), name: "약국", iconName: "Pharmacy"),
    ]
}
