//
//  ViewController.swift
//  Prototype
//
//  Created by Arata Sekine on 2018/12/24.
//  Copyright © 2018 Arata Sekine. All rights reserved.
//

import UIKit
import APIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var changeButton: UIButton!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeButton.rx.tap.asDriver().drive(
            onNext: { [weak self] _ in
                print("🐋")
                let vc = StoryboradScene.CameraViewController.initialScene.instantiate()
                self?.navigationController?.pushViewController(vc, animated: true)
                print("🐠")
            }
            ).disposed(by :bag)
    }
}

