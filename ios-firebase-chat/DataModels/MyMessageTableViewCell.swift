//
//  MyMessageTableViewCell.swift
//  ios-firebase-chat
//
//  Created by Devan Allara on 7/20/17.
//  Copyright © 2017 Devan Allara. All rights reserved.
//

import UIKit

class MyMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var messageText: UILabel!
    
    func setUpCell(message: message) {
        
        nameLabel.text = "Me"
        nameLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        messageText.layer.cornerRadius = 8
        messageText.layer.masksToBounds = true
        messageText.text = "\(message.message)"
        messageText.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        messageText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        messageText.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        messageText.numberOfLines = 0
    }
}
