//
//  FirebaseAuthenticationManager.swift
//  Pliary
//
//  Created by jueun lee on 2019. 7. 23..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthenticationManager {
    //MARK: - Properties
    
    static let shared = FirebaseAuthenticationManager()

    
    func firebaseErrorHandle(code: AuthErrorCode) {
        switch code {
        case .invalidCustomToken:
            print("Indicates a validation error with the custom token")
        case .customTokenMismatch:
            print("Indicates the service account and the API key belong to different projects")
        case .invalidCredential:
            print("Indicates the IDP token or requestUri is invalid")
        case .userDisabled:
            print("Indicates the user's account is disabled on the server")
        case .operationNotAllowed:
            print("Indicates the administrator disabled sign in with the specified identity provider")
        case .emailAlreadyInUse:
            print("Indicates the email used to attempt a sign up is already in use.")
        case .invalidEmail:
            print("Indicates the email is invalid")
        case .wrongPassword:
            print("Indicates the user attempted sign in with a wrong password")
        case .tooManyRequests:
            print("Indicates that too many requests were made to a server method")
        case .userNotFound:
            print("Indicates the user account was not found")
        case .accountExistsWithDifferentCredential:
            print("Indicates account linking is required")
        case .requiresRecentLogin:
            print("Indicates the user has attemped to change email or password more than 5 minutes after signing in")
        case .providerAlreadyLinked:
            print("Indicates an attempt to link a provider to which the account is already linked")
        case .noSuchProvider:
            print("Indicates an attempt to unlink a provider that is not linked")
        case .invalidUserToken:
            print("Indicates user's saved auth credential is invalid, the user needs to sign in again")
        case .networkError:
            print("Indicates a network error occurred (such as a timeout, interrupted connection, or unreachable host). These types of errors are often recoverable with a retry. The NSUnderlyingError field in the NSError.userInfo dictionary will contain the error encountered")
        case .userTokenExpired:
            print("Indicates the saved token has expired, for example, the user may have changed account password on another device. The user needs to sign in again on the device that made this request")
        case .invalidAPIKey:
            print("Indicates an invalid API key was supplied in the request")
        case .userMismatch:
            print("Indicates that an attempt was made to reauthenticate with a user which is not the current user")
        case .credentialAlreadyInUse:
            print("Indicates an attempt to link with a credential that has already been linked with a different Firebase account")
        case .weakPassword:
            print("Indicates an attempt to set a password that is considered too weak")
        case .appNotAuthorized:
            print("Indicates the App is not authorized to use Firebase Authentication with the provided API Key")
        case .keychainError:
            print("Indicates an error occurred while attempting to access the keychain")
        default:
            print("Indicates an internal error occurred")
        }
    }
}

