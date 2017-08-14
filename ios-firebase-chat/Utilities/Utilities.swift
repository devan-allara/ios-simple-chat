//
//  Utilities.swift
//  ios-firebase-chat
//
//  Created by Ryan Brashear on 8/14/17.
//  Copyright © 2017 Devan Allara. All rights reserved.
//

import UIKit

public func createSimpleActionSheetAlert(title: String, message: String, dismissButtonTitle: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    let dismissButton = UIAlertAction(title: dismissButtonTitle, style: .default, handler: nil)
    alert.addAction(dismissButton)
    return alert
}
