//
//  DiaryCard.swift
//  Pliary
//
//  Created by jeewoong.han on 08/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation
import Photos

struct DiaryCard: Equatable, Codable {
    let timeStamp: Double
    var diaryText: String?
    var imageURL: String?
}
