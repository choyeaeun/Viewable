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
    
    var sceneLocationView = SceneLocationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
    }
    
    func ViewPin(latitude:Double, longitude:Double, altitude:Double){
        
        var location:CLLocation = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 37.498875, longitude: 127.027598), altitude: altitude+10)
        //let view = UIView() // or a custom UIView subclass
        let image:UIImage = UIImage(named: "group5Copy")!
        //let annotationNode = LocationAnnotationNode(location: location, view: view)
        var annotationNode: LocationAnnotationNode = LocationAnnotationNode(location: location, image: image)
        annotationNode.annotationNode.name = "fastfive"
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        
        location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 37.500362, longitude: 127.027006), altitude: altitude+10)
        annotationNode = LocationAnnotationNode(location: location, image: image)
        annotationNode.annotationNode.name = "megabox"
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
    }
    
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
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()

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
        ViewPin(latitude: latitude, longitude: longitude, altitude: altitude)
        print(latitude, longitude, altitude)
    }
}
