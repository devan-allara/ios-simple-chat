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

    @IBOutlet weak var userNameField: UITextField!
    
    var username: String!
    
    override func viewDidLoad() {
        //If we have a value for username saved in the Keychain
        if KeychainWrapper.standard.hasValue(forKey: "username") {
            //Sign into Firebase anonymously
            FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
                if let err:Error = error {
                    print(err.localizedDescription)
                    return
                }
                //Set the username parameter and go to the Chat page
                self.username = KeychainWrapper.standard.string(forKey: "username")
                self.performSegue(withIdentifier: "LoginToChat", sender: self)
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ChatViewController
        destinationVC.currentUserName = username
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if !userNameField.hasText {
            let alert = UIAlertController(title: "Error", message: "Please Enter A Username!", preferredStyle: .alert)
            let okayButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okayButton)
            present(alert, animated: true, completion: nil)
        } else {
            username = userNameField.text
            FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
                if let err:Error = error {
                    print(err.localizedDescription)
                    return
                }
                KeychainWrapper.standard.set(self.username, forKey: "username")
                self.performSegue(withIdentifier: "LoginToChat", sender: nil)
            })
        }
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) { }
}
        


