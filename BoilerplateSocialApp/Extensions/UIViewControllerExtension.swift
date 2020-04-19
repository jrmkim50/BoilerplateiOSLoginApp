//
//  UIViewControllerExtension.swift
//  BoilerplateSocialApp
//
//  Created by Min on 4/18/20.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupHideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
}
