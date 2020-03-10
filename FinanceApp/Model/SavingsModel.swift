//
//  SavingsModel.swift
//  FinanceApp
//
//  Created by Hamool Nizar on 3/2/20.
//  Copyright © 2020 Hamool Nizar. All rights reserved.
//

import Foundation

class SavingsModel {
    var principalAmount : Double?
    var interest : Double?
    var payment : Double?
    var compoundsPerYear : Double?
    var paymentsPerYear : Double?
    var futureValue : Double?
    var noOfYears : Double?
    var paymentPeriod : Double?
    
    /// Constructor
    init(principalAmount:Double?, interest:Double?, payement:Double?, compoundsPerYear:Double?, paymentsPerYear:Double?, futureValue:Double?, noOfYears:Double?, paymentPeriod:Double?) {
        self.principalAmount = principalAmount
        self.interest = interest
        self.payment = payement
        self.compoundsPerYear = compoundsPerYear
        self.paymentsPerYear = paymentsPerYear
        self.futureValue = futureValue
        self.noOfYears = noOfYears
        self.paymentPeriod = paymentPeriod
    }
    
    /// This function does the calculation to find out the Principal Amount.
    ///
    /// - Returns: Double value of the Principal Amount for the TextField
    func calculatePrincipalAmount() -> Double {
        var principalAmount: Double
        
        let interest = (self.interest! / 100)
        let payment = self.payment!
        let compoundsPerYear = self.compoundsPerYear!
        //        let paymentsPerYear = self.paymentsPerYear!
        let futureValue = self.futureValue!
        let noOfYears = self.noOfYears!
        let paymentPeriod = self.paymentPeriod!
        
        if (paymentPeriod == 1.0){
            // End
            principalAmount = (futureValue - (payment * (pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears) - 1) / (interest / compoundsPerYear))) / pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears)
            return principalAmount
        } else {
            //Beginning
            principalAmount = (futureValue - (payment * (pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears) - 1) / (interest / compoundsPerYear)) * (1 + interest / compoundsPerYear)) / pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears)
            return principalAmount
        }
    }
    
    /// This function does the calculation to find out the Interest.
    ///
    /// - Returns: Double value of the Interest for the TextField
    func calculateInterest() -> Double {
        var interest: Double
        
        let principalAmount = self.principalAmount!
        let payment = self.payment!
//        let compoundsPerYear = self.compoundsPerYear!
//        let paymentsPerYear = self.paymentsPerYear!
//        let futureValue = self.futureValue!
        let noOfYears = self.noOfYears!
        let paymentPeriod = self.paymentPeriod!
        
        if (paymentPeriod == 1.0){
            // End
            interest = (payment * noOfYears) / (principalAmount * (noOfYears / 12))
            return interest
        } else {
            //Beginning
            interest = (payment * noOfYears) / (principalAmount * (noOfYears / 12))
            return interest
        }
    }
    
    /// This function does the calculation to find out the Payment.
    ///
    /// - Returns: Double value of the Payment for the TextField
    func calculatePayment() -> Double {
        var payment: Double
        
        let principalAmount = self.principalAmount!
        let interest = (self.interest! / 100)
        let compoundsPerYear = self.compoundsPerYear!
        //        let paymentsPerYear = self.paymentsPerYear!
        let futureValue = self.futureValue!
        let noOfYears = self.noOfYears!
        let paymentPeriod = self.paymentPeriod!
        
        if (paymentPeriod == 1.0){
            // End
            payment = (futureValue - (principalAmount * pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears))) / ((pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears) - 1) / (interest / compoundsPerYear))
            return payment
        } else {
            //Beginning
            payment = (futureValue - (principalAmount * pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears))) / ((pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears) - 1) / (interest / compoundsPerYear)) / (1 + interest / compoundsPerYear)
            return payment
        }
    }
    
    /// This function does the calculation to find out the Compounds per Year.
    ///
    /// - Returns: Double value of the Compounds per Year for the TextField
    func calculateCompoundsPerYear() -> Double {
        var compoundsPerYear: Double
        
        //        let principalAmount = self.principalAmount!
        //        let interest = (self.interest! / 100)
        //        let payment = self.payment!
        //        let paymentsPerYear = self.paymentsPerYear!
        //        let futureValue = self.futureValue!
        //        let noOfYears = self.noOfYears!
        //        let paymentPeriod = self.paymentPeriod!
        
        compoundsPerYear = 12
        return compoundsPerYear
    }
    
    /// This function does the calculation to find out the Payments per Year.
    ///
    /// - Returns: Double value of the Payments per Year for the TextField
    func calculatePaymentsPerYear() -> Double {
        var paymentsPerYear: Double
        
        //        let principalAmount = self.principalAmount!
        //        let interest = (self.interest! / 100)
        //        let payment = self.payment!
        //        let compoundsPerYear = self.compoundsPerYear!
        //        let futureValue = self.futureValue!
        //        let noOfYears = self.noOfYears!
        //        let paymentPeriod = self.paymentPeriod!
        
        paymentsPerYear = 12
        return paymentsPerYear
    }
    
    /// This function does the calculation to find out the Future Value.
    ///
    /// - Returns: Double value of the Future Value for the TextField
    func calculateFutureValue() -> Double {
        var futureValue: Double
        
        let principalAmount = self.principalAmount!
        let interest = (self.interest! / 100)
        let payment = self.payment!
        let compoundsPerYear = self.compoundsPerYear!
        //        let paymentsPerYear = self.paymentsPerYear!
        let noOfYears = self.noOfYears!
        let paymentPeriod = self.paymentPeriod!
        
        if (paymentPeriod == 1.0){
            // End
            futureValue = principalAmount * pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears) + (payment * (pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears) - 1) / (interest / compoundsPerYear))
            return futureValue
        } else {
            //Beginning
            futureValue = principalAmount * pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears) + (payment * (pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears) - 1) / (interest / compoundsPerYear)) * (1 + interest / compoundsPerYear)
            return futureValue
        }
    }
    
    /// This function does the calculation to find out the Number of Years.
    ///
    /// - Returns: Double value of the Number of Years for the TextField
    func calculateNoOfYears() -> Double {
        var noOfYears: Double
        
        let principalAmount = self.principalAmount!
        let interest = (self.interest! / 100)
        let payment = self.payment!
        let compoundsPerYear = self.compoundsPerYear!
        //        let paymentsPerYear = self.paymentsPerYear!
        let futureValue = self.futureValue!
        let paymentPeriod = self.paymentPeriod!
        
        //        noOfYears = (log((payment / interest) / ((payment / interest) - mortgageAmount)) / log(1 + interest))
        if (paymentPeriod == 1.0){
            // End
            noOfYears = (log(futureValue + ((payment*compoundsPerYear)/interest)) - log(((interest*principalAmount) + (payment*compoundsPerYear)) / interest)) / (compoundsPerYear * log(1+(interest/compoundsPerYear)))
            return noOfYears
        } else {
            //Beginning
            noOfYears = (log(futureValue + payment + ((payment * compoundsPerYear) / interest)) - log(principalAmount + payment + (payment * compoundsPerYear) / interest)) / (compoundsPerYear * log(1 + (interest / compoundsPerYear)))
            return noOfYears
        }
    }
    
    /// This function does the calculation to find out the Payment Period.
    ///
    /// - Returns: Double value of the Payment Period for the TextField
    func calculatePaymentPeriod() -> Double {
        var paymentPeriod: Double
        
        let principalAmount = self.principalAmount!
        let interest = (self.interest! / 100)
        let payment = self.payment!
        let compoundsPerYear = self.compoundsPerYear!
        //        let paymentsPerYear = self.paymentsPerYear!
        let futureValue = self.futureValue!
        let noOfYears = self.noOfYears!
        
        // End
        let principalAmount_End = (futureValue - (payment * (pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears) - 1) / (interest / compoundsPerYear))) / pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears)
        
        if (principalAmount == principalAmount_End){
            paymentPeriod = 1.0
            return paymentPeriod
        } else {
            paymentPeriod = 0.0
            return paymentPeriod
        }
    }
    
    /// This function store all the data to the UserDefaults.
    func storeSavingsData(){
        let savingsDefaults = UserDefaults.standard
        
        savingsDefaults.set(self.principalAmount, forKey: "FinanceApp_SavingsData_principalAmount")
        savingsDefaults.set(self.interest, forKey: "FinanceApp_SavingsData_interest")
        savingsDefaults.set(self.payment, forKey: "FinanceApp_SavingsData_payment")
        savingsDefaults.set(self.compoundsPerYear, forKey: "FinanceApp_SavingsData_compoundsPerYear")
        savingsDefaults.set(self.paymentsPerYear, forKey: "FinanceApp_SavingsData_paymentsPerYear")
        savingsDefaults.set(self.futureValue, forKey: "FinanceApp_SavingsData_futureValue")
        savingsDefaults.set(self.noOfYears, forKey: "FinanceApp_SavingsData_noOfYears")
        savingsDefaults.set(self.paymentPeriod, forKey: "FinanceApp_SavingsData_paymentPeriod")
    }
    
    /// This function retrieves all the data from the UserDefaults.
    func retrieveSavingsData(){
        let savingsDefaults = UserDefaults.standard
        
        self.principalAmount = savingsDefaults.object(forKey: "FinanceApp_SavingsData_principalAmount") as? Double
        self.interest = savingsDefaults.object(forKey: "FinanceApp_SavingsData_interest") as? Double
        self.payment = savingsDefaults.object(forKey: "FinanceApp_SavingsData_payment") as? Double
        self.compoundsPerYear = savingsDefaults.object(forKey: "FinanceApp_SavingsData_compoundsPerYear") as? Double
        self.paymentsPerYear = savingsDefaults.object(forKey: "FinanceApp_SavingsData_paymentsPerYear") as? Double
        self.futureValue = savingsDefaults.object(forKey: "FinanceApp_SavingsData_futureValue") as? Double
        self.noOfYears = savingsDefaults.object(forKey: "FinanceApp_SavingsData_noOfYears") as? Double
        self.paymentPeriod = savingsDefaults.object(forKey: "FinanceApp_SavingsData_paymentPeriod") as? Double
    }
}

