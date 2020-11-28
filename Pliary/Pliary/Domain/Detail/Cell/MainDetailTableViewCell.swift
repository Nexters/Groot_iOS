//
//  MainDetailTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 07/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Kingfisher
import Lottie

class MainDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var plantView: UIImageView!
    @IBOutlet weak var blackWaterImageView: UIImageView!
    @IBOutlet weak var addWaterButton: UIButton!
    @IBOutlet weak var dayLeftLabel: UILabel!
    @IBOutlet weak var englishNameLabel: UILabel!
    @IBOutlet weak var koreanNameLabel: UILabel!
    @IBOutlet weak var nameSplitLabel: UILabel!
    @IBOutlet weak var customNameLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var wateringAnimation: AnimationView!

    weak var delegate: DetailEventDelegate?
    var currentStatus: PlantStatus = .negative

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

        wateringAnimation.center = center
        wateringAnimation.contentMode = .scaleAspectFill
        wateringAnimation.isUserInteractionEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(setUp), name: NotificationName.reloadSelectedPlant, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NotificationName.reloadSelectedPlant, object: nil)
    }

    @IBAction func tapCloseButton(_ sender: Any) {
        delegate?.detailEvent(event: .dismiss)
    }

    @IBAction func tapMoreButton(_ sender: Any) {
        guard let plant = Global.shared.selectedPlant else {
            return
        }

        delegate?.detailEvent(plant, event: .modifyOrDeletePlant)
    }

    @IBAction func tapAddWaterButton(_ sender: Any) {
        guard let plant = Global.shared.selectedPlant else {
            return
        }

        delegate?.detailEvent(plant, event: .waterToPlant)
    }

    @IBAction func tapNextPageButton(_ sender: Any) {
        delegate?.detailEvent(event: .scrollToNextPage)
    }

    func daysBetween(start: Date, end: Date) -> Int? {
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start)
        let date2 = calendar.startOfDay(for: end)

        let a = calendar.dateComponents([.day], from: date1, to: date2)
        return a.value(for: .day)
    }

    @objc func setUp() {
        guard let plant = Global.shared.selectedPlant else {
            return
        }
        
        englishNameLabel.text = plant.englishName
        koreanNameLabel.text = plant.koreanName
        customNameLabel.text = plant.nickName
        tipLabel.text = plant.getTip()
        tipLabel.setLineHeight(lineHeight: 5)
        
        let today = Date()
        let nextWaterDay = Date(timeIntervalSince1970: plant.nextWaterDate)
        
        if let dDay = daysBetween(start: today, end: nextWaterDay) {
            if dDay == 0 {
                dayLeftLabel.text = "D-day"
                currentStatus = .negative
            } else if dDay < 0 {
                dayLeftLabel.text = "D+" + abs(dDay).description
                currentStatus = .negative
            } else {
                dayLeftLabel.text = "D-" + dDay.description
                currentStatus = .positive
            }
        }
        
        animateImage()
    }

    func animateImage() {
        guard let plant = Global.shared.selectedPlant else {
            return
        }

        var imageName: String {
            switch currentStatus {
            case .positive:
                return plant.getPositiveImageName()
            case .negative:
                return plant.getNegativeImageName()
            }
        }

        let appendPath = imageName + ".gif"
        let host = API.gifHost?.appendingPathComponent(appendPath)
        let placeHolder = UIImage(named: imageName)

        plantView.kf.setImage(with: host, placeholder: placeHolder, options: [.diskCacheExpiration(.never)], progressBlock: nil, completionHandler: { _ in

        })
    }

    func stopImage() {
        guard let plant = Global.shared.selectedPlant else {
            return
        }

        var imageName: String {
            switch currentStatus {
            case .positive:
                return plant.getPositiveImageName()
            case .negative:
                return plant.getNegativeImageName()
            }
        }

        let placeHolder = UIImage(named: imageName)
        plantView.image = placeHolder
    }

    func waterToPlant() {
        currentStatus = .positive
        wateringAnimation.stop()
        wateringAnimation.play(completion: { _ in
            self.animateImage()
        })
    }

    func makeDeleteMode() {
        guard let plant = Global.shared.selectedPlant else {
            return
        }

        let imageName = plant.getPositiveImageName()
        let placeHolder = UIImage(named: imageName)?.convertToGrayScale()
        plantView.image = placeHolder

        let blackImage = UIImage(named: ImageName.addWaterGrayButton)
        addWaterButton.setImage(blackImage, for: .normal)
    }

    func clearDeleteMode() {
        animateImage()

        let image = UIImage(named: ImageName.addWaterButton)
        addWaterButton.setImage(image, for: .normal)
    }
}
