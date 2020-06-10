//
//  LogicalMethods.swift
//  RPCalculator
//
//  Created by ManLikeMe on 11/06/2020.
//  Copyright © 2020 SingularBro. All rights reserved.
//

import Foundation

struct LogicalMethods {
    
    static func addToExpression(operand: [String], expressionList: [String]) -> [String] {
        var expression: [String] = expressionList
        var temp: String = " "
        for item in operand {
            temp += item
        }
        let sex: [String] = expression.append(String(temp))
        return sex
    }
    
    
}
