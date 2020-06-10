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
        self.stack.append(item)
    }
    
    func pop() -> String {
        if self.stack.count == 0 {
            return ""
        }
        return self.stack.popLast()!
    }
    
}
