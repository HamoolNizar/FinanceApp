//
//  UITextFieldExtension.swift
//  FinanceApp
//
//  Created by Hamool Nizar on 2/26/20.
//  Copyright © 2020 Hamool Nizar. All rights reserved.
//

import UIKit

//private var numpadProtocol: CustomNumpadProtocol? = nil
//
//extension UITextField: CustomNumpadProtocol {
//
//    func setNumpadToTxtFld(numpad: CustomNumpadProtocol?) {
//        let numpadKeyboard = CustomNumpad(frame: CGRect())
//        self.inputView = numpadKeyboard
//        numpadProtocol = numpad
//        numpadKeyboard.numpad = self
//        print("------setNumpadToTxtFld------")
//    }
//
//    func removeNumpadFromTxtFld() {
//        if let numpadKeyboard = self.inputView as? CustomNumpad {
//            numpadKeyboard.numpad = nil
//        }
//        self.inputView = nil
//        numpadProtocol = nil
//        print("------removeNumpadFromTxtFld------")
//    }
//
//    func numberBtnClicked(numKey: Int) {
//        self.insertText(String(numKey))
//        numpadProtocol?.numberBtnClicked(numKey: numKey)
//        print("------numberBtnClicked------")
//    }
//
//    func deleteBtnClicked() {
//        self.deleteBackward()
//        numpadProtocol?.deleteBtnClicked()
//        print("------deleteBtnClicked------")
//    }
//
//    func periodBtnClicked() {
//        self.insertText(String("."))
//        numpadProtocol?.periodBtnClicked()
//        print("------periodBtnClicked------")
//    }
//
//    
//}
