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
class PhotoPageEntityTest: XCTestCase {
    override func setUp() {  }
    
    func testPhotoPageEntity() {
        XCTAssertThrowsError(try createPhotoPageEntity().toDomainModel())
        XCTAssertThrowsError(try createPhotoPageEntity(page: 1).toDomainModel())
        XCTAssertThrowsError(try createPhotoPageEntity(page: 1, pages: 100).toDomainModel())
        XCTAssertThrowsError(try createPhotoPageEntity(page: 1, pages: 100,
                                                       perpage: 10).toDomainModel())
        let photoEnity = PhotoEntity(id: "1234", owner: "abc",
                                     secret: "xyz", server: "apple",
                                     farm: 1, title: "myImage",
                                     ispublic: 1, isfriend: 1,
                                     isfamily: 1)
        XCTAssertNoThrow(try createPhotoPageEntity(page: 1, pages: 100,
                                                   perpage: 10, photo: [photoEnity]).toDomainModel())
    }
    
    private func createPhotoPageEntity(page: Int? = nil,
                                       pages: Int? = nil,
                                       perpage: Int? = nil,
                                       photo: [PhotoEntity]? = nil) -> PhotoPageEntity {
        return  PhotoPageEntity(page: page,
                                pages: pages,
                                perpage: perpage,
                                photo: photo)
    }
}


