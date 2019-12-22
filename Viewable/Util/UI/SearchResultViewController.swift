//
//  SearchResultViewController.swift
//  Viewable
//
//  Created by 김덕원 on 17/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation
import UIKit

class SearchResultViewController: UIViewController {
    
    // MARK:- Property
    @IBOutlet var headerView: UIView!
    @IBOutlet var mapBackView: UIView!
    @IBOutlet var categoryLabel: UILabel!
    
    var daumMapView: MTMapView?
    
    // MARK:- Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color = CGFloat(155 / 255)
        headerView.layer.shadowColor = UIColor(red: color, green: color, blue: color, alpha: 0.27).cgColor
        headerView.layer.shadowOpacity = 0.5
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        if (!MTMapView.isMapTilePersistentCacheEnabled()) {
            MTMapView.setMapTilePersistentCacheEnabled(true)
        }

        daumMapView = MTMapView.create(delegate: self, bound: mapBackView.bounds)
        if let mapView = daumMapView {
            mapView.currentLocationTrackingMode = MTMapCurrentLocationTrackingMode.onWithHeading
            mapBackView.addSubview(mapView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationItem.backBarButtonItem?.title = ""
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        if (daumMapView != nil) {
            daumMapView = nil
        }
    }
    
    @IBAction func didClickedBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didClickedListButton(_ sender: Any) {
    }
}

extension SearchResultViewController: MTMapViewDelegate {
    
}
