//
//  SDPhotoLibraryInteractorTest.swift
//  SDImageDemoTests
//
//  Created by Sushant Deshmukh on 22/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//

import XCTest
import Foundation
import CommonCode
@testable import SDImageDemo
class SDPhotoLibraryInteractorTest: XCTestCase {
    var interactor: SDPhotoLibraryInteractor!
    var mockPresenter = MockSDPhotoLibraryPresenter()
    
    override func setUp() {
        AppSetting.shared.enviroment = .mock
        interactor = SDPhotoLibraryInteractor()
        interactor.presenter = mockPresenter
    }
    
    func testLoadRecentPhotos() {
        let expectation = XCTestExpectation(description: "load recent photos")
        mockPresenter.completionPhotoLoading = { photos in
            XCTAssertNotNil(photos)
            expectation.fulfill()
        }
        interactor.loadRecentPhotos()
       wait(for: [expectation], timeout: 10)
    }
    
    func testSearchPhotos() {
        let expectation = XCTestExpectation(description: "load search photos")
        mockPresenter.completionPhotoLoading = { photos in
            XCTAssertNotNil(photos)
            expectation.fulfill()
        }
        interactor.searchPhoto(with: "World")
       wait(for: [expectation], timeout: 10)
    }
    
}

class MockSDPhotoLibraryPresenter: SDPhotoLibraryInteractorToPresenterContract {
    var viewController: SDPhotoLibraryViewControllerContract?
    var completionPhotoLoading: ((_ photos: [PhotoModel])->Void)?
  
    func presentPhotos(photos: [PhotoModel]) {
        completionPhotoLoading?(photos)
    }
    
    func presentError(error: SDPhotoError) { }
    
    func startLoading() { }
    
    func stopLoading() {}
}
