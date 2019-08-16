//
//  DetailTableHeaderView.swift
//  Pliary
//
//  Created by jeewoong.han on 08/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class DetailTableHeaderView: UIView {
    
    @IBOutlet weak var diaryButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var underlineBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var underlineBarLeadingConstraint: NSLayoutConstraint!
    
    static let height: CGFloat = (92 + UIApplication.shared.statusBarFrame.height / 2)
    weak var delegate: DetailEventDelegate?
    var currentSection: Section = .diaryCard {
        didSet {
            switch currentSection {
            case .diaryCard:
                diaryButton.setTitleColor(Color.gray1, for: .normal)
                calendarButton.setTitleColor(Color.gray4, for: .normal)
                underlineBarWidthConstraint.constant = diaryButton.frame.width
                underlineBarLeadingConstraint.constant = diaryButton.frame.minX
            case .calendar:
                diaryButton.setTitleColor(Color.gray4, for: .normal)
                calendarButton.setTitleColor(Color.gray1, for: .normal)
                underlineBarWidthConstraint.constant = calendarButton.frame.width
                underlineBarLeadingConstraint.constant = calendarButton.frame.minX
            }
        }
    }
    
    static func instance(with section: Section) -> DetailTableHeaderView {
        let view: DetailTableHeaderView = UIView.createViewFromNib(nibName: DetailTableHeaderView.identifier)
        view.currentSection = section
        return view
    }
    
    @IBAction func tapDiaryButton(_ sender: Any) {
        currentSection = .diaryCard
        delegate?.detailEvent(event: .changeSectionToDiary)
    }
    
    @IBAction func tapCalendarButton(_ sender: Any) {
        currentSection = .calendar
        delegate?.detailEvent(event: .changeSectionToCalendar)
    }
    
    @IBAction func tapPreviousPageButton(_ sender: Any) {
        delegate?.detailEvent(event: .scrollToPreviousPage)
    }
}
