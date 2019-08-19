//
//  MainDetailTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 07/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Kingfisher

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
    
    @IBAction func tapCloseButton(_ sender: Any) {
        delegate?.detailEvent(event: .dismiss)
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
    
    func animateImage() {
        guard let plant = plant else {
            return
        }
        
        let imageName = plant.getPositiveImageName()
        let appendPath = "/" + imageName.replacingOccurrences(of: "iOS", with: "And") + ".gif"
        let host = API.gifHost?.appendingPathComponent(appendPath)
        let placeHolder = UIImage(named: imageName)
        
        plantView.kf.setImage(with: host, placeholder: placeHolder, options: nil, progressBlock: nil, completionHandler: { _ in
            
        })
    }
    
    func stopImage() {
        guard let plant = plant else {
            return
        }
        
        let imageName = plant.getPositiveImageName()
        let placeHolder = UIImage(named: imageName)
        plantView.image = placeHolder
    }
}
