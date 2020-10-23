//
//  SDPhotoLibraryProtocols.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 21/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//

import UIKit
public protocol LoaderContract {
    func startLoading()
    func stopLoading()
}
public protocol ParseErrorContract {
    func parseError(error: SDPhotoError )->(title: String, message: String)
}

public extension ParseErrorContract {
    func parseError(error: SDPhotoError )->(title: String, message: String){
        switch error {
        case let .parseError(error):
            return(title: "Parsing Error!", message: error.localizedDescription)
        case let .urlSessionError(error):
            return(title: "Network Error!", message: error.localizedDescription)
        case let .wrongStatusError(status: status):
             return(title: "Wrong Code!", message: "request failed with status \(status)")
        }
    }
}

public protocol DisplayErrorContract {
    func displayError(title: String, message: String)
}
public typealias PresenterToViewControllerContract = LoaderContract & DisplayErrorContract 
public typealias InteractorToPresenterContract =  LoaderContract & ParseErrorContract
