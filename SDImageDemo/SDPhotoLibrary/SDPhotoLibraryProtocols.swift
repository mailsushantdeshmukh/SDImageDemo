//
//  SDPhotoLibraryProtocols.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 21/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//
import UIKit
import CommonCode


//Presenter Protocols
protocol SDPhotoLibraryViewControllerToPresenterContract:  class{
    var interactor: SDPhotoLibraryInteractorContract? { get }
    func loadRecentPhotos()
    func searchPhoto(with text: String)
}

protocol SDPhotoLibraryInteractorToPresenterContract: class, InteractorToPresenterContract {
    var viewController: SDPhotoLibraryViewControllerContract? { get }
    func presentError(error: SDPhotoError)
    func presentPhotos(photos: [PhotoModel])
}

//Interactor Protocols
protocol SDPhotoLibraryInteractorContract:  class {
    var presenter: SDPhotoLibraryInteractorToPresenterContract? { get }
    func loadRecentPhotos()
    func searchPhoto(with text: String)
}

//Mapper Protocols
protocol SDPhotoLibraryMapperContract {
    func mapToViewModel(models: [PhotoModel]) -> [PhotoViewModel]
}

//Viewcontroller protocols
protocol SDPhotoLibraryViewControllerContract: class, PresenterToViewControllerContract{
    var presenter: SDPhotoLibraryViewControllerToPresenterContract? { get }
    func displayPhotos(photos: [PhotoViewModel])
}

//Configuration Protocol
protocol SDPhotoLibraryConfigurationContract { }

//Router Protocol
protocol SDPhotoLibraryRouterContract {
    func popView() 
}

//Configurator Protocols
protocol SDPhotoLibraryConfiguratorContract {
    func configure(configuration: SDPhotoLibraryConfigurationContract) -> UIViewController
}

typealias SDPhotoLibraryPresenterContract
    = SDPhotoLibraryViewControllerToPresenterContract & SDPhotoLibraryInteractorToPresenterContract
