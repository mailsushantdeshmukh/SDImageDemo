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
class PhotoPageModelTest: XCTestCase {
    override func setUp() {  }
    
    func testPhotoPageEntity() {
        let photoModel1 =  PhotoModel(id: "987643", owner: "lmn",
                                      secret: "1nr4", server: "google",
                                      farm: 1, title: "demo image",
                                      isPublic: true, isFriend: true,
                                      isFamily: true)
        let photoModel2 =  PhotoModel(id: "1234", owner: "abc",
                                      secret: "xyz", server: "apple",
                                      farm: 1, title: "myImage",
                                      isPublic: true, isFriend: true,
                                      isFamily: true)
        let firstModel =  createPhotoPagModel(page: 1, pages: 10,
                                              perpage: 5, photo: [photoModel1])
        let secondModel = createPhotoPagModel(page: 2, pages: 20,
                                              perpage: 5, photo: [photoModel2])
        let thirdModel =  createPhotoPagModel(page: 1, pages: 10,
                                              perpage: 5, photo: [photoModel1])
        
        XCTAssertFalse(firstModel == secondModel)
        XCTAssertTrue(firstModel == thirdModel)
        XCTAssertFalse(secondModel == thirdModel)
    }
    
    private func createPhotoPagModel(page: Int,
                                     pages: Int,
                                     perpage: Int,
                                     photo: [PhotoModel]) -> PhotoPageModel {
        return PhotoPageModel(page: page, pages: pages, perpage: perpage, photo: photo)
    }
}


