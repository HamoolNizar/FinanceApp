//
//  CompoundInterestSavingsController.swift
//  FinanceApp
//
//  Created by Hamool Nizar on 2/15/20.
//  Copyright © 2020 Hamool Nizar. All rights reserved.
//

import UIKit

enum CompoundInterestSavingsElements: Int {
    case presentValue, futureValue, interest, noOfYears, compoundsPerYear
}

class CompoundInterestSavingsController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var presentValueTxtFld: UITextField!
    @IBOutlet weak var futureValueTxtFld: UITextField!
    @IBOutlet weak var interestTxtFld: UITextField!
    @IBOutlet weak var noOfYearsTxtFld: UITextField!
    @IBOutlet weak var compoundsPerYearTxtFld: UITextField!
    @IBOutlet weak var customNumpad: CustomNumpad!
    
    var compoundInterestSavings = CompoundInterestSavingsModel(presentValue: nil, futureValue: nil, interest: nil, noOfYears: nil, compoundsPerYear: nil)
    var validate = Validation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        retrievePastStoredDate()
        setDefaultValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    /// This function sets up UITextFieldDelegates for the textfields.
    func setDelegates() {
        presentValueTxtFld.delegate = self
        futureValueTxtFld.delegate = self
        interestTxtFld.delegate = self
        noOfYearsTxtFld.delegate = self
        compoundsPerYearTxtFld.delegate = self
    }
    
    /// This function initializes the predefined values for the textfields.
    func setDefaultValues() {
        compoundInterestSavings.compoundsPerYear = 12.0
    }
    
    /// This function retreives the stored data from theuserdefaults.
    /// Then the retireved data will be assigned to the appropriate textfields.
    func retrievePastStoredDate() {
        compoundInterestSavings.retrieveCompoundInterestSavingsData()
        
        if let presentValue = compoundInterestSavings.presentValue {
            presentValueTxtFld.text = String(format: "%.2f",presentValue)
        }
        if let futureValue = compoundInterestSavings.futureValue {
            futureValueTxtFld.text = String(format: "%.2f",futureValue)
        }
        if let interest = compoundInterestSavings.interest {
            interestTxtFld.text = String(format: "%.2f",interest)
        }
        if let noOfYears = compoundInterestSavings.noOfYears {
            noOfYearsTxtFld.text = String(format: "%.2f",noOfYears)
        }
        if let compoundsPerYear = compoundInterestSavings.compoundsPerYear {
            compoundsPerYearTxtFld.text = String(format: "%.2f",compoundsPerYear)
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
    /// - Parameter sender: Present Value TextField.
    @IBAction func presentValueTxtFldChanged(_ sender: UITextField) {
        compoundInterestSavings.presentValue =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Future Value TextField.
    @IBAction func futureValueTxtFldChanged(_ sender: UITextField) {
        compoundInterestSavings.futureValue =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Interest TextField.
    @IBAction func interestTxtFldChanged(_ sender: UITextField) {
        compoundInterestSavings.interest =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Number of Years TextField.
    @IBAction func noOfYearsTxtFldChanged(_ sender: UITextField) {
        compoundInterestSavings.noOfYears =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Compounds perYear TextField.
    @IBAction func compoundsPerYearTxtFldChanged(_ sender: UITextField) {
        compoundInterestSavings.compoundsPerYear =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered when the button is being clicked.
    /// Inside this function we find the empty textfield and make calculation for the empty field.
    ///
    /// - Parameter sender: Calculate Button.
    @IBAction func calculateBtnHandler(_ sender: UIButton) {
        if (isCalculatable(numTxtFld: 5) == 1) {
            calculateTargetElement(targetElement: findTargetElement())
            
        } else if (isCalculatable(numTxtFld: 5) == 0){
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
        
        if compoundInterestSavings.presentValue != nil {
            numEmptyTxtFld -= 1
        }
        if compoundInterestSavings.futureValue != nil {
            numEmptyTxtFld -= 1
        }
        if compoundInterestSavings.interest != nil {
            numEmptyTxtFld -= 1
        }
        if compoundInterestSavings.noOfYears != nil {
            numEmptyTxtFld -= 1
        }
        if compoundInterestSavings.compoundsPerYear != nil {
            numEmptyTxtFld -= 1
        }
        
        return numEmptyTxtFld
    }
    
    /// This function will find out which textfield is empty in the application
    ///
    /// - Returns: Integer value for the target element.
    func findTargetElement() -> Int {
        var foundElement: Int = 0
        
        if compoundInterestSavings.presentValue == nil {
            foundElement = 0
        } else if
            compoundInterestSavings.futureValue == nil {
            foundElement = 1
        } else if
            compoundInterestSavings.interest == nil {
            foundElement = 2
        } else if
            compoundInterestSavings.noOfYears == nil {
            foundElement = 3
        } else if
            compoundInterestSavings.compoundsPerYear == nil {
            foundElement = 4
        }
        
        return foundElement
    }
    
    /// This function handles the calculation of the textfield elements
    /// Inside this function using a switch case will determine whci
    ///
    /// - Parameter targetElement: The integer value of the empty textfield.
    func calculateTargetElement(targetElement: Int) {
        
        switch CompoundInterestSavingsElements(rawValue: targetElement)! {
        case .presentValue:
            let presentValue: Double = compoundInterestSavings.calculatePresentValue()
            
            presentValueTxtFld.text = String(format: "%.2f",presentValue)
            compoundInterestSavings.presentValue = presentValue
            
            print("Calcuated Present Value : " + String(presentValue))
            
        case .futureValue:
            let futureValue: Double = compoundInterestSavings.calculateFutureValue()
            
            futureValueTxtFld.text = String(format: "%.2f",futureValue)
            compoundInterestSavings.futureValue = futureValue
            
            print("Calculated Future Value : " + String(futureValue))
            
        case .interest:
            let interest: Double = compoundInterestSavings.calculateInterest()
            
            interestTxtFld.text = String(format: "%.2f",interest)
            compoundInterestSavings.interest = interest
            
            print("Calcuated Interest : " + String(interest))
            
        case .noOfYears:
            let noOfYears: Double = compoundInterestSavings.calculateNoOfYears()
            
            noOfYearsTxtFld.text = String(format: "%.2f",noOfYears)
            compoundInterestSavings.noOfYears = noOfYears
            
            print("Calculated Number Of Years : " + String(noOfYears))
            
        case .compoundsPerYear:
            let compoundsPerYear: Double = compoundInterestSavings.calculateCompoundsPerYear()
            
            compoundsPerYearTxtFld.text = String(format: "%.2f",compoundsPerYear)
            compoundInterestSavings.compoundsPerYear = compoundsPerYear
            
            print("Calculated Compounds per Year : " + String(compoundsPerYear))
        }
        compoundInterestSavings.storeCompoundInterestSavingsData()
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
        
        presentValueTxtFld.text = String("")
        compoundInterestSavings.presentValue = nil
        futureValueTxtFld.text = String("")
        compoundInterestSavings.futureValue = nil
        interestTxtFld.text = String("")
        compoundInterestSavings.interest = nil
        noOfYearsTxtFld.text = String("")
        compoundInterestSavings.noOfYears = nil
        compoundsPerYearTxtFld.text = String("12")
        compoundInterestSavings.compoundsPerYear = 12
    }
    
}

