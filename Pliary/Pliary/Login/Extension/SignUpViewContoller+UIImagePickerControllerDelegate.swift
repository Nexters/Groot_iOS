//
//  SignUpViewContoller+Ext.swift
//  Pliary
//
//  Created by jueun lee on 2019. 8. 3..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("Expected a dictionary containing an image, but was provided the following: \(info)")
            return
        }
        
        userProfileImageView.image = selectedImage.resize(withSize: CGSize(width: 151.0, height: 151.0), contentMode: .contentAspectFill)
        dismiss(animated: true, completion: nil)
    }
}
