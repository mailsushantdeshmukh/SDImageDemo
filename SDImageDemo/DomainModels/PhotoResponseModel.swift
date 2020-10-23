//
//  PhotoResponseModel.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 21/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//

import UIKit
struct PhotoResponseModel: DomainModel {
    let photos: PhotoPageModel
    let stat: String
    init(photos: PhotoPageModel,
         stat: String) {
        self.photos = photos
        self.stat = stat
    }
    
    static func == (lhs: PhotoResponseModel, rhs: PhotoResponseModel) -> Bool {
        return lhs.photos == rhs.photos &&
            lhs.stat == rhs.stat
    }
}
