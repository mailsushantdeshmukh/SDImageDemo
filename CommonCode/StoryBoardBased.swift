//
//  StoryBoardBased.swift
//  SDImageDemo
//
//  Created by Sushant Deshmukh on 22/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//

import UIKit

public protocol StoryBoardBased {
    static var sceneStoryboard: UIStoryboard { get }
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle { get }
    static var sceneIdentifier: String { get }
}
public extension StoryBoardBased {
    static var sceneStoryboard: UIStoryboard { UIStoryboard(name: storyboardName, bundle: storyboardBundle) }
    static var storyboardBundle: Bundle { Bundle(for: self as! AnyClass) }
    static var sceneIdentifier: String { String(describing: self) }
}
public extension StoryBoardBased {
    static func instantiate()-> Self {
        let viewController = sceneStoryboard.instantiateViewController(identifier: sceneIdentifier)
        guard let typedViewController = viewController as? Self else {
            fatalError("The viewcontroller '\(sceneIdentifier)' of  '\(sceneStoryboard)' is not class'")
        }
        return typedViewController
    }
}
