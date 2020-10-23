//
//  SDPhotoLibrarynteractor.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 20/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//
import Downloader
import CommonCode
import Foundation

class SDPhotoLibraryInteractor: SDPhotoLibraryInteractorContract {
    weak var presenter: SDPhotoLibraryInteractorToPresenterContract?
    
    func loadRecentPhotos() {
        CacheHandler.sharedHandler.setupCache(memoryInMB: 100, diskCapacityInMB: 100)
        presenter?.startLoading()
        let serviceProvider = ServiceProvider<SDPhotoService>(service: .getRecent)
        serviceProvider.response { [weak self] (data, error) in
            guard let self = self else { return }
            self.presenter?.stopLoading()
            do {
                if let error = error {
                    self.presenter?.presentError(error: error)
                } else if let data = data {
                    let response = try JSONDecoder()
                        .decode(PhotoResponseEntity.self, from: data).toDomainModel()
                    self.presenter?.presentPhotos(photos: response.photos.photo)
                } else {
                    self.presenter?
                        .presentError(error: SDPhotoError.parseError((URLError(.badServerResponse))))
                }
            }
            catch {
                self.presenter?.presentError(error: SDPhotoError.parseError(error))
            }
        }
    }
    
    func searchPhoto(with text: String) {
        presenter?.startLoading()
        let serviceProvider = ServiceProvider<SDPhotoService>(service: .searchPhotos(text: text))
        serviceProvider.response { [weak self] (data, error) in
            guard let self = self else { return }
            self.presenter?.stopLoading()
            do {
                if let error = error {
                    self.presenter?.presentError(error: error)
                } else if let data = data {
                    let response = try JSONDecoder()
                        .decode(PhotoResponseEntity.self, from: data).toDomainModel()
                    self.presenter?.presentPhotos(photos: response.photos.photo)
                } else {
                    self.presenter?
                        .presentError(error: SDPhotoError.parseError((URLError(.badServerResponse))))
                }
            }
            catch {
                self.presenter?.presentError(error: SDPhotoError.parseError(error))
            }
        }
    }
    
}
