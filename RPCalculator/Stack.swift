//
//  Stack.swift
//  RPCalculator
//
//  Created by ManLikeMe on 10/06/2020.
//  Copyright © 2020 SingularBro. All rights reserved.
//

import Foundation

class Stack {
    
    var stack: [String]
    
    init() {
        self.stack = [String]()
    }
    
    func push(item: String) {
        self.stack.append(item.trimmingCharacters(in: .whitespaces))
    }
    
    func pop() -> String {
        if self.stack.count == 0 {
            return ""
        }
        return self.stack.popLast()!
    }
    
    func empty() {
        self.stack = [String]()
    }
    
    func getLength() -> Int {
        return self.stack.count
    }
    
    func printStack(specificStack: String) {
        for number in stack {
            print(number)
        }
    }
    
}
