//
//  CacheHandlerContract.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 22/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//
public typealias CancelDownloading = () -> Void
public protocol CacheHandlerContract {
    func setupCache(memory: Int, disk: Int)
}
