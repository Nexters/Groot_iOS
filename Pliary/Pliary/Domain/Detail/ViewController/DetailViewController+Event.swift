//
//  DetailViewController+Event.swift
//  Pliary
//
//  Created by jeewoong.han on 16/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Hero

extension DetailViewController: DetailEventDelegate {
    func detailEvent(event: DetailLayoutEvent) {
        switch event {
        case .dismiss:
            Hero.shared.cancel()
            dismiss(animated: true, completion: nil)
        case .changeSectionToCalendar:
            currentSection = .calendar
        case .changeSectionToDiary:
            currentSection = .diaryCard
        case .scrollToNextPage:
            let indexPath = IndexPath(row: 0, section: 1)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            animatePlant(false)
        case .scrollToPreviousPage:
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            animatePlant(true)
        case .goDiaryViewController(let card):
            goDiaryViewController(with: card)
        }
    }
    
    func detailEvent(_ plant: Plant, event: DetailPlantEvent) {
        switch event {
        case .modifyOrDeletePlant:
            showModifyDeleteAlert(mode: .plant(plant))
        case .waterToPlant:
            let waterPopup = WateringPopupView.instance(with: plant)
            waterPopup.frame = view.frame
            waterPopup.setSelectView()
            view.addSubview(waterPopup)
        }
    }
    
    func detailEvent(_ diaryCard: DiaryCard, event: DetailDiaryCardEvent) {
        switch event {
        case .modifyOrDeleteDiaryCard:
            showModifyDeleteAlert(mode: .diaryCard(diaryCard))
        }
    }
    
}

extension DetailViewController {
    
    enum AlertMode {
        case plant(Plant)
        case diaryCard(DiaryCard)
    }
    
    private func showModifyDeleteAlert(mode: AlertMode) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let modifyAction = UIAlertAction(title: "수정", style: .default, handler: { _ in
            switch mode {
            case .plant(let plant):
                let storyboard = UIStoryboard.init(name: StoryboardName.regiserPlant, bundle: Bundle(for: ModifyPlantViewController.self))
                guard let modifyVC = storyboard.instantiateViewController(withIdentifier: ModifyPlantViewController.identifier) as? ModifyPlantViewController else {
                    return
                }
                self.present(modifyVC, animated: true, completion: nil)
            case .diaryCard(let card):
                ()
            }
        })
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            
            switch mode {
            case .plant(let plant):
                ()
            case .diaryCard(let card):
                ()
            }
            
            self.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler : nil )
        
        alert.addAction(modifyAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        alert.view.tintColor = .black
        present(alert, animated: true, completion: nil)
    }
    
}
