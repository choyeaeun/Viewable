//
//  StoreInformationViewController.swift
//  Viewable
//
//  Created by 김덕원 on 16/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation
import UIKit

class StoreInformationViewController: UIViewController {
    
    // MARk:- Property
    @IBOutlet var tableView: UITableView!
    
    let data = [
        StoreInformation(name: "스타벅스 공덕오거리점", address: "서울특별시 마포구 백범로 108-112", phone: "02-702-4199", facilities: [1, 2, 3], category: 0, thumbnail: "")
    ]
    
    // MARK:- Method
    override func viewDidLoad() {
        print("view did load")

        let nib = UINib(nibName: UIStoreCell.identifier, bundle: nil)
//        tableView.register(nib, forCellWithReuseIdentifier: UIStoreCell.identifier)
        tableView.register(nib, forCellReuseIdentifier: UIStoreCell.identifier)
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
    
    @IBAction func didClickedSortButton(_ sender: Any) {
        print("[t] clicked!!")
    }

    @IBAction func didClickedBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension StoreInformationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UIStoreCell.identifier) as? UIStoreCell
        else {
            return UITableViewCell()
        }
        cell.data = data[indexPath.item]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIStoreCell.identifier, for: indexPath) as? UIStoreCell
//        else {
//            return UICollectionViewCell()
//        }
//
//        cell.data = data[indexPath.item]
//        return cell
//    }
}
