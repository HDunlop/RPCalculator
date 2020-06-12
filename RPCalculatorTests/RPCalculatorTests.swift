//
//  RPCalculatorTests.swift
//  RPCalculatorTests
//
//  Created by ManLikeMe on 09/06/2020.
//  Copyright © 2020 SingularBro. All rights reserved.
//

import XCTest
@testable import RPCalculator

class RPCalculatorTests: XCTestCase {

    var stack = Stack()
    var logicalMethods = LogicalMethods()
    
    func testingStackPushPushesTheInputToTheTop() {
        stack.push(item: "top value")
        let expected = "top value"
        let actual = stack.peek()
        XCTAssertEqual(actual, expected)
        stack.empty()
    }

    func testingStackGetLengthReturnsCorrectStackLength() {
        for i in 1...5 {
            stack.push(item: String(i))
        }
        let expected = 5
        let actual = stack.getLength()
        XCTAssertEqual(actual, expected)
        stack.empty()
    }
    
    func testingStackPopsTheCorrectTopValue() {
        for i in 1...5 {
            stack.push(item: String(i))
        }
        let expected = "5"
        let actual = stack.pop()
        XCTAssertEqual(actual, expected)
        stack.empty()
    }
    
    func testingStackEmptyEmptiesStack() {
        for i in 1...5 {
            stack.push(item: String(i))
        }
        stack.empty()
        let expected = 0
        let actual = stack.getLength()
        XCTAssertEqual(actual, expected)
    }
    
    func testingLogicalMethodsAddToExpression() {
        let testCases: [[[String]]] = [[[""], ["1","1"], ["1"], [""], ["addToExpression"]], [[""], ["1"], [], [""], ["addToExpression"]], [[""], ["1","1","1","1","1"], ["1"], [""], ["addToExpression"]], [[""], ["1","1", "1","p","1"], ["1"], [""], ["addToExpression"]], [[""], ["1"], ["1"], [""], ["addToExpression"]]]
        let testExpected: [[[String]]] = [[["failed", "Too many operands", "Maximum number of operands per operator is 2"]], [["failed", "Nothing to add", "You must first write an operand to add it to the expression"]], [["failed", "Too many operands", "Maximum number of operands per operator is 2"]], [["1","1", "1","p","1"," 1"]], [["1"," 1"]]]
        
        for index in 0..<testCases.count {
            let expected = testExpected[index]
            let actual = logicalMethods.overrideValues(stack: testCases[index][0], expressionList: testCases[index][1], currentOperand: testCases[index][2], evaluation: testCases[index][3][0], methodCall: testCases[index][4])
            XCTAssertEqual(actual,expected)
        }
    }
    
    func testingLogicalMethodsAddNumber() {
        let testCases: [[[String]]] = [[[""], [], ["1","1","1"], [""], ["addNumber", "1", "false"]], [[""], ["1"], [], [""], ["addNumber", "", "true"]], [[""], [], ["1","1","1"], [""], ["addNumber", "", "true"]], [[""], [], ["1","1"], [""], ["addNumber", "1", "false"]]]
        let testExpected: [[[String]]] = [[["failed", "Too many digits", "Maximum number of digits per operand is 3"]], [["failed", "Empty Expression", "You must first write an operator to change its sign"]], [["-1","1","1"]], [["1","1","1"]]]
        
        for index in 0..<testCases.count {
            let expected = testExpected[index]
            let actual = logicalMethods.overrideValues(stack: testCases[index][0], expressionList: testCases[index][1], currentOperand: testCases[index][2], evaluation: testCases[index][3][0], methodCall: testCases[index][4])
            XCTAssertEqual(actual,expected)
        }
    }
    
    func testingLogicalMethodsIsInt() {
        let testCases: [[[String]]] = [[[], [], [], [""], ["isInt", "1"]], [[], [], [], [""], ["isInt", "qwerty"]]]
        let testExpected: [[[String]]] = [[[String(true)]], [[String(false)]]]
        
        for index in 0..<testCases.count {
            let expected = testExpected[index]
            let actual = logicalMethods.overrideValues(stack: testCases[index][0], expressionList: testCases[index][1], currentOperand: testCases[index][2], evaluation: testCases[index][3][0], methodCall: testCases[index][4])
            XCTAssertEqual(actual,expected)
        }
    }
    
    func testingErrorHandlingOfLogicalMethodsArithmetic() {
        let testCases: [[[String]]] = [[[""], ["1","1"], ["1"], [""], ["arithmetic", " ÷", "4"]], [[""], ["1","1","1","1","1"], ["1"], [""], ["arithmetic", " ÷", "4"]], [[], ["1"], [], [""], ["arithmetic", " ÷", "4"]], [[], [], ["1"], [""], ["arithmetic", " ÷", "4"]], [["1","1"], ["1","1"], [], [""], ["arithmetic", " ÷", "4"]], [["1"], ["2"," 1"," -", " 0"], [], [""], ["arithmetic", " ÷", "4"]], [["1"], ["2"," 1"," -"], ["0"], [""], ["arithmetic", " ÷", "4"]], [[], ["2"," 1"," -", " 0"], [], [""], ["arithmetic", " +", "1"]], [[], ["2"," 1"," -"], ["0"], [""], ["arithmetic", " +", "1"]], [[], ["2"," 0"], [], [""], ["arithmetic", " ÷", "4"]], [[], ["2"], ["0"], [""], ["arithmetic", " ÷", "4"]], [["1"], ["2"," 1"," -", " 0"], [], [""], ["arithmetic", " +", "1"]], [["1"], ["2"," 1"," -"], ["0"], [""], ["arithmetic", " +", "1"]], [[], ["2"," 1"], [], [""], ["arithmetic", " -", "2"]], [[], ["2"], ["1"], [""], ["arithmetic", " -", "2"]]]
        let testExpected: [[[String]]] = [[["failed", "Too many operands", "Maximum number of operands per operator is 2"]], [["failed", "Too many operands", "Maximum number of operands per operator is 2"]], [["failed", "Insufficient operands", "Write more operands"], []], [["failed", "Insufficient operands", "Write more operands"], [" 1"]], [["failed", "Too many operands", "Maximum number of operands or products of arithmetic processes to evaluate is 2"], []], [["failed", "Division by 0", "u dun oofed brœther"], []], [["failed", "Division by 0", "u dun oofed brœther"], ["2"," 1"," -", " 0"]], [["failed", "Too few operands", "Minimum number of operands to evaluate by one operator is 2"], []], [["failed", "Too few operands", "Minimum number of operands to evaluate by one operator is 2"], ["2"," 1"," -", " 0"]], [["failed", "Division by 0", "u dun oofed brœther"], []], [["failed", "Division by 0", "u dun oofed brœther"], ["2"," 0"]], [["2"," 1"," -", " 0", " +", "1"], []], [["2"," 1"," -", " 0", " +", "1"], ["2"," 1"," -", " 0"]], [["2"," 1", " -", "1"], []], [["2"," 1", " -", "1"], ["2"," 1"]]]
        
        for index in 0..<testCases.count {
            let expected = testExpected[index]
            let actual = logicalMethods.overrideValues(stack: testCases[index][0], expressionList: testCases[index][1], currentOperand: testCases[index][2], evaluation: testCases[index][3][0], methodCall: testCases[index][4])
            XCTAssertEqual(actual,expected)
        }
    }
}
