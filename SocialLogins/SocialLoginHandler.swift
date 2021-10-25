//
//  SocialLoginHandler.swift
//  SocialLogins
//
//  Created by Trioangle on 25/10/21.
//

import Foundation
import GoogleSignIn
import FBSDKLoginKit

open
class SocialLoginsHandler : NSObject {
    public static let shared = SocialLoginsHandler()
    
    public
    func handleGoogle(url: URL) -> Bool {
        let handled = GIDSignIn.sharedInstance.handle(url)
        return handled
    }
    
    public
    func doGoogleLogin(VC: UIViewController,
                       clientID : String,
                       completion: @escaping (Result<GIDGoogleUser,Error>) -> Void) {
        let config : GIDConfiguration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config,
                                        presenting: VC) { user, error in
            if error != nil || user == nil {
                guard let error = error else { return }
                completion(.failure(error))
            } else {
                guard let user = user else { return }
                completion(.success(user))
            }
        }
    }
    
    public
    func doGoogleSignOut() {
        GIDSignIn.sharedInstance.signOut()
    }
    
    public
    func doGogleRelogin(completion: @escaping (Result<GIDGoogleUser,Error>) -> Void) {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
                guard let error = error else { return }
                completion(.failure(error))
            } else {
                guard let user = user else { return }
                completion(.success(user))
                // Show the app's signed-in state.
            }
        }
    }
}
