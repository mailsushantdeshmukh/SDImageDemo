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
class SDPhotoLibraryPresenterTest: XCTestCase {
    var presenter: SDPhotoLibraryPresenter!
    var mockInteractor = MockSDPhotoLibraryInteractor()
    var mockViewController = MockSDPhotoLibraryView()
    var mockmapper = MockSDPhotoLibraryMapper()
    
    override func setUp() {
        AppSetting.shared.enviroment = .mock
        presenter = SDPhotoLibraryPresenter()
        presenter.interactor = mockInteractor
        presenter.mapper = mockmapper
        presenter.viewController = mockViewController
    }
    
    func testLoadRecentPhotos() {
        let expectation = XCTestExpectation(description: "load recent photos")
        mockInteractor.loadRecentPhotosCallBack = {text in
            XCTAssertNil(text)
            expectation.fulfill()
        }
        presenter.loadRecentPhotos()
        wait(for: [expectation], timeout: 10)
    }
    
    func testSearchPhotos() {
        let expectation = XCTestExpectation(description: "load search photos")
        mockInteractor.loadRecentPhotosCallBack = {text in
            XCTAssertNotNil(text)
            XCTAssertTrue("Pune" == text)
            expectation.fulfill()
        }
        presenter.searchPhoto(with: "Pune")
        wait(for: [expectation], timeout: 10)
    }
    
    func testPresentError() {
        let expectation = XCTestExpectation(description: "Present Error")
        mockViewController.completionWithError = { (title, message) in
            XCTAssertNotNil(title)
            XCTAssertNotNil(message)
            XCTAssertTrue("Wrong Code!" == title)
            XCTAssertTrue("request failed with status 404" == message)
            expectation.fulfill()
        }
        presenter.presentError(error: SDPhotoError.wrongStatusError(status: 404))
        wait(for: [expectation], timeout: 10)
    }
    
    func testPresentPhotos() {
        let expectation = XCTestExpectation(description: "Present Photos")
        mockViewController.completionPhotoLoading = { photos in
            XCTAssertNotNil(photos)
            XCTAssertTrue(photos.count > 0)
            XCTAssertTrue(photos.first?.title == "World")
            XCTAssertTrue(photos.first?.imageUrl == "https://live.staticflickr.com/google/1234_abced.jpg")
            expectation.fulfill()
        }
        let photos = [PhotoModel(id: "1234",
                                 owner: "flicr",
                                 secret: "abced",
                                 server: "google",
                                 farm: 1,
                                 title: "World",
                                 isPublic: true,
                                 isFriend: true,
                                 isFamily: true)
        ]
        presenter.presentPhotos(photos: photos)
        wait(for: [expectation], timeout: 10)
    }
    
    func testPresentPhotosWithoutMapper() {
        let expectation = XCTestExpectation(description: "Present Photos")
        mockViewController.completionPhotoLoading = { photos in
            XCTAssertNotNil(photos)
            XCTAssertTrue(photos.count == 0)
            expectation.fulfill()
        }
        let photos = [PhotoModel(id: "1234",
                                 owner: "flicr",
                                 secret: "abced",
                                 server: "google",
                                 farm: 1,
                                 title: "World",
                                 isPublic: true,
                                 isFriend: true,
                                 isFamily: true)
        ]
        presenter.mapper = nil
        presenter.presentPhotos(photos: photos)
        wait(for: [expectation], timeout: 10)
    }
    
    func testStartLoading() {
        presenter.startLoading()
        XCTAssertNotNil(mockViewController.isLoading)
        XCTAssertTrue((mockViewController.isLoading ?? false))
    }
    
    func testStopLoading() {
        presenter.stopLoading()
        XCTAssertNotNil(mockViewController.isLoading)
        XCTAssertFalse(mockViewController.isLoading ?? true)
    }
}

class MockSDPhotoLibraryInteractor: SDPhotoLibraryInteractorContract {
    var presenter: SDPhotoLibraryInteractorToPresenterContract?
    var loadRecentPhotosCallBack: ((_ text: String?)->Void)?
    
    func loadRecentPhotos() {
        loadRecentPhotosCallBack?(nil)
    }
    
    func searchPhoto(with text: String) {
        loadRecentPhotosCallBack?(text)
    }
    
}


class MockSDPhotoLibraryView: SDPhotoLibraryViewControllerContract {
    var presenter: SDPhotoLibraryViewControllerToPresenterContract?
    var isLoading:Bool?
    var completionPhotoLoading: ((_ photos: [PhotoViewModel])->Void)?
    var completionWithError: ((_ title: String, _ message: String)->Void)?
    
    
    func displayError(title: String, message: String) {
        completionWithError?(title, message)
    }
    
    func startLoading() {
        isLoading = true
    }
    
    func stopLoading() {
        isLoading = false
    }
    
    func displayPhotos(photos: [PhotoViewModel]) {
        completionPhotoLoading?(photos)
    }
}


class MockSDPhotoLibraryMapper: SDPhotoLibraryMapperContract {
    func mapToViewModel(models: [PhotoModel]) -> [PhotoViewModel] {
        return models.map { model -> PhotoViewModel in
            PhotoViewModel(title: model.title, imageUrl: model.imageUrl)
        }
    }
}
