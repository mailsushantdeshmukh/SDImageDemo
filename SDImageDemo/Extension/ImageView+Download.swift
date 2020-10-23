//
//  ImageView+Download.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 21/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//
import UIKit
import Downloader
extension UIImageView {
    func loadImage(url: String) -> CancelDowloading {
        let activityIndicator: UIActivityIndicatorView =  UIActivityIndicatorView(style: .medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        return PhotoDownloader(maxCacheTimeInHour: 1,
                               URLCache: CacheHandler.sharedHandler.cache)
            .loadImage(with: url) {[weak self] downloadResult in
                guard let self = self else { return }
                activityIndicator.removeFromSuperview()
                switch downloadResult {
                case let .success(image):
                    self.image = image
                case .userCancelled:
                    self.image = UIImage(named: "cancel")
                case .error:
                    self.image = UIImage(named: "error")
                case .noData:
                    self.image = UIImage(named: "nosign")
                }
        }
    }
}
