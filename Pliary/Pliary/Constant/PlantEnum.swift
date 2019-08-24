//
//  PlantEnum.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation

enum PlantEnglishName: String {
    case stuki = "Stuki"
    case eucalyptus = "Eucalyptus"
    case sansevieria = "Sansevieria"
    case monstera = "Monstera"
    case parlourPalm = "Parlour Palm"
    case elastica = "Elastica"
    case travelersPalm = "Traveler's Palm"
    case schefflera = "Schefflera"
}

enum PlantKoreanName: String {
    case stuki = "스투키"
    case eucalyptus = "유칼립투스"
    case sansevieria = "산세베리아"
    case monstera = "몬스테라"
    case parlourPalm = "테이블 야자"
    case elastica = "고무나무"
    case travelersPalm = "여인초"
    case schefflera = "홍콩야자"
}

enum PlantRegisterImageName: String {
    case stuki = "stuki"
    case eucalyptus = "eucalyptus"
    case sansevieria = "sansevieria"
    case monstera = "monstera"
    case parlourPalm = "parlourPalm"
    case elastica = "elastica"
    case travelersPalm = "travelerSPalm"
    case schefflera = "schefflera"
    case userPlants = "userplant"
}

enum PlantPositiveImageName: String {
    case stuki = "iOS_Posi_Stuki"
    case eucalyptus = "iOS_Posi_Eucalyptus"
    case sansevieria = "iOS_Posi_Sansevieria"
    case monstera = "iOS_Posi_Monstera"
    case parlourPalm = "iOS_Posi_Chamaedorea_elegans"
    case elastica = "iOS_Posi_gomu"
    case travelersPalm = "iOS_Posi_traveler_s palm"
    case schefflera = "iOS_Posi_hongkong"
    case userPlants = "iOS_Posi_UserMakePlant"
}

enum PlantNegativeImageName: String {
    case stuki = "iOS_Nega_Stuki"
    case eucalyptus = "iOS_Nega_Eucalyptus"
    case sansevieria = "iOS_Nega_Sansevieria"
    case monstera = "iOS_Nega_Monstera"
    case parlourPalm = "iOS_Nega_Chamaedorea-elegans"
    case elastica = "iOS_Nega_gomu"
    case travelersPalm = "iOS_Nega_Traveler’s-palm"
    case schefflera = "iOS_Nega_hongkong"
    case userPlants = "iOS_Nega_UserMakePlant"
}

enum PlantReference: String {
    case stuki = "스투키는 대부분 한 달에 1번 물을 주는 것을 추천합니다."
    case eucalyptus = "유칼립투스는 대부분 3-4일에 1번 물을 주는 것을 추천합니다."
    case sansevieria = "산세베리아는 대부분 한 달에 1번 물을 주는 것을 추천합니다."
    case monstera = "몬스테라는 대부분 3-5일에 1번 물을 주는 것을 추천합니다."
    case parlourPalm = "테이블야자는 대부분 7일에 1번 물을 주는 것을 추천합니다."
    case elastica = "고무나무는 대부분 7일에 1번 물을 주는 것을 추천합니다."
    case travelersPalm = "여인초는 대부분 10일에 1번 물을 주는 것을 추천합니다."
    case schefflera = "홍콩야자는 대부분 5일에 1번 물을 주는 것을 추천합니다."
    case userPlants = "물을 줄때 겉흙이 말랐는지 참고해주세요."
}

enum PlantTip: String {
    case stuki = "스투키의 잎이 갈라지거나 슬림 해진다면 흙의 습도를 확인하고 물을 주세요. 스투키는 햇빛, 물, 통풍에 유의하여 키워주세요."
    case eucalyptus = "유칼립투스는 직사광선보단 햇볕과 바람이 잘 드는 곳에서 키워주세요. 잎이 건조해 보인다면 분무기로 물을 주세요."
    case sansevieria = "산세베리아의 잎이 노랗게 변한다면 흙의 습도를 확인하고 물을 주세요. 산세베리아는 따뜻한 곳에서 다소  건조하게 키워주세요."
    case monstera = "몬스테라는 빛이 없는 곳에서도 잘 자랍니다. 직사광선을 받으면 잎이 타버려 갈색으로 변할 수 있습니다."
    case parlourPalm = "테이블야자는 NASA에서 선정한 공기정화 식물입니다. 미세먼지를 제거하고, 전자파를 차단해줍니다. 따뜻한 곳에서 키우길 권장합니다."
    case elastica = "고무나무는 실내 밝은 그늘에서 관리하는 것이 좋습니다. 암모니아 제거에 탁월한 효능이 있습니다. 겉흙이 말라있다면 물을 주세요."
    case travelersPalm = "여인초는 통풍이 잘 되는 곳을 선호합니다. 잦은 장소 이동은 스트레스를 줄 수 있습니다."
    case schefflera = "홍콩야자는 증산작용이 뛰어나 가습기 역할을 합니다. 새집증후군을 없애는데 탁월합니다. 홍콩야자의 겉흙이 마르면 물을 주세요."
    case userPlants = "물을 줄때 겉흙이 말랐는지 참고해주세요. 햇빛과 통풍 모두 신경써주는게 좋습니다."
}
