//
//  CacheHandler.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 22/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//

import UIKit
public final class CacheHandler: NSObject {
    private let MB = 1024 * 1024
    public static let sharedHandler = CacheHandler()
    public var cache = URLCache()
    public func setupCache(memoryInMB: Int = 100,
                           diskCapacityInMB: Int = 100) {
        cache.memoryCapacity = memoryInMB * MB
        cache.diskCapacity = diskCapacityInMB * MB

    }
}
