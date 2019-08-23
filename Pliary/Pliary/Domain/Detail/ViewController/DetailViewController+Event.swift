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
            Global.shared.selectedPlant = nil
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
    
    func detailEvent(_ plant: Plant, event: PlantEvent) {
        switch event {
        case .modifyOrDeletePlant:
            showModifyDeleteAlert()
        case .waterToPlant:
            let waterPopup = WateringPopupView.instance(with: plant)
            waterPopup.frame = view.frame
            waterPopup.setSelectView()
            waterPopup.delegate = self
            view.addSubview(waterPopup)
        default:
            ()
        }
    }
    
    func detailEvent(_ diaryCard: DiaryCard, event: DetailDiaryCardEvent) {
        switch event {
        case .modifyOrDeleteDiaryCard:
            showDeleteCardAlert(diaryCard)
        }
    }
    
}

extension DetailViewController: PlantEventDelegate {
    func plantEvent(_ plant: Plant, event: PlantEvent) {
        switch event {
        case .completeToWater:
            tableView.visibleCells.forEach {
                if let cell = $0 as? MainDetailTableViewCell {
                    cell.waterToPlant()
                    return
                }
            }
        default:
            ()
        }
    }
    
}

extension DetailViewController {
    
    enum AlertMode {
        case plant(Plant)
        case diaryCard(DiaryCard)
    }
    
    private func showModifyDeleteAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let modifyAction = UIAlertAction(title: "수정", style: .default, handler: { _ in
            let storyboard = UIStoryboard.init(name: StoryboardName.regiserPlant, bundle: Bundle(for: ModifyPlantViewController.self))
            guard let modifyVC = storyboard.instantiateViewController(withIdentifier: ModifyPlantViewController.identifier) as? ModifyPlantViewController else {
                return
            }
            self.present(modifyVC, animated: true, completion: nil)
        })
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            
            self.showDeletePlantAlert()
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler : nil )
        
        alert.addAction(modifyAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        alert.view.tintColor = Color.gray1
        present(alert, animated: true, completion: nil)
    }
    
    private func makeDeleteMode() {
        for cell in tableView.visibleCells {
            if let plantCell = cell as? MainDetailTableViewCell {
                plantCell.makeDeleteMode()
                return
            }
        }
    }
    
    private func clearDeleteMode() {
        for cell in tableView.visibleCells {
            if let plantCell = cell as? MainDetailTableViewCell {
                plantCell.clearDeleteMode()
                return
            }
        }
    }
    
    private func showDeletePlantAlert() {
        makeDeleteMode()
        let alert = UIAlertController(title: "식물을 삭제하시겠습니까?", message: "", preferredStyle: .alert)
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: { _ in
            self.clearDeleteMode()
        })
        let deleteAccountAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            var plants: [Plant] = []
            for plant in Global.shared.plants {
                if let selectedPlant = Global.shared.selectedPlant, plant.id == selectedPlant.id {
                    Global.shared.selectedPlant = nil
                } else {
                    plants.append(plant)
                }
            }
            Global.shared.plants = plants
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancleAction)
        alert.addAction(deleteAccountAction)
        alert.view.tintColor = Color.gray1
        
        present(alert, animated: true, completion: nil)
    }
    
    
    private func showDeleteCardAlert(_ diaryCard: DiaryCard) {
        let alert = UIAlertController(title: "카드를 삭제하시겠습니까?", message: "", preferredStyle: .alert)
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler : nil)
        let deleteAccountAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            if let id = Global.shared.selectedPlant?.id {
                let array = Global.shared.diaryDict[id] ?? []
                var newArray: [DiaryCard] = []
                for card in array {
                    if card.timeStamp != diaryCard.timeStamp {
                        newArray.append(card)
                    }
                }
                Global.shared.diaryDict[id] = newArray
            }
        }
        
        alert.addAction(cancleAction)
        alert.addAction(deleteAccountAction)
        alert.view.tintColor = Color.gray1
        
        present(alert, animated: true, completion: nil)
    }
}
