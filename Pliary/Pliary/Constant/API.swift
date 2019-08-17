//
//  API.swift
//  Pliary
//
//  Created by jeewoong.han on 17/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation

struct API {
    static let host = URL(string: "http://groot.devdogs.kr")
    static let auth = host?.appendingPathComponent("/auth/signin")
}
