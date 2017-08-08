//
//  Message.swift
//  ios-firebase-chat
//
//  Created by Devan Allara on 7/17/17.
//  Copyright © 2017 Devan Allara. All rights reserved.
//

import Foundation

//Data model for a message, containing parameters for a sender and the message text
class Message {
    var sender: String
    var text: String
    
    init(sender: String, text: String) {
        self.sender = sender
        self.text = text
    }
}
