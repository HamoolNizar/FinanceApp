//
//  CompoundInterestSavingsModel.swift
//  FinanceApp
//
//  Created by Hamool Nizar on 3/2/20.
//  Copyright © 2020 Hamool Nizar. All rights reserved.
//

import Foundation

class CompoundInterestSavingsModel {
    var presentValue : Double?
    var futureValue : Double?
    var interest : Double?
    var noOfYears : Double?
    var compoundsPerYear : Double?
    
    /// Constructor
    init(presentValue:Double?, futureValue:Double?, interest:Double?, noOfYears:Double?, compoundsPerYear:Double?) {
        self.presentValue = presentValue
        self.futureValue = futureValue
        self.interest = interest
        self.noOfYears = noOfYears
        self.compoundsPerYear = compoundsPerYear
    }
    
    /// This function does the calculation to find out the Present Value.
    ///
    /// - Returns: Double value of the Present Value for the TextField
    func calculatePresentValue() -> Double {
        var presentValue: Double
        
        let futureValue = self.futureValue!
        let interest = (self.interest! / 100)
        let noOfYears = self.noOfYears!
        let compoundsPerYear = self.compoundsPerYear!
        
        presentValue = futureValue / pow((1 + (interest / compoundsPerYear)), compoundsPerYear * noOfYears)
        return presentValue
    }
    
    /// This function does the calculation to find out the Future Value.
    ///
    /// - Returns: Double value of the Future Value for the TextField
    func calculateFutureValue() -> Double {
        var futureValue: Double
        
        let presentValue = self.presentValue!
        let interest = (self.interest! / 100)
        let noOfYears = self.noOfYears!
        let compoundsPerYear = self.compoundsPerYear!
        
        futureValue = presentValue * pow((1 + interest / compoundsPerYear), compoundsPerYear * noOfYears)
        return futureValue
    }
    
    /// This function does the calculation to find out the Interest.
    ///
    /// - Returns: Double value of the Interest for the TextField
    func calculateInterest() -> Double {
        var interest: Double
        
        let presentValue = self.presentValue!
        let futureValue = self.futureValue!
        let noOfYears = self.noOfYears!
        let compoundsPerYear = self.compoundsPerYear!
        
        interest = compoundsPerYear * (pow((futureValue / presentValue), (1 / (compoundsPerYear * noOfYears))) - 1)
        return interest * 100
    }
    
    /// This function does the calculation to find out the Number of Years.
    ///
    /// - Returns: Double value of the Number of Years for the TextField
    func calculateNoOfYears() -> Double {
        var noOfYears: Double
        
        let presentValue = self.presentValue!
        let futureValue = self.futureValue!
        let interest = (self.interest! / 100)
        let compoundsPerYear = self.compoundsPerYear!
        
        noOfYears = log(futureValue/presentValue) / (compoundsPerYear *  log(1 + (interest / compoundsPerYear)))
        return noOfYears
    }
    
    /// This function does the calculation to find out the Compounds per Year.
    ///
    /// - Returns: Double value of the Compounds per Year for the TextField
    func calculateCompoundsPerYear() -> Double {
        var compoundsPerYear: Double
        
        //        let presentValue = self.presentValue!
        //        let futureValue = self.futureValue!
        //        let interest = (self.interest! / 100) / 12
        //        let noOfYears = self.noOfYears!
        
        compoundsPerYear = 12
        return compoundsPerYear
    }
    
    /// This function store all the data to the UserDefaults.
    func storeCompoundInterestSavingsData(){
        let compoundInterestSavingsDefaults = UserDefaults.standard
        
        compoundInterestSavingsDefaults.set(self.presentValue, forKey: "FinanceApp_CompoundInterestSavings_presentValue")
        compoundInterestSavingsDefaults.set(self.futureValue, forKey: "FinanceApp_CompoundInterestSavings_futureValue")
        compoundInterestSavingsDefaults.set(self.interest, forKey: "FinanceApp_CompoundInterestSavings_interest")
        compoundInterestSavingsDefaults.set(self.noOfYears, forKey: "FinanceApp_CompoundInterestSavings_noOfYears")
        compoundInterestSavingsDefaults.set(self.compoundsPerYear, forKey: "FinanceApp_CompoundInterestSavings_compoundsPerYear")
    }
    
    /// This function retrieves all the data from the UserDefaults.
    func retrieveCompoundInterestSavingsData(){
        let compoundInterestSavingsDefaults = UserDefaults.standard
        
        self.presentValue = compoundInterestSavingsDefaults.object(forKey: "FinanceApp_CompoundInterestSavings_presentValue") as? Double
        self.futureValue = compoundInterestSavingsDefaults.object(forKey: "FinanceApp_CompoundInterestSavings_futureValue") as? Double
        self.interest = compoundInterestSavingsDefaults.object(forKey: "FinanceApp_CompoundInterestSavings_interest") as? Double
        self.noOfYears = compoundInterestSavingsDefaults.object(forKey: "FinanceApp_CompoundInterestSavings_noOfYears") as? Double
        self.compoundsPerYear = compoundInterestSavingsDefaults.object(forKey: "FinanceApp_CompoundInterestSavings_compoundsPerYear") as? Double
    }
}
