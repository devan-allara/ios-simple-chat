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
    
    //References to UI elements
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //Variables to store the user's email and password
    var email: String!
    var password: String!
    
    override func viewDidLoad() {
        //Check to make sure the saved email and password aren't nil
        guard let email = KeychainWrapper.standard.string(forKey: "email"), let password = KeychainWrapper.standard.string(forKey: "password") else {
            return
        }
        
        //Attempt to sign into Firebase with the email and password
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let err:Error = error {
                //Display an error alert
                let alert = createSimpleActionSheetAlert(title: "Error", message: err.localizedDescription, dismissButtonTitle: "Okay")
                self.present(alert, animated: true, completion: nil)
                return
            }
            //Set the email parameter and go to the Chat page
            self.email = KeychainWrapper.standard.string(forKey: "email")
            self.performSegue(withIdentifier: "LoginToChat", sender: self)
        })
    }
    
    //When preparing to segue to the ChatViewController, set the email parameter in that view controller with the value of the email variable
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ChatViewController {
            destinationVC.email = email
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        //Check to see if either of the fields don't have text entered
        if !emailField.hasText || !passwordField.hasText {
            //Display an error alert
            let alert = createSimpleActionSheetAlert(title: "Error", message: "Email or password has not been entered.", dismissButtonTitle: "Okay")
            present(alert, animated: true, completion: nil)
            return
        } else {
            //Set the email and password variables with the values from the fields
            email = emailField.text
            password = passwordField.text
            
            //Attempt to sign into Firebase with the email and password
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if let err:Error = error {
                    //Display an error alert
                    let alert = createSimpleActionSheetAlert(title: "Error", message: err.localizedDescription, dismissButtonTitle: "Okay")
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                //Save the email and password to the Keychain and segue to the Chat screen
                KeychainWrapper.standard.set(self.email, forKey: "email")
                KeychainWrapper.standard.set(self.password, forKey: "password")
                self.performSegue(withIdentifier: "LoginToChat", sender: nil)
            })
        }
    }
    
    //Allows other view controllers to unwind to this view controller
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) { }
}
        


