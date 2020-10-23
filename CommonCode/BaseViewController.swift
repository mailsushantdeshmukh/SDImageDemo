//
//  BaseViewController.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 21/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController, PresenterToViewControllerContract, StoryBoardBased {
    private let activityIndicator: UIActivityIndicatorView =  UIActivityIndicatorView(style: .large)
    open class var storyboardName: String {
        assertionFailure("Implement: oveerride static var storyboardName: String{ \"StoryboardName\" } for \(sceneIdentifier)")
        return ""
    }
    open override func viewDidLoad() {
        setupLoader()
        super.viewDidLoad()
    }
    
    private func setupLoader() {
        activityIndicator.color = .systemBlue
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    public func startLoading() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    public func stopLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    public func displayError(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
