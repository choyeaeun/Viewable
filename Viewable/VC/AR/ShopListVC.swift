//
//  ShopListVC.swift
//  Viewable
//
//  Created by 조예은 on 23/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import UIKit
import Kingfisher

class ShopListVC: UIViewController, SendDataDelegate {
    

    @IBOutlet var tableview: UITableView!
    var filterFac: String = "0,1,2,3,4,5,6,7,8"
    var filterCat: String = "0,1,2,3,4,5,6"
    var list:[StoreLine] = []
    var filterList:[FilterStore] = []
    var buildingId:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        listBoardInit()
        //filter data 받는 sendDataDelegete 위임 해줘야 함 https://zeddios.tistory.com/310
    }
    
    @IBAction func openFilter(_ sender: UIButton) {
        guard let filterVC = self.storyboard?.instantiateViewController(identifier: "ShopfilterVC") as? ShopfilterVC
            else { return }

        self.present(filterVC, animated: true)
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
    
    func sendData(facility: String, category: String) {
        self.filterFac = facility
        self.filterCat = category
        filterBoardInit(facility: filterFac, category: filterCat)
    }
    
    func listBoardInit(){
        ListService.shareInstance.ListServiceInit(url: "\(APIService.BaseURL)/building/\(buildingId)/store", completion: { [weak self] (result) in
                        guard let `self` = self else { return }
                        
                        switch result {
                        case .networkSuccess(let ListData):
                            if let vo = ListData as? ListVO {
                                self.list = vo.data
                                self.tableview.reloadData()
                            }
                        case .networkFail :
            //                self.simpleAlert(title: "network", message: "check")
                            break
                        default :
                            break
                        }
                        
                    })
    }
    func filterBoardInit(facility: String, category: String){
        ListService.shareInstance.ListServiceInit(url: "\(APIService.BaseURL)/building/\(buildingId)/store?category=\(facility)&facility=\(category)", completion: { [weak self] (result) in
                        guard let `self` = self else { return }
                        
                        switch result {
                        case .networkSuccess(let data):
                            if let vo = data as? FilterVO {
                                self.filterList = [vo.data]
                                //
                                self.tableview.reloadData()
                            }
                        case .networkFail :
            //                self.simpleAlert(title: "network", message: "check")
                            break
                        default :
                            break
                        }
                        
                    })
    }
}

extension ShopListVC: UITableViewDelegate, UITableViewDataSource{
    func gsno(_ value : String?) -> String{
        return value ?? ""
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShopListTVCell", for: indexPath) as? ShopListTVCell
        else {
            return UITableViewCell()
        }
        cell.name.text = self.list[indexPath.row].name
        cell.time.text = self.list[indexPath.row].operating
        cell.number.text = self.list[indexPath.row].phone
//        cell.facil
//        cell.category.image =
        if let url = URL(string: gsno(self.list[indexPath.row].img)){
            cell.storeImg.kf.setImage(with: url)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 183
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let DetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShopDetailVC") as? ShopDetailVC else { return }
        DetailVC.selectedStore = list[indexPath.row].storeIdx
        self.navigationController?.pushViewController(DetailVC, animated: true)
    }
    
}
