//
//  SDPhotoLibraryMapperTest.swift
//  SDImageDemoTests
//
//  Created by Sushant Deshmukh on 23/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//


import XCTest
import Foundation
import CommonCode
@testable import SDImageDemo
class SDPhotoLibraryMapperTest: XCTestCase {
    var mapper: SDPhotoLibraryMapper!
    
    override func setUp() {
        AppSetting.shared.enviroment = .mock
        mapper = SDPhotoLibraryMapper()
    }
    
    func testLoadRecentPhotos() {
        let photos = [
            PhotoModel(id: "1234", owner: "flicr",
                       secret: "abced", server: "google",
                       farm: 1, title: "World",
                       isPublic: true, isFriend: true,
                       isFamily: true),
            PhotoModel(id: "9876", owner: "google",
                       secret: "xyzw", server: "apple",
                       farm: 1, title: "google",
                       isPublic: true, isFriend: true,
                       isFamily: true)
        ]
        let photosViewModel = mapper.mapToViewModel(models: photos)
        
        XCTAssertNotNil(photosViewModel)
        XCTAssertTrue(photosViewModel.count == 2)
        XCTAssertTrue(photos.first?.title == "World")
        XCTAssertTrue(photos.first?.imageUrl == "https://live.staticflickr.com/google/1234_abced.jpg")
        XCTAssertTrue(photos.last?.title == "google")
        XCTAssertTrue(photos.last?.imageUrl == "https://live.staticflickr.com/apple/9876_xyzw.jpg")
    }
}
