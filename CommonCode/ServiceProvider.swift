//
//  ServiceProvider.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 21/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//
import Foundation
import Network


public final class ServiceProvider<In: BaseService> {
    public typealias Service = BaseService
    private var service: In
    public init(service: In) {
        self.service = service
    }
    public func response(completion: @escaping (Data?, SDPhotoError?) -> Void) {
        switch AppSetting.shared.enviroment {
        case .live:
            urlResponse(completion: completion)
        case .mock:
            mockResponse(completion: completion)
        }
    }
    
    private func urlResponse(completion: @escaping (Data?, SDPhotoError?) -> Void)  {
        URLSession.shared.dataTask(with: service.request()) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, SDPhotoError.urlSessionError(error))
                } else if let data = data,
                    let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        completion(data, nil)
                    } else {
                        completion(nil, SDPhotoError.wrongStatusError(status: response.statusCode))
                    }
                } else {
                    completion(nil, SDPhotoError.urlSessionError(URLError(.badServerResponse)))
                }
            }
        }.resume()
    }
    
    private func mockResponse(completion: @escaping (Data?, SDPhotoError?) -> Void)  {
        do {
            if FileManager().fileExists(atPath: service.url) {
                let data = try Data(contentsOf: URL(fileURLWithPath: service.url))
                completion(data, nil)
            } else {
                completion(nil, SDPhotoError.urlSessionError(URLError(.fileDoesNotExist)))
            }
        } catch {
            completion(nil, SDPhotoError.urlSessionError(URLError(.badServerResponse)))
        }
    }
}

