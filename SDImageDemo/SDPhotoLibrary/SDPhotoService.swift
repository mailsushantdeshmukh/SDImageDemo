//
//  SDPhotoService.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 21/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//
import Foundation
import Network
import CommonCode

let api_key = "3aaeaf09d9e52f7176b08551731ad5b6"
let secret = "abe8bd114ca9289f"

enum SDPhotoService {
    case getRecentInPune
    case searchPhotos(text:String)
}
extension SDPhotoService: BaseService{
    var mockName: String {
        switch self {
        case .searchPhotos:
            return "/searchPhotos.json"
        case .getRecentInPune:
            return "/recentPhotos.json"
        }
    }
    
    var host: String {
        switch AppSetting.shared.enviroment {
        case .live:
            return "https://www.flickr.com/services"
        case .mock:
            return Bundle.main.bundlePath
        }
    }
    
    var path: String {
        switch self {
        case .getRecentInPune,
             .searchPhotos:
            return  "/rest"
        }
    }
    
    var restMethod: String {
        switch self {
        // "flickr.photos.getrecent"
        //Removed this link due as it showing some wrong pics
        case .getRecentInPune, .searchPhotos :
            return  "flickr.photos.search"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getRecentInPune,
             .searchPhotos:
            return .get
        }
    }
    var parameters: [String: String] {
        var params = ["format":"json",
                      "nojsoncallback":"1",
                      "method":restMethod,
                      "api_key": api_key]
        switch self {
        case let .searchPhotos(text: text):
            params["text"] = text
        case  .getRecentInPune: 
             params["text"] = "Pune"
        }
        return params
    }
    
}
