//
//  SignUpViewController.swift
//  ios-firebase-chat
//
//  Created by Ryan Brashear on 8/7/17.
//  Copyright © 2017 Devan Allara. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if let err:Error = error {
                    print(err.localizedDescription)
                    return
                }
                
                self.performSegue(withIdentifier: "unwindToLogin", sender: self)
            })
        }
    }
}
