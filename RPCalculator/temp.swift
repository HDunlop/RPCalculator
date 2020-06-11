//
//  temp.swift
//  RPCalculator
//
//  Created by ManLikeMe on 11/06/2020.
//  Copyright © 2020 SingularBro. All rights reserved.
//

import Foundation
//
//func addToExpression() {
//    if self.expressionList.count == 2 && self.currentOperand.count != 0 {
//        self.currentOperand = [String]()
//        alertMessage(title: "Too many operands", text: "Maximum number of operands per operator is 2")
//        setText()
//    } else if self.currentOperand.count == 0 {
//        alertMessage(title: "Nothing to add", text: "You must first write an operand to add it to the expression")
//    } else {
//        if self.expressionList.count > 2 {
//            let index: Int = self.expressionList.count - 1
//            if isInt(value: self.expressionList[index]) && isInt(value: self.expressionList[index - 1]) && self.currentOperand.count != 0 {
//            alertMessage(title: "Too many operands", text: "Maximum number of operands per operator is 2")
//            } else {
//                var temp = " "
//                for item in currentOperand {
//                    temp += item
//                }
//                self.expressionList.append(temp)
//                setText()
//            }
//        } else {
//            var temp = " "
//            for item in currentOperand {
//                temp += item
//            }
//            self.expressionList.append(temp)
//            setText()
//        }
//    }
//}
//
//func addNumber(num: String, sign: Bool) {
//    if (self.currentOperand.count == 3) && (sign == false) {
//        alertMessage(title: "Too many digits", text: "Maximum number of digits per operand is 3")
//    } else if (self.currentOperand.count == 0) && (sign == true) {
//        alertMessage(title: "Empty Expression",text: "You must first write an operator to change its sign")
//    } else {
//        if sign { self.currentOperand[0] = "-" + self.currentOperand[0] }
//        else { self.currentOperand.append(num) }
//        var temp = ""
//        for number in currentOperand {
//            temp += number
//        }
//        Operand.text = temp
//    }
//}
//
//func isInt(value: String) -> Bool {
//    if Int(value.trimmingCharacters(in: .whitespaces)) != nil {
//        return true
//    }
//    return false
//}
//
//func arithmetic(add: String, process: Int) {
//    if self.currentOperand.count != 0 {
//        addToExpression()
//    }
//    if self.expressionList.count <= 1 {
//        alertMessage(title: "Insufficient operands",text: "Write more operands")
//    } else {
//        if stack.getLength() > 2 {
//            alertMessage(title: "Too many operands",text: "Maximum number of operands or products of arithmetic processes to evaluate is 2")
//            self.expressionList = [String]()
//            self.stack.empty()
//            setText()
//        } else if isInt(value: self.expressionList[self.expressionList.count - 1]) == true && isInt(value: self.expressionList[self.expressionList.count - 2]) == false {
//            if stack.getLength() == 1 {
//                let number: Int = Int(stack.pop().trimmingCharacters(in: .whitespaces))!
//                switch process {
//                case 1:
//                    stack.push(item: String(number + Int(self.expressionList[self.expressionList.count - 1].trimmingCharacters(in: .whitespaces))!))
//                case 2:
//                    stack.push(item: String(number - Int(self.expressionList[self.expressionList.count - 1].trimmingCharacters(in: .whitespaces))!))
//                case 3:
//                    stack.push(item: String(number * Int(self.expressionList[self.expressionList.count - 1].trimmingCharacters(in: .whitespaces))!))
//                case 4:
//                    stack.push(item: String(number / Int(self.expressionList[self.expressionList.count - 1].trimmingCharacters(in: .whitespaces))!))
//                default:
//                    alertMessage(title: "Arithmetic error", text: "Try making another expression")
//                    self.expressionList = [String]()
//                    self.stack.empty()
//                    setText()
//                }
//                self.expressionList.append(add)
//                setText()
//            } else {
//                alertMessage(title: "Too few operands",text: "Minimum number of operands to evaluate by one operator is 2")
//            }
//        } else {
//            self.expressionList.append(add)
//            var index: Int = self.expressionList.count - 2
//            let tempStack = Stack()
//            if isInt(value: self.expressionList[index]) {
//                index += 1
//                repeat {
//                    index -= 1
//                    if isInt(value: self.expressionList[index]) {
//                        tempStack.push(item: self.expressionList[index])
//                    }
//                } while (isInt(value: self.expressionList[index]) && (index > 0))
//            } else {
//                var popValue: String = self.stack.pop()
//                repeat {
//                    tempStack.push(item: popValue)
//                    popValue = self.stack.pop()
//                } while isInt(value: popValue)
//            }
//            tempStack.printStack(specificStack: "tempStack")
//            var sum: Int = Int(tempStack.pop())!
//            switch process {
//            case 1:
//                sum = sum + Int(tempStack.pop())!
//            case 2:
//                sum = sum - Int(tempStack.pop())!
//            case 3:
//                sum = sum * Int(tempStack.pop())!
//            case 4:
//                sum = sum / Int(tempStack.pop())!
//            default:
//                alertMessage(title: "Arithmetic error", text: "Try making another expression")
//                self.expressionList = [String]()
//                self.stack.empty()
//                setText()
//            }
//            stack.push(item: String(sum))
//            stack.printStack(specificStack: "main stack")
//            setText()
//        }
//    }
//}
