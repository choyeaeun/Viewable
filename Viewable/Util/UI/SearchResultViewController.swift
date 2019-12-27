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
    @IBOutlet var storeCollectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var categoryLabel: UILabel!
    
    var stores: [StoreData] = []
    var daumMapView: MTMapView?
    var category: Int = -1
    var searchText: String = ""
    var facilties: [Int] = []
    
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
        
        var url = "\(APIService.BaseURL)/search"
        if category != -1 {
            searchBar.text = Constants.categories[category].name
            url += "/\(category + 1)"
        } else {
            searchBar.text = searchText
            if let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                url += "?keyword=\(text)"
            }
            if facilties.count > 0 {
                let facilitiesJoinString = facilties.map { ($0 + 1).description }.joined(separator: ",")
                url += "&facilityIdx=\(facilitiesJoinString)"
            }
        }
        print("url: \(url)")
        SearchService.shareInstance.search(url: url) { result in
            switch result {
            case .networkSuccess(let data):
                if let vo = data as? SearchCategoryVO {
                    self.stores = vo.data
                    self.storeCollectionView.reloadData()
                }
            default:
                break
            }
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

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UISearchResultCell.identifier, for: indexPath) as? UISearchResultCell
        else {
            return UICollectionViewCell()
        }
        cell.data = stores[indexPath.item]
        return cell
    }
}
