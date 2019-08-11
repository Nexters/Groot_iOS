//
//  Setting.swift
//  Pliary
//
//  Created by jeewoong.han on 11/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation

struct Setting {
    let title: SettingTitle
    let type: SettingType
}

enum SettingTitle: String {
    case changePassword = "비밀번호 변경"
    case logout = "로그아웃"
    case deleteAccount = "회원탈퇴"
    case updateAlert = "물 주기 알림"
}

enum SettingType {
    case next
    case updateSwitch
}
