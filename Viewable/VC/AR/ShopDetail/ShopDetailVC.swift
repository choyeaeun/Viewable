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
    @IBOutlet var tableview: UITableView!
    var arr :[UIImage] = [#imageLiteral(resourceName: "facilityBigBlLiftIc"), #imageLiteral(resourceName: "facilityBigBlLiftIc"), #imageLiteral(resourceName: "facilityBigBlLiftIc"), #imageLiteral(resourceName: "facilityBigBlLiftIc"), #imageLiteral(resourceName: "facilityBigBlLiftIc"), #imageLiteral(resourceName: "facilityBigBlLiftIc")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MTMapView(frame: smallMapView.bounds)
        if let mapView = mapView{
            mapView.delegate = self
            mapView.baseMapType = .standard
            smallMapView.addSubview(mapView)
        }
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
                            self.tableview.reloadData()
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
        print(self.shopData.buildingIdx)
        self.present(reportVC, animated: true)
    }
}

extension ShopDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.configure(with: self.arr )
        return cell
    }
}
