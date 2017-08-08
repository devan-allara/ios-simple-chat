//
//  LoginViewController.swift
//  ios-firebase-chat
//
//  Created by Devan Allara on 7/17/17.
//  Copyright © 2017 Devan Allara. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper


class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var email: String!
    var password: String!
    
    override func viewDidLoad() {
        //If we have a value for email and password saved in the Keychain
        if KeychainWrapper.standard.hasValue(forKey: "email") && KeychainWrapper.standard.hasValue(forKey: "password") {
            
            guard let email = KeychainWrapper.standard.string(forKey: "email"), let password = KeychainWrapper.standard.string(forKey: "password") else {
                return
            }
            
            //Sign into Firebase
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if let err:Error = error {
                    print(err.localizedDescription)
                    return
                }
                //Set the email parameter and go to the Chat page
                self.email = KeychainWrapper.standard.string(forKey: "email")
                self.performSegue(withIdentifier: "LoginToChat", sender: self)
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ChatViewController {
            destinationVC.email = email
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if !emailField.hasText || !passwordField.hasText {
            let alert = UIAlertController(title: "Error", message: "Email or password has not been entered!", preferredStyle: .alert)
            let okayButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okayButton)
            present(alert, animated: true, completion: nil)
        } else {
            email = emailField.text
            password = passwordField.text
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if let err:Error = error {
                    print(err.localizedDescription)
                    return
                }
                KeychainWrapper.standard.set(self.email, forKey: "email")
                KeychainWrapper.standard.set(self.password, forKey: "password")
                self.performSegue(withIdentifier: "LoginToChat", sender: nil)
            })
        }
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) { }
}
        


