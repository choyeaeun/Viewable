//
//  ShopDetailVC.swift
//  Viewable
//
//  Created by 조예은 on 22/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import UIKit

class ShopDetailVC: UIViewController, MTMapViewDelegate {

    @IBOutlet var smallMapView: UIView!
    var mapView: MTMapView?
    @IBOutlet var facilityCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MTMapView(frame: smallMapView.bounds)
        if let mapView = mapView{
            mapView.delegate = self
            mapView.baseMapType = .standard
            smallMapView.addSubview(mapView)
        }
        
        facilityCV.delegate = self
        facilityCV.dataSource = self
    }
    
    @IBAction func goFacilityDetail(_ sender: UIButton) {
        guard let infoVC = self.storyboard?.instantiateViewController(identifier: "facilityInfoVC") as? facilityInfoVC
            else { return }
        
        self.present(infoVC, animated: true)
    }
}

extension ShopDetailVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = facilityCV.dequeueReusableCell(withReuseIdentifier: "ShopDetailCVCell", for: indexPath) as? ShopDetailCVCell
        else {
            return UICollectionViewCell()
        }
        cell.facilityIMG.image = #imageLiteral(resourceName: "reportBt")
        return cell
    }
    
    
}
