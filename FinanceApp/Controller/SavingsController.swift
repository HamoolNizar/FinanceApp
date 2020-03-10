//
//  SavingsController.swift
//  FinanceApp
//
//  Created by Hamool Nizar on 2/16/20.
//  Copyright © 2020 Hamool Nizar. All rights reserved.
//

import Foundation
import UIKit

enum SavingsElements: Int {
    case principalAmount, interest, payment, compoundsPerYear, paymentsPerYear, futureValue, noOfYears, paymentPeriod
}

class SavingsController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var principalAmountTxtFld: UITextField!
    @IBOutlet weak var interestTxtFld: UITextField!
    @IBOutlet weak var paymentTxtFld: UITextField!
    @IBOutlet weak var compoundsPerYearTxtFld: UITextField!
    @IBOutlet weak var paymentsPerYearTxtFld: UITextField!
    @IBOutlet weak var futureValueTxtFld: UITextField!
    @IBOutlet weak var noOfYearsTxtFld: UITextField!
    @IBOutlet weak var paymentPeriodSwitch: UISwitch!
    @IBOutlet weak var paymentPeriodLbl: UILabel!
    @IBOutlet weak var customNumpad: CustomNumpad!
    
    var savings =  SavingsModel(principalAmount: nil, interest: nil, payement: nil, compoundsPerYear: nil, paymentsPerYear: nil, futureValue: nil, noOfYears: nil, paymentPeriod: nil)
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
        principalAmountTxtFld.delegate = self
        interestTxtFld.delegate = self
        paymentTxtFld.delegate = self
        compoundsPerYearTxtFld.delegate = self
        paymentsPerYearTxtFld.delegate = self
        futureValueTxtFld.delegate = self
        noOfYearsTxtFld.delegate = self
    }
    
    /// This function initializes the predefined values for the textfields.
    func setDefaultValues() {
        savings.compoundsPerYear = 12.0
        savings.paymentsPerYear = 12.0
        savings.paymentPeriod = 1.0
    }
    
    /// This function retreives the stored data from theuserdefaults.
    /// Then the retireved data will be assigned to the appropriate textfields.
    func retrievePastStoredDate() {
        savings.retrieveSavingsData()
        
        if let principalAmount = savings.principalAmount {
            principalAmountTxtFld.text = String(format: "%.2f",principalAmount)
        }
        if let interest = savings.interest {
            interestTxtFld.text = String(format: "%.2f",interest)
        }
        if let payment = savings.payment {
            paymentTxtFld.text = String(format: "%.2f",payment)
        }
        if let compoundsPerYear = savings.compoundsPerYear {
            compoundsPerYearTxtFld.text = String(format: "%.2f",compoundsPerYear)
        }
        if let paymentsPerYear = savings.paymentsPerYear {
            paymentsPerYearTxtFld.text = String(format: "%.2f",paymentsPerYear)
        }
        if let futureValue = savings.futureValue {
            futureValueTxtFld.text = String(format: "%.2f",futureValue)
        }
        if let noOfYears = savings.noOfYears {
            noOfYearsTxtFld.text = String(format: "%.2f",noOfYears)
        }
        if let paymentPeriod = savings.paymentPeriod {
            if (paymentPeriod == 1.0) {
                paymentPeriodSwitch.setOn(true, animated: true)
                paymentPeriodLbl.text = "End"
                savings.paymentPeriod = 1.0
            } else {
                paymentPeriodSwitch.setOn(false, animated: true)
                paymentPeriodLbl.text = "Beginning"
                savings.paymentPeriod = 0.0
            }
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
    /// - Parameter sender: Principal Amount TextField.
    @IBAction func principalAmountTxtFldChanged(_ sender: UITextField) {
        savings.principalAmount =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Interest TextField.
    @IBAction func interestTxtFldChanged(_ sender: UITextField) {
        savings.interest =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Payment TextField.
    @IBAction func paymentTxtFldChanged(_ sender: UITextField) {
        savings.payment =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Compounds per Year TextField.
    @IBAction func compoundsPerYearTxtFldChanged(_ sender: UITextField) {
        savings.compoundsPerYear =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Payments per Year TextField.
    @IBAction func paymentsPerYearTxtFldChanged(_ sender: UITextField) {
        savings.paymentsPerYear =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Future Value TextField.
    @IBAction func futureValueTxtFldChanged(_ sender: UITextField) {
        savings.futureValue =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Number of Years TextField.
    @IBAction func noOfYearsTxtFldChanged(_ sender: UITextField) {
        savings.noOfYears =  getTextFieldValue(sender)
    }
    
    /// This function gets triggered each time this  textfield is being edited.
    /// Inside this function we get the value from the textfield and assign it to the relavant object parameter.
    ///
    /// - Parameter sender: Payment Period UISwitch.
    @IBAction func paymentPeriodSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            paymentPeriodLbl.text = "End"
            savings.paymentPeriod = 1.0
        } else {
            paymentPeriodLbl.text = "Beginning"
            savings.paymentPeriod = 0.0
        }
    }
    
    /// This function gets triggered when the button is being clicked.
    /// Inside this function we find the empty textfield and make calculation for the empty field.
    ///
    /// - Parameter sender: Calculate Button.
    @IBAction func calculateBtnHandler(_ sender: UIButton) {
        if (isCalculatable(numTxtFld: 7) == 1) {
            calculateTargetElement(targetElement: findTargetElement())
            
        } else if (isCalculatable(numTxtFld: 7) == 0){
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
        
        if savings.principalAmount != nil {
            numEmptyTxtFld -= 1
        }
        if savings.interest != nil {
            numEmptyTxtFld -= 1
        }
        if savings.payment != nil {
            numEmptyTxtFld -= 1
        }
        if savings.compoundsPerYear != nil {
            numEmptyTxtFld -= 1
        }
        if savings.paymentsPerYear != nil {
            numEmptyTxtFld -= 1
        }
        if savings.futureValue != nil {
            numEmptyTxtFld -= 1
        }
        if savings.noOfYears != nil {
            numEmptyTxtFld -= 1
        }
        
        return numEmptyTxtFld
    }
    
    /// This function will find out which textfield is empty in the application
    ///
    /// - Returns: Integer value for the target element.
    func findTargetElement() -> Int {
        var foundElement: Int = 0
        
        if savings.principalAmount == nil {
            foundElement = 0
        } else if
            savings.interest == nil {
            foundElement = 1
        } else if
            savings.payment == nil {
            foundElement = 2
        } else if
            savings.compoundsPerYear == nil {
            foundElement = 3
        } else if
            savings.paymentsPerYear == nil {
            foundElement = 4
        } else if
            savings.futureValue == nil {
            foundElement = 5
        } else if
            savings.noOfYears == nil {
            foundElement = 6
        }
        
        return foundElement
    }
    
    /// This function handles the calculation of the textfield elements
    /// Inside this function using a switch case will determine whci
    ///
    /// - Parameter targetElement: The integer value of the empty textfield.
    func calculateTargetElement(targetElement: Int) {
        
        switch SavingsElements(rawValue: targetElement)! {
        case .principalAmount:
            let principalAmount: Double = savings.calculatePrincipalAmount()
            
            principalAmountTxtFld.text = String(format: "%.2f",principalAmount)
            savings.principalAmount = principalAmount
            
            print("Calcuated Principal Amount : " + String(principalAmount))
            
        case .interest:
            let interest: Double = savings.calculateInterest()
            
            interestTxtFld.text = String(format: "%.2f",interest)
            savings.interest = interest
            
            print("Calcuated Interest : " + String(interest))
            displayAlert(title: "Warning !", message: "The calculated value of the interest may not be accurate due to the complexity of the interest calculation")
            
        case .payment:
            let payment: Double = savings.calculatePayment()
            
            paymentTxtFld.text = String(format: "%.2f",payment)
            savings.payment = payment
            
            print("Calculated Payment : " + String(payment))
            
        case .compoundsPerYear:
            let compoundsPerYear: Double = savings.calculateCompoundsPerYear()
            
            compoundsPerYearTxtFld.text = String(format: "%.2f",compoundsPerYear)
            savings.compoundsPerYear = compoundsPerYear
            
            print("Calculated Compounds Per Year : " + String(compoundsPerYear))
            
        case .paymentsPerYear:
            let paymentsPerYear: Double = savings.calculatePaymentsPerYear()
            
            paymentsPerYearTxtFld.text = String(format: "%.2f",paymentsPerYear)
            savings.paymentsPerYear = paymentsPerYear
            
            print("Calculated Payment Per Year : " + String(paymentsPerYear))
            
        case .futureValue:
            let futureValue: Double = savings.calculateFutureValue()
            
            futureValueTxtFld.text = String(format: "%.2f",futureValue)
            savings.futureValue = futureValue
            
            print("Calculated Future Value : " + String(futureValue))
            
        case .noOfYears:
            let noOfYears: Double = savings.calculateNoOfYears()
            
            noOfYearsTxtFld.text = String(format: "%.2f",noOfYears)
            savings.noOfYears = noOfYears
            
            print("Calculated Number Of Years : " + String(noOfYears))
            
        case .paymentPeriod:
            let paymentPeriod: Double = savings.calculatePaymentPeriod()
            
            //                    noOfYearsTxtFld.text = String(format: "%.2f",noOfYears)
            savings.paymentPeriod = paymentPeriod
            
            print("Calculated Payment Period : " + String(paymentPeriod))
        }
        savings.storeSavingsData()
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
        
        principalAmountTxtFld.text = String("")
        savings.principalAmount = nil
        interestTxtFld.text = String("")
        savings.interest = nil
        paymentTxtFld.text = String("")
        savings.payment = nil
        compoundsPerYearTxtFld.text = String("12")
        savings.compoundsPerYear = 12
        paymentsPerYearTxtFld.text = String("12")
        savings.paymentsPerYear = 12
        futureValueTxtFld.text = String("")
        savings.futureValue = nil
        noOfYearsTxtFld.text = String("")
        savings.noOfYears = nil
        paymentPeriodSwitch.setOn(true, animated: true)
        paymentPeriodLbl.text = "End"
        savings.paymentPeriod = 1.0
    }
    
}
