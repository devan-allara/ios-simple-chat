//
//  ChatTableViewCell.swift
//  ios-firebase-chat
//
//  Created by Devan Allara on 7/19/17.
//  Copyright © 2017 Devan Allara. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    //References to UI elements
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var textBubbleView: UIView!
    
    //Function that sets up the cell UI elements 
    func setUpCell(withMessage message: Message, fromCurrentUser: Bool) {
        
        userLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        messageLabel.text = "\(message.text)"
        textBubbleView.layer.cornerRadius = 8
        textBubbleView.layer.masksToBounds = true
        
        //If the message is from the current logged in user, the cell will be colored differently and the user label will say "Me"
        if fromCurrentUser {
            userLabel.text = "Me"
            messageLabel.textColor = UIColor.black
            textBubbleView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            userLabel.text = message.sender
            messageLabel.textColor = UIColor.white
            textBubbleView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }
    }
}

