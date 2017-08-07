//
//  ChatViewController.swift
//  ios-firebase-chat
//
//  Created by Devan Allara on 7/17/17.
//  Copyright © 2017 Devan Allara. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatText: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    var currentUserName: String!
    var messages = [message]() {
        didSet {
            tableView.reloadData()
            tableView.scrollToRow(at: IndexPath.init(row: messages.count - 1, section: 0), at: .bottom, animated: true)
    }
}
    
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.layer.cornerRadius = 4
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        chatText.layer.cornerRadius = 5
        let ref = FIRDatabase.database().reference(withPath: "messages")
        FIRAuth.auth()?.signInAnonymously(completion: { (User, Error) in
            
        })
        ref.observe(.childAdded) { (snapshot) in
            let name = snapshot.childSnapshot(forPath: "name").value as! String
            let text = snapshot.childSnapshot(forPath: "text").value as! String
            let newMessage = message(sender: name, message: text)
            self.messages.append(newMessage)
            }
            
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messages[indexPath.row].sender == currentUserName {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageChatCell") as! MyMessageTableViewCell
            cell.setUpCell(message: messages[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatTableViewCell
            cell.setUpCell(message: messages[indexPath.row])
            return cell
        }
    }
    
    
    @IBAction func sendPressed(_ sender: Any) {
        let newMessage: [String: String] = [
              "name": currentUserName,
              "text": self.chatText.text
                ]
        chatText.text = ""
        
        
        let ref = FIRDatabase.database().reference(withPath: "messages")
        ref.childByAutoId().updateChildValues(newMessage)
        
    }
        
}

