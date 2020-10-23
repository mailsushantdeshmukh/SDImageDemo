//
//  SdPhotoLibraryConfiguratorTest.swift
//  SDImageDemoTests
//
//  Created by Sushant Deshmukh on 23/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//
import XCTest
import Foundation
import CommonCode
@testable import SDImageDemo

class SdPhotoLibraryConfiguratorTest: XCTestCase {
    func testConfigure() {
        let config = SDPhotoLibraryConfiguartion()
        let configurator = SDPhotoLibraryConfiguartator()
        guard let viewController
            = configurator.configure(configuration: config) as? SDPhotoLibraryViewControllerContract else {
                XCTFail("Wrong ViewController")
                return
        }
        guard let presenter = viewController.presenter as? SDPhotoLibraryPresenterContract else {
            XCTFail("Wrong presenter")
            return
        }
        guard (presenter.interactor) != nil else {
            XCTFail("Wrong interactor")
            return
        }
    }
    
}
