//
//  DrinkingInfoCardTableViewCell.swift
//  Pliary
//
//  Created by jueun lee on 2019. 8. 6..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit

class WateringInfoTableViewCell: UITableViewCell {

    static let height: CGFloat = 66.5
    let date : Int = 0
    weak var delegate: DetailEventDelegate?
    
    @IBOutlet weak var waterImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

}
