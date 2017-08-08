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
    
    //References to UI elements
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        //Go back to the login screen
        self.performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        //If both text fields have text
        if emailTextField.text != "" && passwordTextField.text != "" {
            //Create a new Firebase user with the values in the text fields
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if let err:Error = error {
                    print(err.localizedDescription)
                    return
                }
                //Go back to the login screen
                self.performSegue(withIdentifier: "unwindToLogin", sender: self)
            })
        }
    }
}
