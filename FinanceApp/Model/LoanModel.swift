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
    var noOfYears : Double?
    
    init(loanAmount:Double?, interest:Double?, payement:Double?, noOfYears:Double?) {
        self.loanAmount = loanAmount
        self.interest = interest
        self.payment = payement
        self.noOfYears = noOfYears
    }
    
//    func calculateloanAmount() -> Double {
//        var loanAmount: Double
//
//        let interest = (self.interest! / 100) / 12
//        let payment = self.payment!
//        let noOfYears = self.noOfYears! * 12
//
//        loanAmount = (payment * (pow(1 + interest, noOfYears) - 1)) / (interest * pow(1 + interest, noOfYears))
//        return loanAmount
//    }
//
//    func calculateInterest() -> Double {
//        var interest: Double
//
//        let loanAmount = self.loanAmount!
//        let payment = self.payment!
//        let noOfYears = self.noOfYears! * 12
//
//        interest = (payment * noOfYears) / (loanAmount * (noOfYears / 12))
//        return interest
//    }
//
//    func calculatePayment() -> Double {
//        var payment: Double
//
//        let loanAmount = self.loanAmount!
//        let interest = (self.interest! / 100) / 12
//        let noOfYears = self.noOfYears! * 12
//
//        payment = (loanAmount * (interest * pow(1 + interest, noOfYears))) / (pow(1 + interest, noOfYears) - 1)
//        return payment
//    }
//
//    func calculateNoOfYears() -> Double {
//        var noOfYears: Double
//
//        let loanAmount = self.loanAmount!
//        let interest = (self.interest! / 100) / 12
//        let payment = self.payment!
//
////        noOfYears = (log((payment / interest) / ((payment / interest) - mortgageAmount)) / log(1 + interest))
//        noOfYears = payment / (loanAmount * interest)
//        return noOfYears
//    }
    
    func storeMortgageData(){
        let mortgageDefaults = UserDefaults.standard

        mortgageDefaults.set(self.loanAmount, forKey: "FinanceApp_LoanData_loanAmount")
        mortgageDefaults.set(self.interest, forKey: "FinanceApp_LoanData_interest")
        mortgageDefaults.set(self.payment, forKey: "FinanceApp_LoanData_payment")
        mortgageDefaults.set(self.noOfYears, forKey: "FinanceApp_LoanData_numOfYears")
    }
    
    func retrieveMortgageData(){
        let mortgageDefaults = UserDefaults.standard
        
        self.loanAmount = mortgageDefaults.object(forKey: "FinanceApp_LoanData_loanAmount") as? Double
        self.interest = mortgageDefaults.object(forKey: "FinanceApp_LoanData_interest") as? Double
        self.payment = mortgageDefaults.object(forKey: "FinanceApp_LoanData_payment") as? Double
        self.noOfYears = mortgageDefaults.object(forKey: "FinanceApp_LoanData_numOfYears") as? Double
    }
}
