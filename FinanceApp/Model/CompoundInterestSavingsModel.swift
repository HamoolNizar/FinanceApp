//
//  CompoundInterestSavingsModel.swift
//  FinanceApp
//
//  Created by Hamool Nizar on 3/2/20.
//  Copyright © 2020 Hamool Nizar. All rights reserved.
//

import Foundation

class CompoundInterestSavingsModel {
    var mortgageAmount : Double?
    var interest : Double?
    var payment : Double?
    var noOfYears : Double?
    
    init(mortgageAmount:Double?, interest:Double?, payement:Double?, noOfYears:Double?) {
        self.mortgageAmount = mortgageAmount
        self.interest = interest
        self.payment = payement
        self.noOfYears = noOfYears
    }
    
//    func calculateMortgageAmount() -> Double {
//        var mortgageAmount: Double
//
//        let interest = (self.interest! / 100) / 12
//        let payment = self.payment!
//        let noOfYears = self.noOfYears! * 12
//
//        mortgageAmount = (payment * (pow(1 + interest, noOfYears) - 1)) / (interest * pow(1 + interest, noOfYears))
//        return mortgageAmount
//    }
//
//    func calculateInterest() -> Double {
//        var interest: Double
//
//        let mortgageAmount = self.mortgageAmount!
//        let payment = self.payment!
//        let noOfYears = self.noOfYears! * 12
//
//        interest = (payment * noOfYears) / (mortgageAmount * (noOfYears / 12))
//        return interest
//    }
//
//    func calculatePayment() -> Double {
//        var payment: Double
//
//        let mortgageAmount = self.mortgageAmount!
//        let interest = (self.interest! / 100) / 12
//        let noOfYears = self.noOfYears! * 12
//
//        payment = (mortgageAmount * (interest * pow(1 + interest, noOfYears))) / (pow(1 + interest, noOfYears) - 1)
//        return payment
//    }
//
//    func calculateNoOfYears() -> Double {
//        var noOfYears: Double
//
//        let mortgageAmount = self.mortgageAmount!
//        let interest = (self.interest! / 100) / 12
//        let payment = self.payment!
//
////        noOfYears = (log((payment / interest) / ((payment / interest) - mortgageAmount)) / log(1 + interest))
//        noOfYears = payment / (mortgageAmount * interest)
//        return noOfYears
//    }
    
    func storeMortgageData(){
        let mortgageDefaults = UserDefaults.standard

        mortgageDefaults.set(self.mortgageAmount, forKey: "FinanceApp_MortgageData_mortgageAmount")
        mortgageDefaults.set(self.interest, forKey: "FinanceApp_MortgageData_interest")
        mortgageDefaults.set(self.payment, forKey: "FinanceApp_MortgageData_payment")
        mortgageDefaults.set(self.noOfYears, forKey: "FinanceApp_MortgageData_numOfYears")
    }
    
    func retrieveMortgageData(){
        let mortgageDefaults = UserDefaults.standard
        
        self.mortgageAmount = mortgageDefaults.object(forKey: "FinanceApp_MortgageData_mortgageAmount") as? Double
        self.interest = mortgageDefaults.object(forKey: "FinanceApp_MortgageData_interest") as? Double
        self.payment = mortgageDefaults.object(forKey: "FinanceApp_MortgageData_payment") as? Double
        self.noOfYears = mortgageDefaults.object(forKey: "FinanceApp_MortgageData_numOfYears") as? Double
    }
}
