//
//  CustomPhotoPickerViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/11/21.
//

import Foundation
import TLPhotoPicker

class CustomPhotoPickerViewController: TLPhotosPickerViewController {
    override func makeUI() {
        super.makeUI()
        self.customNavItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .stop, target: nil, action: #selector(customAction))
    }
    
    @objc func customAction() {
        self.delegate?.photoPickerDidCancel()
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.dismissComplete()
            self?.dismissCompletion?()
        }
    }

    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("some")
    }
    /*
     override func maxCheck() -> Bool {
     let imageCount = self.selectedAssets.filter{ $0.phAsset?.mediaType == .image }.count
     let videoCount = self.selectedAssets.filter{ $0.phAsset?.mediaType == .video }.count
     if imageCount > 3 || videoCount > 1 {
     return true
     }
     return false
     }*/
}

extension TLPhotosPickerViewController {
    class func custom(withTLPHAssets: (([TLPHAsset]) -> Void)? = nil, didCancel: (() -> Void)? = nil) -> CustomPhotoPickerViewController {
        let picker = CustomPhotoPickerViewController(withTLPHAssets: withTLPHAssets, didCancel:didCancel)
        return picker
    }

    func wrapNavigationControllerWithoutBar() -> UINavigationController {
        let navController = UINavigationController(rootViewController: self)
        navController.navigationBar.isHidden = true
        return navController
    }
}
