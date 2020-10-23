//
//  SDPhotoLibraryRouter.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 20/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//
import UIKit

class SDPhotoLibraryRouter: SDPhotoLibraryRouterContract {
    weak var currenctViewController: SDPhotoLibraryViewControllerContract?
    func popView() {
        guard let currenctViewController = currenctViewController as? UIViewController else {
            return
        }
        currenctViewController.navigationController?.popViewController(animated: true)
    }
}
