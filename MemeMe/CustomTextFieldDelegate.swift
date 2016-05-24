//
//  CustomTextFieldDelegate.swift
//  MemeMe
//
//  Created by Kenan Ozdamar on 5/18/16.
//  Copyright © 2016 OKO Baycity. All rights reserved.
//

import Foundation
import UIKit

class CustomTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
}