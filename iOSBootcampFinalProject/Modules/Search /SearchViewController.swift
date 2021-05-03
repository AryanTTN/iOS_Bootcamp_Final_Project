//
//  SearchViewController.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 03/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchCollectionView: UICollectionView!
    var searchVM = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showSearchBar()
        searchCollectionView.register(CustomCollectionViewCell.nib(), forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)

        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    func showSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        //true for hiding, false for keep showing while scrolling
        searchController.searchBar.sizeToFit()
        searchController.searchBar.returnKeyType = UIReturnKeyType.search
        searchController.searchBar.placeholder = "Search here"
        navigationItem.searchController = searchController
    }

    func fetchSearchData(searchText: String) {
        guard !searchText.isEmpty else { return }
        searchVM.fetchSearchApiData(searchString: searchText) { (success, message) in
            if success {
                self.searchCollectionView.reloadData()
            } else {
                print(message)
            }
        }
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchVM.searchApiData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.configure(searchVM.searchApiData?[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailScreenViewController") as! DetailScreenViewController
        vc.data = searchVM.searchApiData?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = searchCollectionView.frame.width/2
        return CGSize(width: width, height: width*(4/3))
    }
    
}



extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        searchVM.searchApiData?.removeAll()
        searchCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchSearchData(searchText: searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
