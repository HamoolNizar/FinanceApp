//
//  InterestRateCalculator.swift
//  FinanceApp
//
//  Created by Hamool Nizar on 3/8/20.
//  Copyright © 2020 Hamool Nizar. All rights reserved.
//

import Foundation

class InterestRateCalculator {
    var principalAmount : Double?
    var payment : Double?
    var noOfPayments : Double?

    /// Constructor
    init() {
        self.principalAmount = nil
        self.payment = nil
        self.noOfPayments = nil
    }

    /// This function will calculate the interest rate for the given parameter
    ///
    /// - Parameter principalAmount: Principal Amount .
    /// - Parameter payement: Monthly Payment.
    /// - Parameter noOfPayments: Number of Payments.
    /// - Returns: Double value of calculated interest rate.
    func calculateInterestRate(principalAmount:Double, payement:Double, noOfPayments:Double) -> Double {
        var assumedInterestRate = 0.1 // assumoing the interest is 10%

        func F(intersetRate: Double) -> Double {
            return Double(principalAmount * intersetRate * pow(1 + intersetRate, noOfPayments) / (pow(1+intersetRate, noOfPayments) - 1) - payement);
        }

        func FPrime(intersetRate: Double) -> Double {
            return Double(principalAmount * pow(intersetRate+1, noOfPayments-1) * (intersetRate * (pow(intersetRate+1, noOfPayments)) + (pow(intersetRate+1, noOfPayments)) - (noOfPayments*intersetRate) - intersetRate - 1)) / pow((pow(intersetRate+1, noOfPayments)) - 1, 2)
        }

        while(abs(F(intersetRate: assumedInterestRate)) > 0.000001) {
            assumedInterestRate = assumedInterestRate - F(intersetRate: assumedInterestRate) / FPrime(intersetRate: assumedInterestRate)
        }
        return assumedInterestRate * 1200
    }

}
