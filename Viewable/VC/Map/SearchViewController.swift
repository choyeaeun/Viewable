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
    
    // MARK:- Property
    @IBOutlet var filterButton: UIToggleButton!
    @IBOutlet var optionButtons: [UIToggleButton]!
    @IBOutlet var optionBGView: UIView!
    @IBOutlet var searchBar: UISearchBar!
    
    var category: Int = -1
    var searchText: String = ""
    var facilties: [Int] = []
    
    // MARK:- Method

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didClickedAllOption(_ sender: Any) {
        let optionState = !optionButtons[0].isOn
        optionButtons.forEach { button in
            button.isOn = optionState
        }
    }

    @IBAction func didClickedOption(_ sender: Any) {
        let result = optionButtons!.reduce(1) { result, button -> Int in
            if (button.tag > 0) {
                return result + (button.isOn ? 1 : 0)
            }
            return result
        }
        
        optionButtons[0].isOn = result == 8
    }
    
    @IBAction func didClickedResetButton(_ sender: Any) {
        optionButtons.forEach { button in
            button.isOn = false
        }
    }
    
    @IBAction func didClickedConfirmButton(_ sender: Any) {
        let enableOptions = optionButtons.filter { button -> Bool in
            return button.isOn
        }
        filterButton.isOn = enableOptions.count > 0
        optionBGView.isHidden = true
    }
    
    @IBAction func didClickedFilterButton(_ sender: Any) {
        filterButton.isOn = true
        optionBGView.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        touchToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SearchResultViewController {
            let tags = optionButtons.filter { button -> Bool in
                return button.isOn
            }.map { button -> Int in
                return button.tag
            }
            print(tags)
            vc.facilties = tags
            vc.searchText = searchBar.text ?? ""
            vc.category = category
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            performSegue(withIdentifier: "toSearchResult", sender: nil)
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? UICategoryViewCell
        else {
            return UICollectionViewCell()
        }
        cell.iconImageView.image = Constants.categories[indexPath.item].image
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cate: \(category)")
        category = indexPath.item
        performSegue(withIdentifier: "toSearchResult", sender: nil)
    }
}
