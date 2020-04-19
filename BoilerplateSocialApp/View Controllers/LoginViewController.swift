//
//  LoginViewController.swift
//  BoilerplateSocialApp
//
//  Created by Min on 4/18/20.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHideKeyboardOnTap()
    }
    @IBAction func login(_ sender: Any) {
        guard let email = email.text, let password = password.text else { return }
        UserService.loginUser(email: email, password: password, with: {(user) in
            if let _ = user {
                self.view.window?.rootViewController = UIStoryboard(storyboardType: .main).instantiateInitialViewController()
                self.view.window?.makeKeyAndVisible()
            }
        })
    }
    
}
