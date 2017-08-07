//
//  Message.swift
//  ios-firebase-chat
//
//  Created by Devan Allara on 7/17/17.
//  Copyright © 2017 Devan Allara. All rights reserved.
//

import Foundation
class message {
    var sender: String
    var message: String
    
    init(sender: String, message: String) {
        self.sender = sender
        self.message = message
    }

}
