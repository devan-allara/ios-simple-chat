//
//  SignUpViewController.swift
//  ios-firebase-chat
//
//  Created by Ryan Brashear on 8/7/17.
//  Copyright © 2017 Devan Allara. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
    
}
