//
//  SDPhotoLibraryConfiguartator.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 20/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//

import UIKit
struct SDPhotoLibraryConfiguarator: SDPhotoLibraryConfiguratorContract {
    func configure(configuration: SDPhotoLibraryConfigurationContract) -> UIViewController {
        let viewController = SDPhotoLibraryViewController.instantiate()
        let presenter = SDPhotoLibraryPresenter()
        let interactor = SDPhotoLibraryInteractor()
        let router = SDPhotoLibraryRouter()
        let mapper = SDPhotoLibraryMapper()
        
        
        viewController.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        presenter.mapper = mapper
        return viewController
    }
}
