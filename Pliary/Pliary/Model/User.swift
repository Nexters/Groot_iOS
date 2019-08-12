//
//  User.swift
//  Pliary
//
//  Created by jueun lee on 2019. 7. 31..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import Foundation

struct User {
    
    var userId: String
    var idToken: String
    var fullName: String
    var givenName: String
    var familyName: String
    var email: String
    var photo: String?

    init(userId: String , idToken: String, fullName: String, givenName: String, familyName: String, email: String, photo: String) {
        self.userId = userId
        self.idToken = idToken
        self.fullName = fullName
        self.givenName = givenName
        self.familyName = familyName
        self.email = email
        self.photo = photo
    }
}
