//
//  UserProfileView.swift
//  Pliary
//
//  Created by jeewoong.han on 10/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class UserProfileView: UIView {

    weak var delegate: CameraEventDelegate?

    static func instance() -> UserProfileView {
        let view: UserProfileView = UIView.createViewFromNib(nibName: UserProfileView.identifier)
        return view
    }
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var userImage: UIImage?
    
    @IBAction func tabCameraButton(_ sender: Any) {
        delegate?.cameraEvent()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.borderWidth = 1
        profileImageView.borderColor = Color.gray6
    }
    
    func setUp(with image : UIImage) {
        userImage = image
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.image = image
    }
    
    func makeRoundImage() {
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2.0
    }
    
    func makeDeleteMode() {
        makeRoundImage()
        
        let cameraImage = UIImage(named: ImageName.grayCameraButton)
        userImage = profileImageView.image
        profileImageView.image = profileImageView.image?.convertToGrayScale()
        cameraButton.setImage(cameraImage, for: .normal)
    }
    
    func clearDeleteMode() {
        let cameraImage = UIImage(named: ImageName.profileCameraButton)
        profileImageView.image = userImage
        cameraButton.setImage(cameraImage, for: .normal)
    }
}
