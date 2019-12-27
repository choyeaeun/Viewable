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
