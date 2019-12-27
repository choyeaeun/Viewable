//
//  MyPageViewController.swift
//  Viewable
//
//  Created by deokwon on 28/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation
import UIKit

class MyPageViewController: UIViewController {
    
    @IBOutlet var reportCollectionView: UICollectionView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userProfileImageView: UIImageView!
    
    var reports: [MyPageUseReport] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let curTime = Date().timeIntervalSince1970
        MyPageService.shareInstance.getData(url: "\(APIService.BaseURL)/user/mypage?time=\(String(describing: curTime))") { result in
            switch result {
            case .networkSuccess(let data):
                if let vo = data as? MyPageVO {
                    self.userNameLabel.text = vo.data.userProfile[0].username
                    if let userImg = vo.data.userProfile[0].userImg, let url = URL(string: userImg) {
                        self.userProfileImageView.downloadImage(from: url)
                    }
                    self.reports = vo.data.userReport
                    self.reportCollectionView.reloadData()
                }
            default:
                break
            }
        }
    }
}

extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIReportHistoryCell.identifier, for: indexPath) as? UIReportHistoryCell
        else {
            return UICollectionViewCell()
        }
        cell.data = reports[indexPath.item]
        return cell
    }
}
