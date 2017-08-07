//
//  LoginViewController.swift
//  ios-firebase-chat
//
//  Created by Devan Allara on 7/17/17.
//  Copyright © 2017 Devan Allara. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func loginButton(_ sender: Any) {
        if !userNameField.hasText {
            var alert = UIAlertController(title: "Error", message: "Please Enter A Username!", preferredStyle: .alert)
            var okayButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okayButton)
            present(alert, animated: true, completion: nil)
        } else {
            FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
                if let err:Error = error {
                    print(err.localizedDescription)
                    return
                }
                
                self.performSegue(withIdentifier: "LoginToChat", sender: nil)
            })
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ChatViewController
        destinationVC.currentUserName = userNameField.text
        
    }
}
        


