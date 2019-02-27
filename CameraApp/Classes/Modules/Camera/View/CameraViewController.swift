//
//  CameraViewController.swift
//  Prototype
//
//  Created by Arata Sekine on 2018/12/24.
//  Copyright © 2018 Arata Sekine. All rights reserved.
//

import UIKit
import APIKit
import RxSwift
import RxCocoa

class CameraViewController: UIViewController {
    @IBOutlet weak var camera : UIButton!
    @IBOutlet weak var category : UILabel!
    
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
        let captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        guard let image = captureImage,
            var imageData = captureImage?.pngData() else {
                print("画像データがない")
                return
        }
        
        if (imageData.count > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imageData = resizeImage(newSize, image: image)
        }
        
        var request = VisionRequest()
        request.base64image = imageData.base64EncodedString(options: .endLineWithCarriageReturn)
        
        Session.send(request) {
            result in
            switch result {
            case .success(let response):
                print("成功😆")
                self.category.text = (response.labels.description)
            case .failure(let error):
                print("error: \(error)💀")
            }
        }
        
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
    
    //画像サイズ変更
    func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let resizedImage = newImage!.pngData()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}

extension CameraViewController:UINavigationControllerDelegate{
    
}
