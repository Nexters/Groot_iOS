//
//  SelectPlantTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class SelectPlantTableViewCell: UITableViewCell {

    @IBOutlet weak var selectedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        selectedImageView.isHidden = true
    }
    
    func selected() {
        backgroundColor = Color.gray7
        selectedImageView.isHidden = false
    }
    
    func deselected() {
        backgroundColor = .white
        selectedImageView.isHidden = true
    }
}
