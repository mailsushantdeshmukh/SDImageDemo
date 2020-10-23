//
//  SDPhotoLibraryViewController.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 20/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//

import UIKit
import CommonCode
import Downloader
class SDPhotoLibraryViewController: BaseViewController {
    var presenter: SDPhotoLibraryViewControllerToPresenterContract?
    private var photos: [PhotoViewModel] = []
    @IBOutlet var photoCollection: UICollectionView!
    override class var storyboardName: String{ "SDPhotoLibrary"  }
    override func viewDidLoad() {
        loadPhotos()
        super.viewDidLoad()
    }
    
    private func loadPhotos() {
        presenter?.loadRecentPhotos()
    }
}

extension SDPhotoLibraryViewController: SDPhotoLibraryViewControllerContract {
    func displayPhotos(photos: [PhotoViewModel]) {
        self.photos = photos
        photoCollection.reloadData()
    }
}

extension SDPhotoLibraryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "SDPhotoCell", for: indexPath) as?  SDPhotoCell else {
                return UICollectionViewCell()
        }
        cell.setPhoto(photoViewModel: photos[indexPath.item])
        return cell
    }
}

extension SDPhotoLibraryViewController: UICollectionViewDelegate { }

extension SDPhotoLibraryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
        presenter?.searchPhoto(with: searchBar.text ?? "")
    }
}
