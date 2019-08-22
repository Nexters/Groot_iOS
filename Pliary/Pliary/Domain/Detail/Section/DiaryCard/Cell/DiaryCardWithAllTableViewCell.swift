//
//  DiaryCardWithAllTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 01/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class DiaryCardWithAllTableViewCell: UITableViewCell {

    weak var delegate: DetailEventDelegate?
    private var diaryCard: DiaryCard?
    
    @IBOutlet weak var diaryImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var diaryTextLabel: UILabel!
    
    @IBAction func tapMoreButton(_ sender: Any) {
        guard let card = diaryCard else {
            return
        }
        
        delegate?.detailEvent(card, event: .modifyOrDeleteDiaryCard)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setUp(with diaryCard: DiaryCard) {
        self.diaryCard = diaryCard
        
        diaryTextLabel.text = diaryCard.diaryText
        dateLabel.text = diaryCard.timeStamp.getSince1970String()
        
        if let identifier = diaryCard.diaryImageIdentifier {
            if let asset = AssetManager.fetchImages(by: [identifier]).first {
                diaryImageView.fetchOpportunisticImage(asset: asset)
            } else {
                diaryImageView.image = nil
            }
        }
    }
    
}
