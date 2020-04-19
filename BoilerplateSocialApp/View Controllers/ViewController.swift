//
//  ViewController.swift
//  BoilerplateSocialApp
//
//  Created by Min on 4/18/20.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func logout(_ sender: Any) {
        UserService.logoutUser()
        self.view.window?.rootViewController = UIStoryboard(storyboardType: .login).instantiateInitialViewController()
        self.view.window?.makeKeyAndVisible()
    }
    

}

