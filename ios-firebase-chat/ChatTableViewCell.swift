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
    @IBOutlet weak var mesageLabel: UILabel!
    
    
    
    
    func setUpCell(message: message) {
        mesageLabel.layer.cornerRadius = 8
        mesageLabel.layer.masksToBounds = true
        userLabel.text = message.sender
        userLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        mesageLabel.text = "  \(message.message)"
        mesageLabel.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        mesageLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        mesageLabel.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        mesageLabel.numberOfLines = 0
        
        
    }
}

