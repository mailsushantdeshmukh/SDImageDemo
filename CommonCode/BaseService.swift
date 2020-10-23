//
//  BaseService.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 21/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
public protocol BaseService {
    var mockName: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: String]{ get }
    var host: String { get }
    func request()->URLRequest
}

public extension BaseService {
    var url: String {
        switch AppSetting.shared.enviroment {
        case .live:
            return "\(host)\(path)"
        case  .mock:
            return  "\(host)\(mockName)"
        }
    }
    
    private var contentType: String {
        return "application/json; charset=utf-8"
    }
    
    private var mockExtension: String {
        return "json"
    }
    
    private var headers :[String: String] {
        return ["Content-type": contentType]
    }
    
    private var getRequest :URLRequest {
        let urlComp = NSURLComponents(string: url)
        var items = [URLQueryItem]()
        for (key,value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        items = items.filter{!$0.name.isEmpty}
        if !items.isEmpty {
            urlComp?.queryItems = items
        }
        var urlRequest = URLRequest(url: urlComp!.url!)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers
        return  urlRequest
    }
    
    func request()->URLRequest {
        switch httpMethod {
        case .get:
            return getRequest
        default:
            return URLRequest(url: URL(string: url)!)
        }
    }
}
