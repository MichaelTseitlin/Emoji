//
//  EmojiTextField.swift
//  Emoji
//
//  Created by Michael Tseitlin on 6/12/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit

extension UITextField {
    
    open override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
}


