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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        retrievePastStoredDate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setDelegates() {
        mortgageAmountTxtFld.delegate = self
        interestTxtFld.delegate = self
        paymentTxtFld.delegate = self
        noOfYearsTxtFld.delegate = self
    }
    
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customNumpad.activeTextField = textField
    }
    
    @IBAction func mortgageAmountTxtFldChanged(_ sender: UITextField) {
        mortgage.mortgageAmount =  getTextFieldValue(sender)
    }
    
    @IBAction func interestTxtFldChanged(_ sender: UITextField) {
        mortgage.interest =  getTextFieldValue(sender)
    }
    
    @IBAction func paymentTxtFldChanged(_ sender: UITextField) {
        mortgage.payment =  getTextFieldValue(sender)
    }
    
    @IBAction func noOfYearsTxtFldChanged(_ sender: UITextField) {
        mortgage.noOfYears =  getTextFieldValue(sender)
    }
    
    @IBAction func calculateBtnHandler(_ sender: UIButton) {
        if (isCalculatable(numTxtFld: 4)) {
            calculateTargetElement(targetElement: findTargetElement())
        } else {
            print("FALSE")
            
//            let alert = UIAlertController(title: "Missing Fields", message: "You can only leave one field empty!", preferredStyle: .alert)
//            let done = UIAlertAction(title: "Ok", style: .default)
//            alert.addAction(done)
//            present(alert, animated: true, completion: nil)
        }
    }
    
    func getTextFieldValue(_ sender: UITextField) -> Double? {
        guard let txtFldContent = sender.text else { return nil }
        guard let txtFldContentDouble = Double(txtFldContent) else { return nil}
        
        print("Value " + String(txtFldContentDouble))
        return txtFldContentDouble
    }
    
    func isCalculatable(numTxtFld: Int) -> Bool {
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
        
        return numEmptyTxtFld == 1
    }
    
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
    
//    func calculateInterest() -> Double {
//        return (mortgage.interest! / 100) / 12
//    }
    
}
