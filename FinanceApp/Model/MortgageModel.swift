//
//  MortgageModel.swift
//  FinanceApp
//
//  Created by Hamool Nizar on 2/28/20.
//  Copyright © 2020 Hamool Nizar. All rights reserved.
//

import Foundation

class MortgageModel {
    var mortgageAmount : Double?
    var interest : Double?
    var payment : Double?
    var noOfYears : Double?
    var interestCalculator = InterestRateCalculator()
    
    /// Constructor
    init(mortgageAmount:Double?, interest:Double?, payement:Double?, noOfYears:Double?) {
        self.mortgageAmount = mortgageAmount
        self.interest = interest
        self.payment = payement
        self.noOfYears = noOfYears
    }
    
    /// This function does the calculation to find out the Mortgage Amount.
    ///
    /// - Returns: Double value of the Mortgage Amount for the TextField
    func calculateMortgageAmount() -> Double {
        var mortgageAmount: Double
        
        let interest = (self.interest! / 100) / 12
        let payment = self.payment!
        let noOfYears = self.noOfYears! * 12
        
        mortgageAmount = (payment * (pow(1 + interest, noOfYears) - 1)) / (interest * pow(1 + interest, noOfYears))
        return mortgageAmount
    }
    
    /// This function does the calculation to find out the Interest.
    ///
    /// - Returns: Double value of the Interest for the TextField
    func calculateInterest() -> Double {
        var interest: Double
        
        let mortgageAmount = self.mortgageAmount!
        let payment = self.payment!
        let noOfYears = self.noOfYears! * 12
        
        interest = interestCalculator.calculateInterestRate(principalAmount: mortgageAmount, payement: payment, noOfPayments: noOfYears)
        return interest
    }
    
    /// This function does the calculation to find out the Payment.
    ///
    /// - Returns: Double value of the Payment for the TextField
    func calculatePayment() -> Double {
        var payment: Double
        
        let mortgageAmount = self.mortgageAmount!
        let interest = (self.interest! / 100) / 12
        let noOfYears = self.noOfYears! * 12
        
        payment = (mortgageAmount * (interest * pow(1 + interest, noOfYears))) / (pow(1 + interest, noOfYears) - 1)
        return payment
    }
    
    /// This function does the calculation to find out the Number of Years.
    ///
    /// - Returns: Double value of the Number of Years for the TextField
    func calculateNoOfYears() -> Double {
        var noOfYears: Double
                        
        let mortgageAmount = self.mortgageAmount!
        let interest = (self.interest! / 100) / 12
        let payment = self.payment!
                        
        noOfYears = log((payment / interest) / ((payment / interest) - mortgageAmount)) / log(1 + interest)
        return noOfYears / 12
    }
    
    /// This function store all the data to the UserDefaults.
    func storeMortgageData(){
        let mortgageDefaults = UserDefaults.standard

        mortgageDefaults.set(self.mortgageAmount, forKey: "FinanceApp_MortgageData_mortgageAmount")
        mortgageDefaults.set(self.interest, forKey: "FinanceApp_MortgageData_interest")
        mortgageDefaults.set(self.payment, forKey: "FinanceApp_MortgageData_payment")
        mortgageDefaults.set(self.noOfYears, forKey: "FinanceApp_MortgageData_noOfYears")
    }
    
    /// This function retrieves all the data from the UserDefaults.
    func retrieveMortgageData(){
        let mortgageDefaults = UserDefaults.standard
        
        self.mortgageAmount = mortgageDefaults.object(forKey: "FinanceApp_MortgageData_mortgageAmount") as? Double
        self.interest = mortgageDefaults.object(forKey: "FinanceApp_MortgageData_interest") as? Double
        self.payment = mortgageDefaults.object(forKey: "FinanceApp_MortgageData_payment") as? Double
        self.noOfYears = mortgageDefaults.object(forKey: "FinanceApp_MortgageData_noOfYears") as? Double
    }
}
