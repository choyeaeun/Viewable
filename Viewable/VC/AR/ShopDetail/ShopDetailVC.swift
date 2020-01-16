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
    var daumMapView: MTMapView?
    var selectedStore:Int!
    var shopData: Detail!
    
    @IBOutlet var shopImg: UIImageView!
    @IBOutlet var shopName: UILabel!
    @IBOutlet var shopCategory: UILabel!
    @IBOutlet var shopState: UILabel!
    @IBOutlet var shopAddress: UILabel!
    @IBOutlet var shopAddress2: UILabel!
    @IBOutlet var shopTime: UILabel!
    @IBOutlet var shopNumber: UILabel!
    @IBOutlet var facilityImageView: [UIImageView]!
    @IBOutlet var Line2StackView: UIStackView!

    var facilityImages: [UIImage] = [#imageLiteral(resourceName: "facilityBigBlAccessRoadIc"), #imageLiteral(resourceName: "facilityBigBlLiftIc"), #imageLiteral(resourceName: "facilityBigBlBathroomIc"), #imageLiteral(resourceName: "facilityBigBlParkingIc"), #imageLiteral(resourceName: "facilityBigBlRemoveHightIc"), #imageLiteral(resourceName: "facilityBigBlInfoServiceIc"), #imageLiteral(resourceName: "facilityBigBlChargerIc"), #imageLiteral(resourceName: "facilityBigBlEntranceIc"), #imageLiteral(resourceName: "facilityBigBlFirstFloorIc")]
    
    func setFacilityImageView() {
        let isSingleLine = shopData.facilities.count < 5
        Line2StackView.isHidden = isSingleLine

        for (index, value) in shopData.facilities.enumerated() {
            facilityImageView[index].image = facilityImages[value - 1]
        }
    }
    
    func initMap() {
        if (!MTMapView.isMapTilePersistentCacheEnabled()) {
            MTMapView.setMapTilePersistentCacheEnabled(true)
        }

        daumMapView = MTMapView.create(delegate: self, bound: smallMapView.bounds)
        if let mapView = daumMapView {
            smallMapView.addSubview(mapView)
        }
    }
    
    func pinOnMapView() {
        guard let mapView = daumMapView
        else {
            return
        }

        let marker = MTMapPOIItem()
        let geoCoord = MTMapPointGeo(latitude: shopData.latitude, longitude: shopData.longitude)
        marker.mapPoint = MTMapPoint(geoCoord: geoCoord)
        marker.markerType = .bluePin
        marker.showAnimationType = .springFromGround
        marker.draggable = false
        mapView.addPOIItems([marker])
        mapView.fitAreaToShowAllPOIItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initMap()
        ShopBoardInit()
    }

    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationItem.backBarButtonItem?.title = ""
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func goFacilityDetail(_ sender: UIButton) {
        guard let infoVC = self.storyboard?.instantiateViewController(identifier: "facilityInfoVC") as? facilityInfoVC
            else { return }
        
        self.present(infoVC, animated: true)
    }
    
    func ShopBoardInit(){
        guard let storeidx = selectedStore else {return}
        ShopService.shareInstance.shopBoardInit(url: "\(APIService.BaseURL)/store/\(storeidx)", completion: { [weak self] (result) in
                    guard let `self` = self else { return }
                    
                    switch result {
                    case .networkSuccess(let data):
                        if let vo = data as? ShopInfoVO {
                            self.shopData = vo.data
                            self.setFacilityImageView()
                            self.pinOnMapView()
                        }
                        if let url = URL(string: self.gsno(self.shopData.img)){
                            self.shopImg.kf.setImage(with: url)
                        }
                        self.shopName.text = self.shopData.name
                        self.shopCategory.text = self.shopData.category
                        self.shopAddress.text = self.shopData.address
                        self.shopAddress2.text = self.shopData.address
                        self.shopTime.text = self.shopData.operating
                        self.shopNumber.text = self.shopData.phone
                        
                    case .networkFail :
        //                self.simpleAlert(title: "network", message: "check")
                        break
                    default :
                        break
                    }
                    
                })
    }
    func gsno(_ value : String?) -> String{
        return value ?? ""
    }
    @IBAction func goReport(_ sender: UIButton) {
        guard let reportVC = UIStoryboard(name: "Report", bundle: nil).instantiateViewController(identifier: "ReportViewController") as? ReportViewController else { return }
        reportVC.selectedBuilding = self.shopData.buildingIdx
        reportVC.selectedBuildingName = shopData.name
        self.present(reportVC, animated: true)
    }
}
