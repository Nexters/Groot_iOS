//
//  UserProfileView.swift
//  Pliary
//
//  Created by jeewoong.han on 10/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class UserProfileView: UIView {

    weak var delegate: LoginEventDelegate?
    let defaultPrifile : UIImage = #imageLiteral(resourceName: "defaultProfie")

    static func instance() -> UserProfileView {
        let view: UserProfileView = UIView.createViewFromNib(nibName: UserProfileView.identifier)
        return view
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBAction func tabCameraButton(_ sender: Any) {
        delegate?.loginEvent()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.image = defaultPrifile.resize(withSize: CGSize(width: 67, height: 53))
        profileImageView.contentMode = .center
        profileImageView.cornerRadius = profileImageView.frame.height / 2.0
        profileImageView.borderWidth = 1
        profileImageView.borderColor = Color.gray6
    }
    func setUp(with image : UIImage) {
        profileImageView.image = image.resize(withSize: CGSize(width: profileImageView.frame.width, height: profileImageView.frame.height))
        profileImageView.contentMode = .scaleAspectFill
    }

}
