//
//  Constant.swift
//  Pliary
//
//  Created by jeewoong.han on 01/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

enum AssetKey: String {
    case plants
    case diaryCard
}

struct NotificationName {
    static let reloadDiaryCard = Notification.Name.init("reloadDiaryCard")
}

struct StoryboardName {
    static let home = "Home"
    static let setting = "Setting"
    static let detail = "Detail"
    static let regiserPlant = "RegisterPlant"
    static let login = "Login"
    static let selectPhoto = "SelectPhoto"
}

struct ImageName {
    static let completeButton = "BtnComplete"
    static let moreButton = "BtnMore"
    static let plusButton = "BtnAddBlack"
    static let addWaterButton = "AddWater"
    static let addWaterGrayButton = "AddWaterGray"
    static let minusButton = "BtnSubtract"
    static let profileCameraButton = "Camera2"
    static let loginImage = "LoginAnimation"
    static let waterBlue = "WaterBlue"
}

struct Color {
    static let gray1 = UIColor(red: 43.0 / 255.0, green: 45.0 / 255.0, blue: 46.0 / 255.0, alpha: 1.0)
    static let gray2 = UIColor(white: 88.0 / 255.0, alpha: 1.0)
    static let gray3 = UIColor(white: 120.0 / 255.0, alpha: 1.0)
    static let gray4 = UIColor(white: 169.0 / 255.0, alpha: 1.0)
    static let gray5 = UIColor(white: 205.0 / 255.0, alpha: 1.0)
    static let gray6 = UIColor(white: 224.0 / 255.0, alpha: 1.0)
    static let gray7 = UIColor(white: 238.0 / 255.0, alpha: 1.0)
    static let green = UIColor(red: 106.0 / 255.0, green: 167.0 / 255.0, blue: 111.0 / 255.0, alpha: 1.0)
    static let white = UIColor(white: 1.0, alpha: 1.0)
    static let pink = UIColor(red: 1.0, green: 116.0 / 255.0, blue: 116.0 / 255.0, alpha: 1.0)
    static let blueCalendar = UIColor(red: 135.0 / 255.0, green: 191.0 / 255.0, blue: 1.0, alpha: 1.0)
    static let blueCalendarSelect = UIColor(red: 94.0 / 255.0, green: 162.0 / 255.0, blue: 1.0, alpha: 1.0)
    static let greenCalendarSelect = UIColor(red: 129.0 / 255.0, green: 204.0 / 255.0, blue: 137.0 / 255.0, alpha: 1.0)
    static let greenCalendar = UIColor(red: 174.0 / 255.0, green: 230.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0)
    static let bG = UIColor(white: 249.0 / 255.0, alpha: 1.0)
    static let buttonShadow = UIColor(red: 105.0/255.0, green: 146.0/255.0, blue: 117.0/255.0, alpha: 0.4)
}

