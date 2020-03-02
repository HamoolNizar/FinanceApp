//
//  CustomNumpad.swift
//  FinanceApp
//
//  Created by Hamool Nizar on 2/17/20.
//  Copyright © 2020 Hamool Nizar. All rights reserved.
//

import UIKit

class CustomNumpad: UIView {
    
    // ======================== Loading to the view =================================
    
    let nibName = "CustomNumpad"
    var contentView:UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    // =================== Event handler for keyboard buttons ====================
    
    var activeTextField = UITextField()
    
    @IBAction func numberBtnHandler(_ sender: UIButton) {
        let cursorPosition = getCursorPosition()
        
        activeTextField.insertText(String(sender.tag))
        setCursorPosition(from: cursorPosition)
        
        print("numberBtnHandler " + String(sender.tag))
    }
    
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
        
        print("deleteBtnHandler")
    }
    
    @IBAction func periodBtnHandler(_ sender: UIButton) {
        let cursorPosition = getCursorPosition()
        
        if let currentText = self.activeTextField.text {
            if !currentText.contains("."), currentText.count != 0 {
                activeTextField.insertText(".")
                setCursorPosition(from: cursorPosition)
            }
        }
        
        print(".......")
    }
    
    func getCursorPosition() -> Int {
        guard let selectedRange = activeTextField.selectedTextRange else {return 0}
        return activeTextField.offset(from: activeTextField.beginningOfDocument, to: selectedRange.start)
    }
    
    func setCursorPosition(from:Int, offset: Int = 1) {
        if let newPosition = activeTextField.position(from: activeTextField.beginningOfDocument, offset: from + offset) {
            activeTextField.selectedTextRange = activeTextField.textRange(from: newPosition, to: newPosition)
        }
    }
}
