//
//  DiaryCardWithImageTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Kingfisher

class DiaryCardWithImageTableViewCell: UITableViewCell {
    
    weak var delegate: DetailEventDelegate?
    private var diaryCard: DiaryCard?
    
    @IBOutlet weak var diaryImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func tapMoreButton(_ sender: Any) {
        guard let card = diaryCard else {
            return
        }
        
        delegate?.detailEvent(card, event: .modifyOrDeleteDiaryCard)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        layer.applySketchShadow( color: #colorLiteral(red: 0.3490196078, green: 0.3529411765, blue: 0.4235294118, alpha: 0.08), alpha: 0.8, x: 0, y: 9, blur: 15, spread: 0)
    }
    
    func setUp(with diaryCard: DiaryCard) {
        self.diaryCard = diaryCard
        
        dateLabel.text = diaryCard.timeStamp.getSince1970String()
        
        diaryImageView.image = nil
               if let path = diaryCard.imageURL, let url = AssetManager.getImageURL(path: path) {
                   let provider = LocalFileImageDataProvider(fileURL: url)
                   diaryImageView.kf.setImage(with: provider, placeholder: UIImage(), options: nil, progressBlock: nil, completionHandler: { _ in })
               }
    }
}
