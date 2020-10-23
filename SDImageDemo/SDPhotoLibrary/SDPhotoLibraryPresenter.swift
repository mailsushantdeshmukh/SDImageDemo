//
//  SDPhotoLibraryPresenter.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 20/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//

import UIKit
import CommonCode

class SDPhotoLibraryPresenter {
    var router: SDPhotoLibraryRouterContract?
    var mapper: SDPhotoLibraryMapperContract?
    var interactor: SDPhotoLibraryInteractorContract?
    weak var viewController: SDPhotoLibraryViewControllerContract?
}

//Ask presenter to fetch data from interactor
extension SDPhotoLibraryPresenter: SDPhotoLibraryViewControllerToPresenterContract {
    func loadRecentPhotos() {
        interactor?.loadRecentPhotos()
    }
    
    func searchPhoto(with text: String) {
        interactor?.searchPhoto(with: text)
    }
}

//Display data on viewcontroller
extension SDPhotoLibraryPresenter: SDPhotoLibraryInteractorToPresenterContract {
    func presentError(error: SDPhotoError) {
        let error = parseError(error: error)
        viewController?.displayError(title: error.title, message: error.message)
    }
    
    func presentPhotos(photos: [PhotoModel]) {
        viewController?.displayPhotos(photos: mapper?.mapToViewModel(models: photos) ?? [])
    }
    
    func startLoading() {
        viewController?.startLoading()
    }
    
    func stopLoading() {
        viewController?.stopLoading()
    }
}
