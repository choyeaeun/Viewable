//
//  SearchViewController.swift
//  Viewable
//
//  Created by 김덕원 on 15/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    let categories = [
        [ "icon": #imageLiteral(resourceName: "searchStoreFoodBt") ],
        [ "icon": #imageLiteral(resourceName: "searchStoreCafeBt") ],
        [ "icon": #imageLiteral(resourceName: "searchStoreMartBt") ],
        [ "icon": #imageLiteral(resourceName: "searchStoreBankBt") ],
        [ "icon": #imageLiteral(resourceName: "searchStorePharmacyBt") ],
        [ "icon": #imageLiteral(resourceName: "searchStorePostofficeBt") ],
        [ "icon": #imageLiteral(resourceName: "searchStoreConveniencestoreBt") ]
    ]
    let results = ["스타벅스 공덕오거리점", "마포구", "음식점"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? UICategoryViewCell
        else {
            return UICollectionViewCell()
        }
        cell.iconImageView.image = categories[indexPath.item]["icon"]
        return cell
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell")
        else {
            return UITableViewCell()
        }

        if (cell.textLabel !== nil) {
            cell.textLabel?.text = results[indexPath.item]
        }
        return cell
    }
}
