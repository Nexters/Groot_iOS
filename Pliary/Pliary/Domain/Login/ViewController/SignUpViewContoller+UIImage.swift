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
        
        let userProfile = UserProfileView.instance()
        userProfile.profileImageView.image = selectedImage
        userProfile.profileImageView.contentMode = .scaleAspectFill
        userProfile.frame = CGRect(x: 0, y: 0, width: userProfileView.bounds.width, height: userProfileView.bounds.height)
        userProfile.setUp(with: selectedImage)
        userProfileView.addSubview(userProfile);
        
        dismiss(animated: true, completion: nil)
    }
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    func selectImageFromPhotoLibrary() {
        // Hide the keyboard.
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}
