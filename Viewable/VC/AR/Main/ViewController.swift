//
//  ViewController.swift
//  Viewable
//
//  Created by 조예은 on 09/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import UIKit
import ARKit
import CoreLocation
import ARCL

class ViewController: UIViewController{
    
    // locationManager 변수
    let locManager: CLLocationManager = CLLocationManager()
    // pin 찍는 뷰
    var sceneLocationView = SceneLocationView()
    let pinImg = UIView()
    
    //ar 이미지 정보
    var building: [ARData] = []
    var buildingBackup: [ARData] = []
    var buildingIdx: Int = 0
    let curTime = Date().timeIntervalSince1970
    
    //building 정보
    var facility: Facil?
    var facilityArr: [Bool] = [false, false, false, false]
    var facilityArrar: [Bool] = [false, false, false, false]
    var sendBuildingID: Int = 0
    
    @IBOutlet var buildingInfoView: UIView!
    
    @IBOutlet var buildingName: UILabel!
    @IBOutlet var buildingAddress: UILabel!
    //index 값 받아서 isSelected 바꿔주기
    @IBOutlet var facilityList: [UIButton]!
    @IBOutlet var yeoungIMG: UIImageView!
    
    
    override func viewDidLoad() {
        sleep(2)
        super.viewDidLoad()
        view.insertSubview(sceneLocationView, at: 1)
//        buildingBoardInit(idx: 4)
        self.buildingInfoView.frame.origin.y = 667
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sceneLocationView.run()
        super.viewWillAppear(animated)
        navigationController?.navigationItem.backBarButtonItem?.title = ""
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 위치 기반 서비스가 활성화 되어 있으면
        if CLLocationManager.locationServicesEnabled(){
            // 권한 상태가 거부되어 있거나 제한되어 있다면 오류발생
            if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
                let alert = UIAlertController(title: "오류 발생", message: "위치 서비스 기능 꺼져있음", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            // 모두 활성화 되어 있다면 실행
            }else{
                locManager.desiredAccuracy = kCLLocationAccuracyBest
                locManager.delegate = self
                locManager.requestWhenInUseAuthorization()
                self.locManager.startUpdatingLocation()
            }
        }
        // 위치 기반 서비스가 비활성화 되어 있다면
        else {
            let alert = UIAlertController(title: "오류발생", message: "위치서비스 제공 불가", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        self.ViewPin(latitude: "37.544401", longitude: "126.952659", altitude: 42, buildingArr: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.locManager.stopUpdatingLocation()
        
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        sceneLocationView.pause()
    }
    
    func arBoardInit(url : String, lat : String, long: String){
        ARService.shareInstance.arInit(url: "\(APIService.BaseURL)/building?time=\(String(describing: curTime))&latitude=\(lat)&longitude=\(long)", completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let ardata):
                if let vo = ardata as? ARVO {
                    self.building = vo.data
                }
            case .networkFail :
//                self.simpleAlert(title: "network", message: "check")
                break
            default :
                break
            }
            
        })
    }
    func buildingBoardInit(idx: Int){
            BuildingService.shareInstance.buildingBoardInit(url: "\(APIService.BaseURL)/building/\(idx)" ,completion: { [weak self] (result) in
                        guard let `self` = self else { return }
                        
                        switch result {
                        case .networkSuccess(let data):
                            if let vo = data as? BuildInfo {
                                guard let buildingFac: Facil = vo.data else { return }
                                //편의시설 색 칠하기
                                for i in 0...self.facilityList.count-1 { self.facilityList[i].isSelected = false }
                                var i : Int = buildingFac.facility.count
                                if buildingFac.buildingIdx == 1{
                                    self.facilityList[0].isSelected = true
                                    self.facilityList[1].isSelected = true
                                    self.facilityList[2].isSelected = true
                                    self.facilityList[3].isSelected = true
                                }else if buildingFac.buildingIdx == 5{
                                    self.facilityList[0].isSelected = true
                                    self.facilityList[1].isSelected = false
                                    self.facilityList[2].isSelected = false
                                    self.facilityList[3].isSelected = true
                                }else{
                                    self.facilityList[0].isSelected = false
                                    self.facilityList[1].isSelected = true
                                    self.facilityList[2].isSelected = true
                                    self.facilityList[3].isSelected = false
                                    
                                }
//                                if i > 0 {
//                                    while(true){
//                                        self.facilityList[buildingFac.facility[i-1]].isSelected = true
//                                        i -= 1
//                                        if i <= 0 { break }
//                                    }
//
//                                }
                                self.buildingName.text = buildingFac.name
                                self.buildingAddress.text = buildingFac.address
                                switch buildingFac.light{
                                case 3:
                                    self.yeoungIMG.image = #imageLiteral(resourceName: "bigConditionGreatIc")
                                case 2:
                                    self.yeoungIMG.image = #imageLiteral(resourceName: "bigConditionSosoIc")
                                case 1:
                                    self.yeoungIMG.image = #imageLiteral(resourceName: "bigConditionBadIc")
                                default:
                                    self.yeoungIMG.image = #imageLiteral(resourceName: "bigConditionBadIc")
                                }
                                self.sendBuildingID = buildingFac.buildingIdx
                                self.buildingInfoView.setNeedsDisplay()
                            }
                        case .networkFail :
            //                self.simpleAlert(title: "network", message: "check")
                            break
                        default :
                            break
                        }
                        
                    })
        }
    
    func getLocationNode(node: SCNNode) -> LocationAnnotationNode? {
        if node.isKind(of: LocationNode.self) {
            return node as? LocationAnnotationNode
        } else if let parentNode = node.parent {
            return getLocationNode(node: parentNode)
        }
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let touch = touches.first {
            if touch.view != nil {
                let sceneView = self.sceneLocationView
                let location = touch.location(in: sceneView)
                let hitTest = sceneView.hitTest(location)
                
                if (!hitTest.isEmpty){
                    let results = hitTest.first!
                    let currentNode = results.node
                    if let locationNode = getLocationNode(node: currentNode) {
                        guard let idx = locationNode.tag else {return}
                        buildingBoardInit(idx: Int(idx)!)
                    }
                    self.buildingInfoView.frame.origin.y = 374
                }else if ((event?.touches(for: buildingInfoView)) != nil) {
                    self.buildingInfoView.frame.origin.y = 374
                }
                else{
                    self.buildingInfoView.frame.origin.y = 667
                }
                
            }
        }
    }
    
    // 특정 위치에 pin 꽂기
    func ViewPin(latitude:String, longitude:String, altitude:Double, buildingArr: Int){
        
//        let location:CLLocation = CLLocation(coordinate: CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!), altitude: altitude)
//
//        guard let view = Bundle.main.loadNibNamed("ARView", owner: self, options: nil)?.first as? ARView else { return }
//        let oneBuilding: ARData = building[buildingArr]
//        for i in 0...view.facility.count-1 { view.facility[i].isSelected = false }
//        var i : Int = oneBuilding.facility.count
////        if i > 0 {
////            while(true){
////                view.facility[oneBuilding.facility[i-1]].isSelected = true
////                i -= 1
////                if i <= 0 { break }
////            }
////        }
//        //아님 buildingBoard 데이터 가져와서 빌딩 인덱스로 판별해줘도 될듯
//        guard var buildingText = view.name.text else {return}
//        buildingText = self.building[buildingArr].name
////        view.name.text = self.building[buildingArr].name
//        print(buildingText)
//        print(self.building[buildingArr].facility)
//        switch building[buildingArr].light {
//        case 3:
//            view.light.image = #imageLiteral(resourceName: "conditionGreatIc")
//        case 2:
//            view.light.image = #imageLiteral(resourceName: "conditionSosoIc")
//        case 1:
//            view.light.image = #imageLiteral(resourceName: "conditionBadIc")
//        default:
//            view.light.image = #imageLiteral(resourceName: "bigConditionBadIc")
//        }
        let location1:CLLocation = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 37.544401, longitude: 126.952659), altitude: altitude)
        
        guard let view1 = Bundle.main.loadNibNamed("ARView2", owner: self, options: nil)?.first as? UIImageView else { return }
        view1.image = #imageLiteral(resourceName: "arJeilbuilding")
        
        let annotationNode1: LocationAnnotationNode = LocationAnnotationNode(location: location1, view: view1)
        annotationNode1.tag = "1"
//        view1.name.text = "제일빌딩"
//        view1.facility[0].isSelected = true
//        view1.facility[1].isSelected = true
//        view1.facility[2].isSelected = true
//        view1.facility[3].isSelected = true
//        view1.light.image = #imageLiteral(resourceName: "conditionGreatIc")
//        sceneLocationView.addLocationNodeForCurrentPosition(locationNode: annotationNode)
//        annotationNode1.tag = "\(building[buildingArr].buildingIdx)"
        
        guard let view2 = Bundle.main.loadNibNamed("ARView2", owner: self, options: nil)?.first as? UIImageView else { return }
        view2.image = #imageLiteral(resourceName: "arRenaissancetower")
        
        let location2:CLLocation = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 37.543875, longitude: 126.952732), altitude: altitude)
        let annotationNode2:LocationAnnotationNode = LocationAnnotationNode(location: location2, view: view2)
        annotationNode2.tag = "5"
//        view2.name.text = "한국사회복지회관 르네상스타워"
//        view2.facility[0].isSelected = true
//        view2.facility[1].isSelected = false
//        view2.facility[2].isSelected = false
//        view2.facility[3].isSelected = true
//        view2.light.image = #imageLiteral(resourceName: "conditionSosoIc")
//        sceneLocationView.addLocationNodeForCurrentPosition(locationNode: <#T##LocationNode#>)
        
        guard let view3 = Bundle.main.loadNibNamed("ARView2", owner: self, options: nil)?.first as? UIImageView else { return }
        view3.image = #imageLiteral(resourceName: "arGongdukbuilding")
        
        let location3:CLLocation = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 37.545524, longitude: 126.95166), altitude: altitude)
        let annotationNode3:LocationAnnotationNode = LocationAnnotationNode(location: location3, view: view3)
        annotationNode3.tag = "4"
//        view3.name.text = "공덕빌딩"
//        view3.facility[0].isSelected = false
//        view3.facility[1].isSelected = true
//        view3.facility[2].isSelected = true
//        view3.facility[3].isSelected = false
//        view3.light.image = #imageLiteral(resourceName: "conditionSosoIc")

        
//        sceneLocationView.addLocationNodesForCurrentPosition(locationNodes: [annotationNode1, annotationNode2, annotationNode3])
        sceneLocationView.addLocationNodesWithConfirmedLocation(locationNodes: [annotationNode1, annotationNode2, annotationNode3])
//        sceneLocationView.add
        print("new pin plz")
//        print("new pin!!!",building[buildingArr].name)
    }
    
    func removePin(){
        sceneLocationView.removeAllNodes()
    }
// MARK: - 버튼 액션
    // 보유시설 기능 설명 뷰로 넘어가는 액션
    @IBAction func infromationAction(_ sender: UIButton) {
        guard let infoVC = self.storyboard?.instantiateViewController(identifier: "facilityInfoVC") as? facilityInfoVC
            else { return }

        self.present(infoVC, animated: true)
        
    }
    
    //매장 리스트로 넘어가기
    @IBAction func goShopList(_ sender: UIButton) {
        
        guard let listVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShopListVC") as? ShopListVC else { return }
        listVC.buildingId = self.sendBuildingID
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    
    //편의 시설 개별 설명뷰로 넘어가기
    @IBAction func exAccess(_ sender: UIButton) {
        let idx:Int = sender.tag
        guard let explainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "OneFacilityInfoVC") as? OneFacilityInfoVC else { return }
        explainVC.modalPresentationStyle = .overCurrentContext
        explainVC.index = idx
        self.present(explainVC, animated: true)
    }
    
    //신고하기 뷰로 넘어가기
    @IBAction func goReport(_ sender: UIButton) {
        guard let reportVC = UIStoryboard(name: "Report", bundle: nil).instantiateViewController(identifier: "ReportViewController") as? ReportViewController else { return }
        
        reportVC.selectedBuilding = self.building[1].buildingIdx
        self.present(reportVC, animated: true)
    }
    //마이페이지 뷰로 넘어가기
    @IBAction func goMypage(_ sender: Any) {
        guard let mypageVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(identifier: "MyPageViewController") as? MyPageViewController else { return }
        self.navigationController?.pushViewController(mypageVC, animated: true)
    }
    //지도 뷰로 넘어가기
    @IBAction func goSearch(_ sender: Any) {
        guard let searchVC = UIStoryboard(name: "Map", bundle: nil).instantiateViewController(identifier: "SearchViewController") as? SearchViewController else { return }
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    
    // MARK: - 위치기반 서비스 관련
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = view.bounds
    }
}

//MARK: - CLLoactionManagerDelegate
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location: CLLocation = locations[locations.count-1]
        
        // 위도와 경도
        let latitude: Double = Double(location.coordinate.latitude)
        let longitude: Double = Double(location.coordinate.longitude)
        let altitude: Double = Double(location.altitude)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.roundingMode = .floor         // 형식을 버림으로 지정
        numberFormatter.minimumSignificantDigits = 6  // 자르길 원하는 자릿수
        numberFormatter.maximumSignificantDigits = 6
        guard let newlatitude = numberFormatter.string(from: NSNumber(value: latitude)),
            let newlongitude = numberFormatter.string(from: NSNumber(value: longitude))
        else {
            return
        }
        
        arBoardInit(url: "\(APIService.BaseURL)/building", lat: newlatitude, long: newlongitude)
//        arBoardInit(url: "\(APIService.BaseURL)/building", lat: "37.544401", long: "126.952659")
//        print(newlatitude, newlongitude, altitude)
//        if self.buildingBackup != self.building {
//            self.removePin()
//            for i in 0...building.count - 1{
//                self.ViewPin(latitude: self.building[i].latitude.description, longitude: self.building[i].longitude.description, altitude: altitude, buildingArr: i)
//            }
//            self.buildingBackup = self.building
//        }
    }
}
