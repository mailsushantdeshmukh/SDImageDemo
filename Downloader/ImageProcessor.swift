//
//  ImageProcessor.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 22/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//
import Foundation
import UIKit

public protocol Processor {
    associatedtype ParsedObject
    var parse: (Data) throws -> ParsedObject { get }
}

public struct ImageProcessor: Processor { }
public extension ImageProcessor {
    var parse: (Data) throws -> UIImage? {
        return { data in
            UIImage(data: data)
        }
    }
}
