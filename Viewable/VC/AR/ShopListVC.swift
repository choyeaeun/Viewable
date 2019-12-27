//
//  ShopListVC.swift
//  Viewable
//
//  Created by 조예은 on 23/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import UIKit

class ShopListVC: UIViewController {

    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
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

}

extension ShopListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShopListTVCell", for: indexPath) as? ShopListTVCell
        else {
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 183
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //myselect row is indexPath.row
//        let DetailVC = storyboard?.instantiateViewController(identifier: "ShopDetailVC") as! ShopDetailVC
//        self.navigationController?.pushViewController(DetailVC, animated: true)
        
        guard let DetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShopDetailVC") as? ShopDetailVC else { return }
        self.navigationController?.pushViewController(DetailVC, animated: true)
    }
    
}
