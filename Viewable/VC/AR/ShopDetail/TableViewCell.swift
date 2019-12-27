//
//  TableViewCell.swift
//  Viewable
//
//  Created by 조예은 on 2019/12/27.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    var arr:[UIImage] = []
    
    func configure(with arr: [UIImage]){
        self.arr = arr
        self.collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
    }

}

extension TableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopDetailCVCell", for: indexPath) as? ShopDetailCVCell
        else {
            return UICollectionViewCell()
        }
        cell.facilityIMG.image = self.arr[indexPath.row]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let text = self.arr[indexPath.row]
//        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:12.0)]).width + 30.0
//        return CGSize(width: cellWidth, height: 30.0)
//    }
}
