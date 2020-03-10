//
//  Validation.swift
//  FinanceApp
//
//  Created by Hamool Nizar on 3/8/20.
//  Copyright © 2020 Hamool Nizar. All rights reserved.
//

import Foundation
import UIKit

class Validation {
    
    /// This function will validate the content of the given textfield.
    ///
    /// - Returns: type of the error occured / no error.
    func validateTxtFld(content: String) -> Int {
        var validator: Int = 0
        if let contentDouble = content.double  {
            if (contentDouble > 0) {
                validator = 0
                return validator
            } else {
                print("Invalid Input: Double value is less than 0")
                validator = 1
                return validator
            }
        } else if content == "" {
            print("Text Field is Empty")
            validator = 2
            return validator
        } else {
            print("Invalid Input: Not a valid Double value")
            validator = 3
            return validator
        }
    }

}
