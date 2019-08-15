//
//  DetailEventDelegate.swift
//  Pliary
//
//  Created by jeewoong.han on 16/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation

protocol DetailEventDelegate: class {
    func detailEvent(event: DetailLayoutEvent)
    func detailEvent(_ plant: Plant, event: DetailPlantEvent)
    func detailEvent(_ diaryCard: DiaryCard, event: DetailDiaryCardEvent)
}

enum DetailPlantEvent {
    case modifyOrDeletePlant
    case waterToPlant
}

enum DetailLayoutEvent {
    case scrollToNextPage
    case scrollToPreviousPage
    case changeSectionToDiary
    case changeSectionToCalendar
}

enum DetailDiaryCardEvent {
    case modifyOrDeleteDiaryCard
}

enum Section: String {
    case diaryCard
    case calendar
}
