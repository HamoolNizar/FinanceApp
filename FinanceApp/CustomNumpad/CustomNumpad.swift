//
//  CustomNumpad.swift
//  FinanceApp
//
//  Created by Hamool Nizar on 2/17/20.
//  Copyright © 2020 Hamool Nizar. All rights reserved.
//

import UIKit

class CustomNumpad: UIView {
    
    
    
    let nibName = "CustomNumpad"
    var contentView:UIView?
    
    /// Constructor
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    /// This function loads the custom numpad view
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    

    var activeTextField = UITextField()
    
    /// This function handles all the numeric buttons in the custom numpad.
    @IBAction func numberBtnHandler(_ sender: UIButton) {
        let cursorPosition = getCursorPosition()
        
        activeTextField.insertText(String(sender.tag))
        setCursorPosition(from: cursorPosition)
        
//        print("numberBtnHandler " + String(sender.tag))
    }
    
    /// This function handles the delete button in the custom numpad.
    @IBAction func deleteBtnHandler(_ sender: UIButton) {
        let cursorPosition = getCursorPosition()
        
        if let currentText = self.activeTextField.text {
            if currentText.count != 0 {
                self.activeTextField.text?.remove(at: currentText.index(currentText.startIndex, offsetBy: cursorPosition - 1))
                if String(currentText[currentText.index(currentText.startIndex, offsetBy: cursorPosition - 1)]) != "." {
                    activeTextField.sendActions(for: UIControl.Event.editingChanged)
                }
                setCursorPosition(from: cursorPosition, offset: -1)
            }
        }
        
//        print("deleteBtnHandler")
    }
    
    /// This function handles the period button in the custom numpad.
    @IBAction func periodBtnHandler(_ sender: UIButton) {
        let cursorPosition = getCursorPosition()
        
        if let currentText = self.activeTextField.text {
            if !currentText.contains("."), currentText.count != 0 {
                activeTextField.insertText(".")
                setCursorPosition(from: cursorPosition)
            }
        }
        
    }
    
    /// This function gets the current position of the cursor in the textfield.
    func getCursorPosition() -> Int {
        guard let selectedRange = activeTextField.selectedTextRange else {return 0}
        return activeTextField.offset(from: activeTextField.beginningOfDocument, to: selectedRange.start)
    }
    
    /// This function sets up the cursor position in the textfield.
    func setCursorPosition(from:Int, offset: Int = 1) {
        if let newPosition = activeTextField.position(from: activeTextField.beginningOfDocument, offset: from + offset) {
            activeTextField.selectedTextRange = activeTextField.textRange(from: newPosition, to: newPosition)
        }
    }
}
