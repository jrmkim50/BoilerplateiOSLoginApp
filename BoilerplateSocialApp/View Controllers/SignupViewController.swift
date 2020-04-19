//
//  SignupViewController.swift
//  BoilerplateSocialApp
//
//  Created by Min on 4/18/20.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHideKeyboardOnTap()
    }
    
    @IBAction func register(_ sender: Any) {
        if let name = name.text, let email = email.text, let username = username.text, let password = password.text {
            UserService.signupUser(name: name, username: username, email: email, password: password, with: {(user) in
                if let _ = user {
                    let storyboard = UIStoryboard.init(storyboardType: .main)
                    self.view.window?.rootViewController = storyboard.instantiateInitialViewController()
                    self.view.window?.makeKeyAndVisible()
                }
            })
        }
    }
    
}
