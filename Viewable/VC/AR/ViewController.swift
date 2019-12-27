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
        let params : [String : Any] = [
            "latitude" : lat,
            "longitude" : long
        ]
        ARService.shareInstance.arInit(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
                
            case .networkSuccess(let PostionData):
               
                print(PostionData)
                break
                
            case .networkFail : break
//                self.simpleAlert(title: "network", message: "check")
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
// MARK: - 버튼 액션
    // 보유시설 기능 설명 뷰로 넘어가는 액션
    @IBAction func infromationAction(_ sender: UIButton) {
        guard let infoVC = self.storyboard?.instantiateViewController(identifier: "facilityInfoVC") as? facilityInfoVC
            else { return }

        self.present(infoVC, animated: true)
        
    }
    @IBAction func goShopList(_ sender: UIButton) {
        
        guard let listVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShopListVC") as? ShopListVC else { return }
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    
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
        //
        sceneLocationView.frame = view.bounds
    }
}

// MARK: - ARSKViewDelegate
extension ViewController: ARSKViewDelegate{
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
        let labelNode = SKLabelNode(text: "👾")
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        return labelNode;
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
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
        
        arBoardInit(url: "/building", lat: 37.544401, long: 126.952659)
        ViewPin(latitude: latitude, longitude: longitude, altitude: altitude)
        print(latitude, longitude, altitude)
    }
}
