//
//  DataEntity.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 21/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//
import Foundation

public typealias DataEntity = Codable & DomainTransformable
public protocol DomainTransformable {
    associatedtype DomainModel
    func toDomainModel() throws -> DomainModel
}

public extension Array where Element: DomainTransformable {
    func toDomainModel() throws -> [Element.DomainModel] {
        try map {try $0.toDomainModel()}
    }
}
