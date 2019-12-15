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
        [ "text": "음식점", "icon": "" ],
        [ "text": "카페", "icon": "" ],
        [ "text": "편의점", "icon": "" ],
        [ "text": "마트", "icon": "" ],
        [ "text": "약국", "icon": "" ],
        [ "text": "지하철역", "icon": "" ],
        [ "text": "은행", "icon": "" ]
    ]
    let results = ["스타벅스 공덕오거리점", "마포구", "음식점"]
    

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
        cell.textLabel.text = categories[indexPath.item]["text"]
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
