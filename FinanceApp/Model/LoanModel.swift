//
//  LoanModel.swift
//  FinanceApp
//
//  Created by Hamool Nizar on 3/2/20.
//  Copyright © 2020 Hamool Nizar. All rights reserved.
//

import Foundation

class LoanModel {
    var loanAmount : Double?
    var interest : Double?
    var payment : Double?
    var noOfPayments : Double?
    var interestCalculator = InterestRateCalculator()
    
    /// Constructor
    init(loanAmount:Double?, interest:Double?, payement:Double?, noOfPayments:Double?) {
        self.loanAmount = loanAmount
        self.interest = interest
        self.payment = payement
        self.noOfPayments = noOfPayments
    }
    
    /// This function does the calculation to find out the Loan Amount.
    ///
    /// - Returns: Double value of the Loan Amount for the TextField
    func calculateLoanAmount() -> Double {
        var loanAmount: Double
        
        let interest = (self.interest! / 100) / 12
        let payment = self.payment!
        let noOfPayments = self.noOfPayments!
        
        loanAmount = (payment * (pow(1 + interest, noOfPayments) - 1)) / (interest * pow(1 + interest, noOfPayments))
        return loanAmount
    }
    
    /// This function does the calculation to find out the Interest.
    ///
    /// - Returns: Double value of the Interest for the TextField
    func calculateInterest() -> Double {
        var interest: Double
        
        let loanAmount = self.loanAmount!
        let payment = self.payment!
        let noOfPayments = self.noOfPayments!
        
        //    interest = (payment * noOfPayments) / (loanAmount * (noOfPayments / 12)) * 100
        interest = interestCalculator.calculateInterestRate(principalAmount: loanAmount, payement: payment, noOfPayments: noOfPayments)
        return interest
    }
    
    /// This function does the calculation to find out the Payment.
    ///
    /// - Returns: Double value of the Payment for the TextField
    func calculatePayment() -> Double {
        var payment: Double
        
        let loanAmount = self.loanAmount!
        let interest = (self.interest! / 100) / 12
        let noOfPayments = self.noOfPayments!
        
        payment = (loanAmount * (interest * pow(1 + interest, noOfPayments))) / (pow(1 + interest, noOfPayments) - 1)
        return payment
    }
    
    /// This function does the calculation to find out the Number of Payments.
    ///
    /// - Returns: Double value of the Number of Payments for the TextField
    func calculateNoOfPayments() -> Double {
        var noOfPayments: Double
        
        let loanAmount = self.loanAmount!
        let interest = (self.interest! / 100) / 12
        let payment = self.payment!
        
        noOfPayments = log((payment / interest) / ((payment / interest) - loanAmount)) / log(1 + interest)
        return noOfPayments
    }
    
    /// This function store all the data to the UserDefaults.
    func storeLoanData(){
        let loanDefaults = UserDefaults.standard
        
        loanDefaults.set(self.loanAmount, forKey: "FinanceApp_LoanData_loanAmount")
        loanDefaults.set(self.interest, forKey: "FinanceApp_LoanData_interest")
        loanDefaults.set(self.payment, forKey: "FinanceApp_LoanData_payment")
        loanDefaults.set(self.noOfPayments, forKey: "FinanceApp_LoanData_noOfPayments")
    }
    
    /// This function retrieves all the data from the UserDefaults.
    func retrieveLoanData(){
        let loanDefaults = UserDefaults.standard
        
        self.loanAmount = loanDefaults.object(forKey: "FinanceApp_LoanData_loanAmount") as? Double
        self.interest = loanDefaults.object(forKey: "FinanceApp_LoanData_interest") as? Double
        self.payment = loanDefaults.object(forKey: "FinanceApp_LoanData_payment") as? Double
        self.noOfPayments = loanDefaults.object(forKey: "FinanceApp_LoanData_noOfPayments") as? Double
    }
}
