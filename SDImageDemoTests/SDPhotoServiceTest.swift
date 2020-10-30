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
class SDPhotoServiceTest: XCTestCase {
    override func setUp() {
        AppSetting.shared.enviroment = .live
    }
    
    func testGetRecent(){
        let service = SDPhotoService.getRecentInPune
        XCTAssertTrue(service.mockName == "/recentPhotos.json")
        XCTAssertTrue(service.host == "https://www.flickr.com/services")
        XCTAssertTrue(service.path == "/rest")
        XCTAssertTrue(service.restMethod == "flickr.photos.search")
        XCTAssertTrue(service.httpMethod == .get)
        let parameters = [
            "text": "Pune",
            "format": "json",
            "nojsoncallback": "1",
            "method": "flickr.photos.search",
            "api_key": "3aaeaf09d9e52f7176b08551731ad5b6"]
        XCTAssertTrue(service.parameters == parameters)
    }
    
    func testSearchPhotos(){
        let service = SDPhotoService.searchPhotos(text: "World")
        XCTAssertTrue(service.mockName == "/searchPhotos.json")
        XCTAssertTrue(service.host == "https://www.flickr.com/services")
        XCTAssertTrue(service.path == "/rest")
        XCTAssertTrue(service.restMethod == "flickr.photos.search")
        XCTAssertTrue(service.httpMethod == .get)
        let parameters = ["text": "World",
                          "format": "json",
                          "nojsoncallback": "1",
                          "method": "flickr.photos.search",
                          "api_key": "3aaeaf09d9e52f7176b08551731ad5b6",
        ]
        XCTAssertTrue(service.parameters == parameters)
    }
}
