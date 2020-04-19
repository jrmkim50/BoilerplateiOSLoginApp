//
//  UIStoryboardExtension.swift
//  BoilerplateSocialApp
//
//  Created by Min on 4/18/20.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum storyboardType: String {
        case main
        case login
        //add more cases as I add extra storyboards
    
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(storyboardType: storyboardType, bundle: Bundle? = nil) {
        self.init(name: storyboardType.filename, bundle: bundle)
    }
    
    static func getInitialViewController(for type: storyboardType) -> UIViewController {
        let storyboard = UIStoryboard.init(storyboardType: type)
        guard let initialVC = storyboard.instantiateInitialViewController() else {
            fatalError("Could not initialize view controller for requested view controller")
        }
        return initialVC
    }
}
