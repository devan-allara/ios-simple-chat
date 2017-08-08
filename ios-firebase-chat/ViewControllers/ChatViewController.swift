//
//  ChatViewController.swift
//  ios-firebase-chat
//
//  Created by Devan Allara on 7/17/17.
//  Copyright © 2017 Devan Allara. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatText: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    var ref: FIRDatabaseReference!
    
    var currentUserName: String!
    
    var messages = [Message]() {
        didSet {
            tableView.reloadData()
            
            //Scroll to the bottom of the tableview
            tableView.scrollToRow(at: IndexPath.init(row: messages.count - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Round the send button's corners
        sendButton.layer.cornerRadius = 4
        
        //Remove the separators between table view rows
        tableView.separatorStyle = .none
        
        //Set the table view row height to be dynamic
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Shows setting delegate and datasource through code instead of through storyboard
        tableView.delegate = self
        tableView.dataSource = self
        
        //Round the chat text field's corners
        chatText.layer.cornerRadius = 5
        
        let ref = FIRDatabase.database().reference(withPath: "messages")
        ref.observe(.childAdded) { (snapshot) in
            let name = snapshot.childSnapshot(forPath: "name").value as! String
            let text = snapshot.childSnapshot(forPath: "text").value as! String
            let newMessage = Message(sender: name, text: text)
            self.messages.append(newMessage)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatTableViewCell
        
        var sentByCurrentUser: Bool
        
        messages[indexPath.row].sender == currentUserName ? (sentByCurrentUser = true) : (sentByCurrentUser = false)
        
        cell.setUpCell(withMessage: messages[indexPath.row], fromCurrentUser: sentByCurrentUser)
        
        return cell
    }
    
    @IBAction func sendTapped(_ sender: Any) {
        
        //Make sure the user has actually entered in some text
        if chatText.text == "" {
            return
        }
        
        //Create a new message with the user's current username and the text in the chatText field
        let newMessage: [String: String] = [
              "name": currentUserName,
              "text": self.chatText.text
                ]
        
        //Clear out the text from the text field
        chatText.text = ""
        
        //Add the message as a new child value in Firebase
        let ref = FIRDatabase.database().reference(withPath: "messages")
        ref.childByAutoId().updateChildValues(newMessage)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        //Remove the saved username from the Keychain, and unwind to the login screen
        KeychainWrapper.standard.removeObject(forKey: "username")
        self.performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
}

