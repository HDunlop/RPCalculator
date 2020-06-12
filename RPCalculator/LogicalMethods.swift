//
//  LogicalMethods.swift
//  RPCalculator
//
//  Created by ManLikeMe on 11/06/2020.
//  Copyright © 2020 SingularBro. All rights reserved.
//

import Foundation

struct LogicalMethods {
    
    var stack = Stack()
    var expressionList = [String]()
    var evaluation = ""
    var currentOperand = [String]()
    
    mutating func addToExpression() -> [String] {
        if self.expressionList.count == 2 && self.currentOperand.count != 0 {
            return ["failed", "Too many operands", "Maximum number of operands per operator is 2"]
        } else if self.currentOperand.count == 0 {
            return ["failed", "Nothing to add", "You must first write an operand to add it to the expression"]
        } else {
            if self.expressionList.count > 2 {
                let index: Int = self.expressionList.count - 1
                if isInt(value: self.expressionList[index]) && isInt(value: self.expressionList[index - 1]) && self.currentOperand.count != 0 {
                    return ["failed", "Too many operands", "Maximum number of operands per operator is 2"]
                } else {
                    var temp = " "
                    for item in currentOperand {
                        temp += item
                    }
                    self.currentOperand = [String]()
                    self.expressionList.append(temp)
                    return self.expressionList
                }
            } else {
                var temp = " "
                for item in currentOperand {
                    temp += item
                }
                self.currentOperand = [String]()
                self.expressionList.append(temp)
                return self.expressionList
            }
        }
    }
    
    mutating func addNumber(num: String, sign: Bool) -> [String] {
        if (self.currentOperand.count == 3) && (sign == false) {
            return ["failed", "Too many digits", "Maximum number of digits per operand is 3"]
        } else if (self.currentOperand.count == 0) && (sign == true) {
            return ["failed", "Empty Expression", "You must first write an operator to change its sign"]
        } else {
            if sign { self.currentOperand[0] = "-" + self.currentOperand[0] }
            else { self.currentOperand.append(num) }
            return self.currentOperand
        }
    }
    
    func isInt(value: String) -> Bool {
        if Int(value.trimmingCharacters(in: .whitespaces)) != nil {
            return true
        }
        return false
    }
    
    mutating func arithmetic(add: String, process: Int) -> [[String]] {
        var returnList = [String]()
        if self.currentOperand.count != 0 {
            returnList = addToExpression()
            if returnList[0] == "failed" {
                return [returnList]
            }
        }
        if self.expressionList.count <= 1 {
            return [["failed", "Insufficient operands", "Write more operands"], returnList]
        } else {
            if stack.getLength() > 2 {
                self.expressionList = [String]()
                self.stack.empty()
                return [["failed", "Too many operands", "Maximum number of operands or products of arithmetic processes to evaluate is 2"], returnList]
            } else if isInt(value: self.expressionList[self.expressionList.count - 1]) == true && isInt(value: self.expressionList[self.expressionList.count - 2]) == false {
                if stack.getLength() == 1 {
                    let number: Int = Int(stack.pop().trimmingCharacters(in: .whitespaces))!
                    var sum = 0
                    switch process {
                    case 1:
                        sum = number + Int(self.expressionList[self.expressionList.count - 1].trimmingCharacters(in: .whitespaces))!
                    case 2:
                        sum = number - Int(self.expressionList[self.expressionList.count - 1].trimmingCharacters(in: .whitespaces))!
                    case 3:
                        sum = number * Int(self.expressionList[self.expressionList.count - 1].trimmingCharacters(in: .whitespaces))!
                    case 4:
                        sum = number / Int(self.expressionList[self.expressionList.count - 1].trimmingCharacters(in: .whitespaces))!
                    default:
                        self.expressionList = [String]()
                        self.stack.empty()
                        return [["failed", "Arithmetic error", "Try making another expression"], returnList]
                    }
                    stack.push(item: String(sum))
                    self.expressionList.append(add)
                    self.expressionList.append(String(sum))
                    let temp = self.expressionList
                    let _ = self.expressionList.popLast()!
                    return [temp, returnList]
                } else {
                    return [["failed", "Too few operands", "Minimum number of operands to evaluate by one operator is 2"], returnList]
                }
            } else {
                self.expressionList.append(add)
                var index: Int = self.expressionList.count - 2
                let tempStack = Stack()
                if isInt(value: self.expressionList[index]) {
                    index += 1
                    repeat {
                        index -= 1
                        if isInt(value: self.expressionList[index]) {
                            tempStack.push(item: self.expressionList[index])
                        }
                    } while (isInt(value: self.expressionList[index]) && (index > 0))
                } else {
                    var popValue: String = self.stack.pop()
                    repeat {
                        tempStack.push(item: popValue)
                        popValue = self.stack.pop()
                    } while isInt(value: popValue)
                }
                var sum: Int = Int(tempStack.pop())!
                if tempStack.getLength() == 0 {
                    return [["failed", "Too few operands", "Minimum number of operands to evaluate by one operator is 2"], returnList]
                } else {
                    switch process {
                    case 1:
                        sum = sum + Int(tempStack.pop())!
                    case 2:
                        sum = sum - Int(tempStack.pop())!
                    case 3:
                        sum = sum * Int(tempStack.pop())!
                    case 4:
                        let number = Int(tempStack.pop())!
                        if number != 0 {
                            sum = sum / number
                        } else {
                            self.expressionList = [String]()
                            self.stack.empty()
                            return [["failed", "Division by 0", "u dun oofed brœther"], returnList]
                        }
                    default:
                        self.expressionList = [String]()
                        self.stack.empty()
                        return [["failed", "Arithmetic error", "Try making another expression"], returnList]
                    }
                }
                stack.push(item: String(sum))
                self.expressionList.append(String(sum))
                let temp = self.expressionList
                let _ = self.expressionList.popLast()!
                return [temp, returnList]
            }
        }
    }
    
    mutating func clear(process: Int) {
        self.currentOperand = [String]()
        if process == 2 {
            self.expressionList = [String]()
            self.stack.empty()
        }
    }
    
    mutating func overrideValues(stack: [String], expressionList: [String], currentOperand: [String], evaluation: String, methodCall: [String]) -> [[String]] {
        let tempStack = self.stack.returnStack()
        let tempExpressionList = self.expressionList
        let tempCurrentOperand = self.currentOperand
        let tempEvaluation = self.evaluation
        
        self.stack.overrideStack(stack: stack)
        self.expressionList = expressionList
        self.currentOperand = currentOperand
        self.evaluation = evaluation
        
        var returnList: [[String]] = [[String]]()
        switch methodCall[0] {
        case "addToExpression":
            returnList = [addToExpression()]
        case "addNumber":
            returnList = [addNumber(num: methodCall[1], sign: Bool(methodCall[2])!)]
        case "isInt":
            returnList = [[String(isInt(value: methodCall[1]))]]
        case "arithmetic":
            returnList = arithmetic(add: methodCall[1], process: Int(methodCall[2])!)
        default:
            returnList = [["unknown methodCall"]]
        }
        
        self.stack.overrideStack(stack: tempStack)
        self.expressionList = tempExpressionList
        self.currentOperand = tempCurrentOperand
        self.evaluation = tempEvaluation
        
        return returnList
    }
    
}
