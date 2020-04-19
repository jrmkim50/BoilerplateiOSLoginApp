//
//  UserService.swift
//  BoilerplateSocialApp
//
//  Created by Min on 4/18/20.
//  Copyright © 2020 Min. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

struct UserService {
    
    static func signupUser(name: String, username: String, email: String, password: String, with completion: @escaping ((User?) -> Void)) {
        let db = Firestore.firestore()
        let auth = Auth.auth()
        checkUsernameAvailibility(username: username, with: {(usernameAvailibility) in
            if usernameAvailibility == true {
                auth.createUser(withEmail: email, password: password, completion: {(authResult, error) in
                    if let error = error {
                        print(error)
                        return completion(nil)
                    } else {
                        if let authResult = authResult {
                            let usrAttrs = ["Name": name, "Email": email, "Username": username]
                            let ref = db.collection("Basic User Information").document(authResult.user.uid)
                            ref.setData(usrAttrs, completion: {(error) in
                                if let _ = error {
                                    return completion(nil)
                                }
                                ref.addSnapshotListener { documentSnapshot, error in
                                    if let error = error {
                                        print(error)
                                        return completion(nil)
                                    }
                                    guard let documentSnapshot = documentSnapshot else { return completion(nil) }
                                    guard let user = User(snapshot: documentSnapshot) else { return completion(nil) }
                                    User.setCurrent(user: user, writeToUserDefaults: true)
                                    completion(user)
                                }
                            })
                        } else {
                            return completion(nil)
                        }
                    }
                })
            }
        })
    }
    
    static func loginUser(email: String, password: String, with completion: @escaping ((User?) -> Void)) {
        let db = Firestore.firestore()
        let auth = Auth.auth()
        auth.signIn(withEmail: email, password: password, completion: {(authResult, error) in
            if let error = error {
                print(error)
                return completion(nil)
            } else {
                guard let authResult = Auth.auth().currentUser else { return completion(nil) }
                let ref = db.collection("Basic User Information").document(authResult.uid)
                ref.addSnapshotListener { documentSnapshot, error in
                    if let error = error {
                        print(error)
                        return completion (nil)
                    }
                    guard let documentSnapshot = documentSnapshot else { return completion(nil) }
                    guard let user = User(snapshot: documentSnapshot) else { return completion(nil) }
                    User.setCurrent(user: user, writeToUserDefaults: true)
                    completion(user)
                }
            }
        })
    }
    
    static func logoutUser() {
        let auth = Auth.auth()
        do {
            try auth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    static func checkUsernameAvailibility(username: String, with completion: @escaping ((Bool) -> Void)) {
        let ref = Firestore.firestore().collection("Basic User Information")
        let query = ref.whereField("Username", isEqualTo: username)
        query.getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(false)
            } else {
                if querySnapshot?.documents.count == 0 {
                    print("Username not in use!")
                    completion(true)
                }
            }
        }
    }
}
