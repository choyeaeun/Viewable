//
//  ShopDetailVC.swift
//  Viewable
//
//  Created by 조예은 on 21/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import UIKit

class ShopDetailVC: UIViewController, MTMapViewDelegate {

    @IBOutlet var smallMapView: UIView!
    var mapView: MTMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MTMapView(frame: smallMapView.bounds)
        if let mapView = mapView{
            mapView.delegate = self
            mapView.baseMapType = .standard
            smallMapView.addSubview(mapView)
        }
    }
    
}
