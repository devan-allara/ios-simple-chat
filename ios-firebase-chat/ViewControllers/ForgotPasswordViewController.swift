//
//  ForgotPasswordViewController.swift
//  ios-firebase-chat
//
//  Created by Ryan Brashear on 8/14/17.
//  Copyright © 2017 Devan Allara. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToLogin", sender: self)
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        
        guard let email = emailField.text, !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            //Display the error as an alert
            let alert = createSimpleActionSheetAlert(title: "Error", message: "Email has not been entered.", dismissButtonTitle: "Okay")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if let err:Error = error {
                //Display the error as an alert
                let alert = createSimpleActionSheetAlert(title: "Error", message: err.localizedDescription, dismissButtonTitle: "Okay")
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            //Create a specialized alert that will segue back to the login screen when the ok button is tapped
            let alert = UIAlertController(title: "Success", message: "Password reset email sent. Please check your email,", preferredStyle: .actionSheet)
            let dismissButton = UIAlertAction(title: "Okay", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "unwindToLogin", sender: self)
            })
            alert.addAction(dismissButton)
            self.present(alert, animated: true, completion: nil)
        })
    }
}
