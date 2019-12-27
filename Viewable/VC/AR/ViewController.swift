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
        view.insertSubview(sceneLocationView, at: 0)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationItem.backBarButtonItem?.title = ""
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("\ntap!!!!!!")
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        UIView.animate(withDuration: 1) {
            self.buildingInfoView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }
//        buildingInfoView.
        // Your action
    }
    
    
    func arBoardInit(url : String, lat : Double, long: Double){
        ARService.shareInstance.arInit(url: "\(APIService.BaseURL)/building?time=\(String(describing: curTime))&latitude=\(lat)&longitude=\(long)", completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let ardata):
                if let vo = ardata as? ARVO {
                    self.building = vo.data
                }
//                let nearBuilding = self.building[0]
//                self.buildingName.text = String(nearBuilding.name)
            case .networkFail :
//                self.simpleAlert(title: "network", message: "check")
                break
            default :
                break
            }
            
        })
    }
    
    
    // 특정 위치에 pin 꽂기
    func ViewPin(latitude:Double, longitude:Double, altitude:Double){
        
        var location:CLLocation = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 37.498875, longitude: 127.027598), altitude: altitude+10)
        
        let image:UIImage = UIImage(named: "group5Copy")!
        let imageView = UIImageView(image: image)
        self.pinImg.addSubview(imageView)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        pinImg.isUserInteractionEnabled = true
        pinImg.addGestureRecognizer(tapGestureRecognizer)
        
        var annotationNode: LocationAnnotationNode = LocationAnnotationNode(location: location, image: image)
        annotationNode.annotationNode.name = "fastfive"
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        
        location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 37.500362, longitude: 127.027006), altitude: altitude+10)
        annotationNode = LocationAnnotationNode(location: location, image: image)
        annotationNode.annotationNode.name = "megabox"
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
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
//        arBoardInit(url: "\(APIService.BaseURL)/building", lat: latitude, long: longitude)
        arBoardInit(url: "\(APIService.BaseURL)/building", lat: 37.544401, long: 126.952659)
        if self.buildingBackup != self.building {
            self.removePin()
            for i in 0...building.count-1{
                self.ViewPin(latitude: self.building[i].latitude, longitude: self.building[i].longitude, altitude: altitude)
                print("\nnew Piiiiiiin!!!!!!!\n")
            }
            self.buildingBackup = self.building
        }
    }
}
