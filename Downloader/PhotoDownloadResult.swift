
//
//  PhotoDownloadResult.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 22/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//

import Foundation
import CommonCode
import UIKit

public enum PhotoDownloadResult {
    case success(UIImage)
    case noData
    case userCancelled
    case error(Error) /// Might be SynchronizerError or parsing error thrown by Resource parse function
}

extension PhotoDownloadResult {
    static func resultWithResponse(_ response: URLResponse?, error: NSError?) -> PhotoDownloadResult? {
        guard error == nil else {
            return self.error(SDPhotoError.urlSessionError(error!))
        }
        let statusCode = (response as! HTTPURLResponse).statusCode
        guard 200..<300 ~= statusCode else {
            return self.error(SDPhotoError.wrongStatusError(status: statusCode))
        }
        return nil
    }
}
