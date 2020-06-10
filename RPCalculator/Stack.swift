//
//  Stack.swift
//  RPCalculator
//
//  Created by ManLikeMe on 10/06/2020.
//  Copyright © 2020 SingularBro. All rights reserved.
//

import Foundation

struct Stack {
    
    static func push(tempStack: [String], item: String) -> [String] {
        var stack = tempStack
        stack.append(item)
        return stack
    }
    
    static func pop(tempStack: [String]) -> String? {
        var stack = tempStack
        if stack.count == 0 {
            return nil
        } else {
            return stack.popLast()
        }
    }
    
}
