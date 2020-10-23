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
    @IBOutlet weak var canelButton: UIButton!
    var cancelDownload: CancelDowloading?
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
  
    func setPhoto(photoViewModel: PhotoViewModel){
        cancelDownload = imageView.loadImage(url: photoViewModel.imageUrl)
    }
    
    @IBAction func pauseResumeAction(_ sender: Any) {
        cancelDownload?()
    }
}
