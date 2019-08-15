//
//  MainDetailTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 07/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import SwiftyGif

class MainDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var plantView: UIImageView!
    @IBOutlet weak var blackWaterImageView: UIImageView!
    @IBOutlet weak var addWaterButton: UIButton!
    @IBOutlet weak var dayLeftLabel: UILabel!
    @IBOutlet weak var englishNameLabel: UILabel!
    @IBOutlet weak var koreanNameLabel: UILabel!
    @IBOutlet weak var nameSplitLabel: UILabel!
    @IBOutlet weak var customNameLabel: UILabel!
    
    weak var delegate: DetailEventDelegate?
    private var plant: Plant?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    @IBAction func tapMoreButton(_ sender: Any) {
        guard let plant = plant else {
            return
        }
        
        delegate?.detailEvent(plant, event: .modifyOrDeletePlant)
    }
    
    @IBAction func tapAddWaterButton(_ sender: Any) {
        guard let plant = plant else {
            return
        }
        
        delegate?.detailEvent(plant, event: .waterToPlant)
    }
    
    @IBAction func tapNextPageButton(_ sender: Any) {
        delegate?.detailEvent(event: .scrollToNextPage)
    }
    
    func setUp(with plant: Plant?) {
        self.plant = plant
    }
}
