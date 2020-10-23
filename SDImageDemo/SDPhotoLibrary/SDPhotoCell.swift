//
//  SDPhotoCell.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 21/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//

import UIKit
import Downloader

class SDPhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    private var cancelDownload: CancelDowloading?
    private var photoDownloader: PhotoDownloader?
    private var photoViewModel: PhotoViewModel?
    private var isDownloading: Bool = true
    private let activityIndicator: UIActivityIndicatorView =  UIActivityIndicatorView(style: .medium)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        //You Code here
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLoader()
    }
    
    private func setupLoader() {
        addSubview(activityIndicator)
        activityIndicator.center = self.center
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopDownloading()
        imageView.image = nil
        photoDownloader = nil
        self.cancelButton.setImage(UIImage(named: "close"), for: .normal)
    }
    
    func setPhoto(photoViewModel: PhotoViewModel){
        self.photoViewModel = photoViewModel
        photoDownloader = PhotoDownloader(maxCacheTimeInHour: 1, URLCache: CacheHandler.sharedHandler.cache)
        startDownloading()
    }
    
    private func startDownloading() {
        activityIndicator.startAnimating()
        guard let photoViewModel = photoViewModel else { return }
        cancelDownload = photoDownloader?.loadImage(with: photoViewModel.imageUrl, completion: {[weak self] downloadResult in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            switch downloadResult {
            case let .success(image):
                self.imageView.image = image
            case .noData, .error, .userCancelled:
                self.imageView.image =  UIImage(named: "error")
            }
        })
    }
    
    private func stopDownloading() {
        cancelDownload?()
    }
    
    @IBAction func pauseResumeAction(_ sender: Any) {
        isDownloading ? stopDownloading() : startDownloading()
        let buttonImage = isDownloading
            ? UIImage(systemName: "square.and.arrow.down.fill")
            : UIImage(named: "close")
        self.cancelButton.setImage(buttonImage,for: .normal)
        isDownloading = !isDownloading
    }
}
