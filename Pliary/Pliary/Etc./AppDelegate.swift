//
//  AppDelegate.swift
//  Pliary
//
//  Created by jeewoong.han on 20/07/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
//import Firebase
//import GoogleSignIn
import UserNotifications

@UIApplicationMain

//class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        FirebaseApp.configure()
//        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
//        GIDSignIn.sharedInstance().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: { (authorized, error) in
            if !authorized {
                print("App is useless becase you did not allow notification")
            }
        })
        
       return true
    }

//    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
//        -> Bool {    return GIDSignIn.sharedInstance().handle(url,
//                                                              sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//                                                              annotation: [:])
//    }

//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//        guard error == nil else {
//            return
//        }
//
//        guard let authentication = user.authentication else {
//            return
//        }
//
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//
//        Auth.auth().signIn(with: credential){ (auth, error) in
//            if error != nil {
//                return
//            }
//        }
//
//    }
//
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//
//        guard error == nil else {
//            return
//        }
//    }
    
}
