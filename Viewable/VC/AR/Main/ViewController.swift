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
    
    var building: [ARData] = []
    var buildingBackup: [ARData] = []
    var buildingIdx: Int = 0
    let curTime = Date().timeIntervalSince1970
    
    var buildingFac: [Facil] = []
    var facilityArr: [Bool] = [false, false, false, false]
    var facilityArrar: [Bool] = [false, false, false, false]
    
    @IBOutlet var buildingInfoView: UIView!
    
    @IBOutlet var buildingName: UILabel!
    @IBOutlet var buildingAddress: UILabel!
    //index 값 받아서 isSelected 바꿔주기
    @IBOutlet var facilityList: [UIButton]!
    @IBOutlet var yeoungIMG: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        buildingInfoView.layer.zPosition = 10
        sceneLocationView.run()
        view.insertSubview(sceneLocationView, at: 1)
//        view.addSubview(sceneLocationView)
        //터치 후 view 올라오게 한 뒤 위치 변경
        buildingBoardInit(idx: 4)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationItem.backBarButtonItem?.title = ""
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    func arBoardInit(url : String, lat : String, long: String){
        ARService.shareInstance.arInit(url: "\(APIService.BaseURL)/building?time=\(String(describing: curTime))&latitude=\(lat)&longitude=\(long)", completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let ardata):
                if let vo = ardata as? ARVO {
                    self.building = vo.data
                }
                if (self.building.count > 1) {
                    self.buildingName.text = self.building[1].name
                    self.buildingAddress.text = self.building[1].address
                    switch self.building[1].light{
                    case 3:
                        self.yeoungIMG.image = #imageLiteral(resourceName: "bigConditionGreatIc")
                    case 2:
                        self.yeoungIMG.image = #imageLiteral(resourceName: "bigConditionSosoIc")
                    case 1:
                        self.yeoungIMG.image = #imageLiteral(resourceName: "bigConditionBadIc")
                    default:
                        self.yeoungIMG.image = #imageLiteral(resourceName: "bigConditionBadIc")
                    }
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
                                self.buildingFac = vo.data
                                for i in 0...self.buildingFac.count-1{
                                    self.facilityArr[self.buildingFac[i].facilityIdx-1] = true
                                }
                                for i in 0...self.facilityList.count-1{
                                    self.facilityList[i].isSelected = self.facilityArr[i]
                                }
                            }
                        case .networkFail :
            //                self.simpleAlert(title: "network", message: "check")
                            break
                        default :
                            break
                        }
                        
                    })
        }

    @objc func someAction(_ sender:UITapGestureRecognizer){
       print("AR Action!!")
    }
    
    // 특정 위치에 pin 꽂기
    func ViewPin(latitude:String, longitude:String, altitude:Double, buildingArr: Int){
        
        let location:CLLocation = CLLocation(coordinate: CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!), altitude: altitude)
        
        let xibName = "ARView"
        guard let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as? ARView
        else {
            return
        }
//        if building[buildingArr].facility.count <= 0{
//            for i in 0...3{
//                view.facility[i].isSelected = false
//            }
//        }else{
//            for i in 0...building[buildingArr].facility.count-1{
////                        facilityArrar[building[buildingArr].facility[i]] = true
//                        print(building[buildingArr].facility[i])
//                    }
//                    for i in 0...view.facility.count-1{
//                        view.facility[i].isSelected = self.facilityArrar[i]
//                    }
//        }
        
        view.name.text = self.building[buildingArr].name
        print(self.building[buildingArr].facility)
        switch building[buildingArr].light {
        case 3:
            view.light.image = #imageLiteral(resourceName: "conditionGreatIc")
        case 2:
            view.light.image = #imageLiteral(resourceName: "conditionSosoIc")
        case 1:
            view.light.image = #imageLiteral(resourceName: "conditionBadIc")
        default:
            view.light.image = #imageLiteral(resourceName: "bigConditionBadIc")
        }
        let annotationNode: LocationAnnotationNode = LocationAnnotationNode(location: location, view: view)
//        annotationNode.annotationNode.name = "what is"
        sceneLocationView.addLocationNodeForCurrentPosition(locationNode: annotationNode)
        print("new pin!!!")

        let gesture = UITapGestureRecognizer(target: self, action: Selector(("someAction:")))
        self.view.addGestureRecognizer(gesture)
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
    @IBAction func goReport(_ sender: UIButton) {
        guard let reportVC = UIStoryboard(name: "Report", bundle: nil).instantiateViewController(identifier: "ReportViewController") as? ReportViewController else { return }
        
        reportVC.selectedBuilding = self.building[1].buildingIdx
        self.present(reportVC, animated: true)
    }
    
    // MARK: - 위치기반 서비스 관련
    override func viewDidAppear(_ animated: Bool) {
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.locManager.stopUpdatingLocation()
        
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
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
        numberFormatter.maximumSignificantDigits = 8
        guard let newlatitude = numberFormatter.string(from: NSNumber(value: latitude)),
            let newlongitude = numberFormatter.string(from: NSNumber(value: longitude))
        else {
            return
        }
        
        arBoardInit(url: "\(APIService.BaseURL)/building", lat: newlatitude, long: newlongitude)
//        arBoardInit(url: "\(APIService.BaseURL)/building", lat: "37.544401", long: "126.952659")
        print(newlatitude, newlongitude)
        if self.buildingBackup != self.building {
            self.removePin()
            for i in 0...building.count-1{
                self.ViewPin(latitude: self.building[i].latitude.description, longitude: self.building[i].longitude.description, altitude: altitude, buildingArr: i)
            }
            self.buildingBackup = self.building
        }
    }
}
