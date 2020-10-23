//
//  SDPhotoLibraryMapper.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 20/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//
import Foundation
class SDPhotoLibraryMapper: SDPhotoLibraryMapperContract {
    func mapToViewModel(models: [PhotoModel]) -> [PhotoViewModel] {
        return models.map { model -> PhotoViewModel in
            PhotoViewModel(title: model.title, imageUrl: model.imageUrl)
        }
    }
}
