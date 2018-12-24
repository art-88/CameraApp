//
//  CameraViewController.swift
//  Prototype
//
//  Created by Arata Sekine on 2018/12/24.
//  Copyright © 2018 Arata Sekine. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class CameraViewController: UIViewController {
    @IBOutlet weak var camera : UIButton!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        camera.rx.tap.asDriver().drive(
            onNext: { [weak self] _ in
                self?.startCamera()
            }
            ).disposed(by :bag)
    }
    
    func startCamera(){
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            // カメラビューの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = .camera
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
}

extension CameraViewController:UIImagePickerControllerDelegate{
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 撮影した画像
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        // 撮影した画像をカメラロールに保存
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        print("🐔")
        //カメラを閉じる
        picker.dismiss(animated: true, completion: nil)
        print("🐤")
    }
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        print("🐣")
    }
}

extension CameraViewController:UINavigationControllerDelegate{
    
}

