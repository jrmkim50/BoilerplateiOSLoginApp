//
//  User.swift
//  BoilerplateSocialApp
//
//  Created by Min on 4/18/20.
//  Copyright © 2020 Min. All rights reserved.
//

//
//  User.swift
//  PriceWatch
//
//  Created by Min on 3/17/20.
//  Copyright © 2020 Min. All rights reserved.
//

import Foundation
import FirebaseFirestore

class User: Codable {
    let uid: String
    let username: String
    let email: String
    var needsOnBoarding: Bool = true
    
    private static var _current: User?
    
    static var current: User {
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        return currentUser
    }
    
    init(uid: String, username: String, email: String) {
        self.uid = uid
        self.username = username
        self.email = email
    }
    
    init?(snapshot: DocumentSnapshot) {
        guard let dict = snapshot.data() as? [String: Any], let username = dict["Username"] as? String, let email = dict["Email"] as? String else {
            return nil
        }
        self.uid = snapshot.documentID
        self.username = username
        self.email = email
    }
    
    static func setCurrent(user: User, writeToUserDefaults: Bool = false) {
        _current = user
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
            }
        }
    }
}
