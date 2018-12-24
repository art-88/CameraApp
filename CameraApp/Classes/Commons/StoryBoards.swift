//
//  StoryBoards.swift
//  Prototype
//
//  Created by Arata Sekine on 2018/12/24.
//  Copyright © 2018 Arata Sekine. All rights reserved.
//

import UIKit

protocol StoryboardType {
    static var storyboardName: String { get }
}

extension StoryboardType{
    static var storyboard: UIStoryboard{
        let name = self.storyboardName
        return UIStoryboard(name: name, bundle: nil)
    }
}

struct InitialSceneType<T: Any>{
    let storyboard: StoryboardType.Type
    func instantiate() -> T {
        guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
            fatalError("FatalError: ViewContoroller not found. ")
        }
        return controller
    }
}

enum StoryboradScene{
    enum MainViewController : StoryboardType {
        static let storyboardName = "Main"
        static let initialScene = InitialSceneType<CameraApp.ViewController>(
            storyboard: MainViewController.self
        )
    }
    enum CameraViewController : StoryboardType {
        static let storyboardName = "Camera"
        static let initialScene = InitialSceneType<CameraApp.CameraViewController>(
            storyboard: CameraViewController.self
        )
    }
    
}
