//
//  LoanController.swift
//  FinanceApp
//
//  Created by Hamool Nizar on 2/16/20.
//  Copyright © 2020 Hamool Nizar. All rights reserved.
//

import Foundation
import UIKit

enum LoanElements: Int {
    case loanAmount, interest, payment, noOfPayments
}

class LoanController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var loanAmountTxtFld: UITextField!
    @IBOutlet weak var interestTxtFld: UITextField!
    @IBOutlet weak var paymentTxtFld: UITextField!
    @IBOutlet weak var noOfPaymentsTxtFld: UITextField!
    @IBOutlet weak var customNumpad: CustomNumpad!
    
    var loan = LoanModel(loanAmount: nil, interest: nil, payement: nil, noOfPayments: nil)
    var validate = Validation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        retrievePastStoredDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    /// This function sets up UITextFieldDelegates for the textfields.
    func setDelegates() {
        loanAmountTxtFld.delegate = self
        interestTxtFld.delegate = self
        paymentTxtFld.delegate = self
        noOfPaymentsTxtFld.delegate = self
    }
    
    /// This function retreives the stored data from theuserdefaults.
    /// Then the retireved data will be assigned to the appropriate textfields.
    func retrievePastStoredDate() {
        loan.retrieveLoanData()
        
        if let loanAmount = loan.loanAmount {
            loanAmountTxtFld.text = String(format: "%.2f",loanAmount)
        }
        if let interest = loan.interest {
            interestTxtFld.text = String(format: "%.2f",interest)
        }
        if let payment = loan.payment {
            paymentTxtFld.text = String(format: "%.2f",payment)
        }
        if let noOfPayments = loan.noOfPayments {
            noOfPaymentsTxtFld.text = String(format: "%.2f",noOfPayments)
        }
    }
    
    /// This function handles when the textfield begins editing.
    /// In this function the currently active textfield will be assinged to the customNumpad textfield.
    ///
    /// - Parameter textField: TextField.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customNumpad.activeTextField = textField
        textField.inputView = UIView()
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Loan Amount TextField.
    @IBAction func loanAmountTxtFldChanged(_ sender: UITextField) {
        loan.loanAmount =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Interest TextField.
    @IBAction func interestTxtFldChanged(_ sender: UITextField) {
        loan.interest =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Payment TextField.
    @IBAction func paymentTxtFldChanged(_ sender: UITextField) {
        loan.payment =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Number of Payment TextField.
    @IBAction func noOfPaymentsTxtFldChanged(_ sender: UITextField) {
        loan.noOfPayments =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered when the button is being clicked.
    /// Inside this function we find the empty textfield and make calculation for the empty field.
    ///
    /// - Parameter sender: Calculate Button.
    @IBAction func calculateBtnHandler(_ sender: UIButton) {
        if (isCalculatable(numTxtFld: 4) == 1) {
            calculateTargetElement(targetElement: findTargetElement())
            
        } else if (isCalculatable(numTxtFld: 4) == 0){
            clearAllTextFields()
            
        } else {
            print("More than one text field is empty ! ")
            displayAlert(title: "Multiple TextFields Unfilled !", message: "The number of fields left out blank are more than one and only one TextField is allowed to be empty ")
        }
    }
    
    /// This function gets the textfield and extract the content from the textfield and validate the content.
    ///
    /// - Parameter sender: TextField.
    /// - Returns: Double value from the TextField
    func getTextFieldValue(_ sender: UITextField) -> Double? {
        guard let txtFldContent = sender.text else { return nil }
        
        let validator = validate.validateTxtFld(content: txtFldContent)
        
        if (validator == 0) {
            guard let txtFldContentDouble = Double(txtFldContent) else { return nil}
            
            print("Value " + String(txtFldContentDouble))
            return txtFldContentDouble
        } else if (validator == 1) {
            displayAlert(title: "Invalid Input !", message: "The double value inputted to the text fields should be greater than 0")
            return nil
        } else if (validator == 2) {
            // TextField is Empty
            return nil
        } else {
            displayAlert(title: "Invalid Input !", message: "The text fields only accept numeric double values and any other character values should not be inputted in to the text fields")
            return nil
        }
    }
    
    /// This function figures out whether it is possible make calculations by examing the textfields.
    ///
    /// - Parameter numTxtFld: int.
    /// - Returns: integer value of number of empty fields.
    func isCalculatable(numTxtFld: Int) -> Int {
        var numEmptyTxtFld: Int = numTxtFld
        
        if loan.loanAmount != nil {
            numEmptyTxtFld -= 1
        }
        if loan.interest != nil {
            numEmptyTxtFld -= 1
        }
        if loan.payment != nil {
            numEmptyTxtFld -= 1
        }
        if loan.noOfPayments != nil {
            numEmptyTxtFld -= 1
        }
        
        return numEmptyTxtFld
    }
    
    /// This function will find out which textfield is empty in the application
    ///
    /// - Returns: Integer value for the target element.
    func findTargetElement() -> Int {
        var foundElement: Int = 0
        
        if loan.loanAmount == nil {
            foundElement = 0
        } else if
            loan.interest == nil {
            foundElement = 1
        } else if
            loan.payment == nil {
            foundElement = 2
        } else if
            loan.noOfPayments == nil {
            foundElement = 3
        }
        
        return foundElement
    }
    
    /// This function handles the calculation of the textfield elements
    /// Inside this function using a switch case will determine whci
    ///
    /// - Parameter targetElement: The integer value of the empty textfield.
    func calculateTargetElement(targetElement: Int) {
        
        switch LoanElements(rawValue: targetElement)! {
        case .loanAmount:
            let loanAmount: Double = loan.calculateLoanAmount()
            
            loanAmountTxtFld.text = String(format: "%.2f",loanAmount)
            loan.loanAmount = loanAmount
            
            print("Calcuated Loan Amount : " + String(loanAmount))
            
        case .interest:
            let interest: Double = loan.calculateInterest()
            
            interestTxtFld.text = String(format: "%.2f",interest)
            loan.interest = interest
            
            print("Calcuated Interest : " + String(interest))
            
        case .payment:
            let payment: Double = loan.calculatePayment()
            
            paymentTxtFld.text = String(format: "%.2f",payment)
            loan.payment = payment
            
            print("Calculated Payment : " + String(payment))
            
        case .noOfPayments:
            let noOfPayments: Double = loan.calculateNoOfPayments()
            
            noOfPaymentsTxtFld.text = String(format: "%.2f",noOfPayments)
            loan.noOfPayments = noOfPayments
            
            print("Calculated Number Of Payments : " + String(noOfPayments))
        }
        loan.storeLoanData()
    }
    
    /// This function will display alert in the applcation with appropriate messages
    ///
    /// - Parameter title: The tite of the alert.
    /// - Parameter message: The content of the alert.
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in}))
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// This function will reset all the textfields
    func clearAllTextFields() {
        
        loanAmountTxtFld.text = String("")
        loan.loanAmount = nil
        interestTxtFld.text = String("")
        loan.interest = nil
        paymentTxtFld.text = String("")
        loan.payment = nil
        noOfPaymentsTxtFld.text = String("")
        loan.noOfPayments = nil
        
    }
    
}
