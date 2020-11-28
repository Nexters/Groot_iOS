//
//  DatabaseManager.swift
//  Pliary
//
//  Created by jeewoong.han on 2020/11/29.
//  Copyright © 2020 groot.nexters.pliary. All rights reserved.
//

import Foundation

import FirebaseDatabase

final class DatabaseManager {
    
    static func uploadTotalImageSize(uuid: String, value: String) {
        let ref = Database.database().reference()
        let imageRef = ref.child("iOS/user_storage_amount/\(uuid)/image")
        imageRef.setValue(value)
    }
}
