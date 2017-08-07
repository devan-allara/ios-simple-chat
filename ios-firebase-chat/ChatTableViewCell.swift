//
//  ChatTableViewCell.swift
//  ios-firebase-chat
//
//  Created by Devan Allara on 7/19/17.
//  Copyright © 2017 Devan Allara. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    func setUpCell(message: message) {
        userLabel.text = message.sender
        userLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        messageLabel.layer.cornerRadius = 8
        messageLabel.layer.masksToBounds = true
        messageLabel.text = "\(message.message)"
        messageLabel.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        messageLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        messageLabel.numberOfLines = 0
    }
}

