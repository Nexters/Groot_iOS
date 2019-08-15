//
//  DiaryCardWithAllTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 01/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class DiaryCardWithAllTableViewCell: UITableViewCell {

    static let height: CGFloat = 300
    weak var delegate: DetailEventDelegate?
    private var diaryCard: DiaryCard?
    
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
    }
    
}
