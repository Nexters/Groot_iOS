//
//  Global.swift
//  Pliary
//
//  Created by jeewoong.han on 17/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation
import FirebaseAuth

class Global: NSObject {
    static let shared: Global = Global()
    
    var user: User?
    var plants: [Plant] = []
    
    func getAccessToken() {
        if let email = Auth.auth().currentUser?.email {
            if let authHost = API.auth {
                
                let json: [String: String] = ["email": email]
                let jsonData = try? JSONSerialization.data(withJSONObject: json)
                
                var urlRequest = URLRequest(url: authHost)
                urlRequest.httpMethod = "POST"
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = jsonData
                
                URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                    
                    print(error?.localizedDescription)
                    
                    if let res = response as? HTTPURLResponse {
                        print(res.allHeaderFields)
                        print(res.statusCode)
                    }
                    
                    if let d = data, let string = String(data: d, encoding: .utf8) {
                        print(string)
                    }
                    
                })
//                    .resume()
                
            } else {
                // host error
            }
        } else {
            user = nil
        }
    }
    
    override init() {
        super.init()
        getAccessToken()
    }
}
