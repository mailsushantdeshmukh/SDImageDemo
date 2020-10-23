//
//  PhotoResponseEntity.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 21/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//
import CommonCode
struct PhotoResponseEntity: DataEntity {
    let photos: PhotoPageEntity?
    let stat: String?
    
    //Will convert entity to domain while checking the values for appropriate property
    func toDomainModel() throws -> PhotoResponseModel{
        guard let photos = photos else {
            let context = EncodingError.Context(codingPath: [PhotoResponseEntity.CodingKeys.photos], debugDescription: "Wrong value for photos")
            throw SDPhotoError.parseError(EncodingError.invalidValue("", context) as NSError)
        }
       guard let stat = stat else {
            let context = EncodingError.Context(codingPath: [PhotoResponseEntity.CodingKeys.stat], debugDescription: "Wrong value for stat")
            throw SDPhotoError.parseError(EncodingError.invalidValue("", context) as NSError)
        }
        return PhotoResponseModel(photos: try photos.toDomainModel(),
                                  stat: stat)
    }
}
