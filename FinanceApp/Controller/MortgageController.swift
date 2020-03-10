//
//  MortgageController.swift
//  FinanceApp
//
//  Created by Hamool Nizar on 2/16/20.
//  Copyright © 2020 Hamool Nizar. All rights reserved.
//

import Foundation
import UIKit

enum MortgageElements: Int {
    case mortgageAmount, interest, payment, noOfYears
}

class MortgageController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var mortgageAmountTxtFld: UITextField!
    @IBOutlet weak var interestTxtFld: UITextField!
    @IBOutlet weak var paymentTxtFld: UITextField!
    @IBOutlet weak var noOfYearsTxtFld: UITextField!
    @IBOutlet weak var customNumpad: CustomNumpad!
    
    var mortgage = MortgageModel(mortgageAmount: nil, interest: nil, payement: nil, noOfYears: nil)
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
        mortgageAmountTxtFld.delegate = self
        interestTxtFld.delegate = self
        paymentTxtFld.delegate = self
        noOfYearsTxtFld.delegate = self
    }
    
    /// This function retreives the stored data from theuserdefaults.
    /// Then the retireved data will be assigned to the appropriate textfields.
    func retrievePastStoredDate() {
        mortgage.retrieveMortgageData()
        
        if let mortgageAmount = mortgage.mortgageAmount {
            mortgageAmountTxtFld.text = String(format: "%.2f",mortgageAmount)
        }
        if let interest = mortgage.interest {
            interestTxtFld.text = String(format: "%.2f",interest)
        }
        if let payment = mortgage.payment {
            paymentTxtFld.text = String(format: "%.2f",payment)
        }
        if let noOfYears = mortgage.noOfYears {
            noOfYearsTxtFld.text = String(format: "%.2f",noOfYears)
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
    /// - Parameter sender: Mortgage Amount TextField.
    @IBAction func mortgageAmountTxtFldChanged(_ sender: UITextField) {
        mortgage.mortgageAmount =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Interest TextField.
    @IBAction func interestTxtFldChanged(_ sender: UITextField) {
        mortgage.interest =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Payment TextField.
    @IBAction func paymentTxtFldChanged(_ sender: UITextField) {
        mortgage.payment =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Number of Years TextField.
    @IBAction func noOfYearsTxtFldChanged(_ sender: UITextField) {
        mortgage.noOfYears =  getTextFieldValue(sender)
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
            displayAlert(title: "Warning !", message: "The double value inputted to the text fields should be greater than 0")
            return nil
        } else if (validator == 2) {
            // TextField is Empty
            return nil
        } else {
            displayAlert(title: "Error: Invalid Input !", message: "The text fields only accept numeric double values and any other character values should not be inputted in to the text fields")
            return nil
        }
    }
    
    /// This function figures out whether it is possible make calculations by examing the textfields.
    ///
    /// - Parameter numTxtFld: int.
    /// - Returns: integer value of number of empty fields.
    func isCalculatable(numTxtFld: Int) -> Int {
        var numEmptyTxtFld: Int = numTxtFld
        
        if mortgage.mortgageAmount != nil {
            numEmptyTxtFld -= 1
        }
        if mortgage.interest != nil {
            numEmptyTxtFld -= 1
        }
        if mortgage.payment != nil {
            numEmptyTxtFld -= 1
        }
        if mortgage.noOfYears != nil {
            numEmptyTxtFld -= 1
        }
        
        return numEmptyTxtFld
    }
    
    /// This function will find out which textfield is empty in the application
    ///
    /// - Returns: Integer value for the target element.
    func findTargetElement() -> Int {
        var foundElement: Int = 0
        
        if mortgage.mortgageAmount == nil {
            foundElement = 0
        } else if
            mortgage.interest == nil {
            foundElement = 1
        } else if
            mortgage.payment == nil {
            foundElement = 2
        } else if
            mortgage.noOfYears == nil {
            foundElement = 3
        }
        
        return foundElement
    }
    
    /// This function handles the calculation of the textfield elements
    /// Inside this function using a switch case will determine whci
    ///
    /// - Parameter targetElement: The integer value of the empty textfield.
    func calculateTargetElement(targetElement: Int) {
        
        switch MortgageElements(rawValue: targetElement)! {
        case .mortgageAmount:
            let mortgageAmount: Double = mortgage.calculateMortgageAmount()
            
            mortgageAmountTxtFld.text = String(format: "%.2f",mortgageAmount)
            mortgage.mortgageAmount = mortgageAmount
            
            print("Calcuated Mortgage Amount : " + String(mortgageAmount))
            
        case .interest:
            let interest: Double = mortgage.calculateInterest()
            
            interestTxtFld.text = String(format: "%.2f",interest)
            mortgage.interest = interest
            
            print("Calcuated Interest : " + String(interest))
            
        case .payment:
            let payment: Double = mortgage.calculatePayment()
            
            paymentTxtFld.text = String(format: "%.2f",payment)
            mortgage.payment = payment
            
            print("Calculated Payment : " + String(payment))
            
        case .noOfYears:
            let noOfYears: Double = mortgage.calculateNoOfYears()
            
            noOfYearsTxtFld.text = String(format: "%.2f",noOfYears)
            mortgage.noOfYears = noOfYears
            
            print("Calculated Number Of Years : " + String(noOfYears))
        }
        mortgage.storeMortgageData()
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
        
        mortgageAmountTxtFld.text = String("")
        mortgage.mortgageAmount = nil
        interestTxtFld.text = String("")
        mortgage.interest = nil
        paymentTxtFld.text = String("")
        mortgage.payment = nil
        noOfYearsTxtFld.text = String("")
        mortgage.noOfYears = nil
        
    }
    
}
