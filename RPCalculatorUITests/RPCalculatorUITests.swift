//
//  RPCalculatorUITests.swift
//  RPCalculatorUITests
//
//  Created by ManLikeMe on 09/06/2020.
//  Copyright © 2020 SingularBro. All rights reserved.
//

import XCTest

class RPCalculatorUITests: XCTestCase {
    
    func testThatCurrentOperandAddsADigitWhenANumberButtonIsPressed() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["2"].tap()
        app.buttons["7"].tap()
        app.buttons["3"].tap()
        
        let expected = "273"
        let actual = app.staticTexts["operand"].label
        XCTAssertEqual(actual, expected)
    }
    
    func testChangeSignWorksIfTappedOnceOrTwice() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["0"].tap()
        app.buttons["1"].tap()
        app.buttons["9"].tap()
        app.buttons["+/-"].tap()
        var expected = "-019"
        var actual = app.staticTexts["operand"].label
        XCTAssertEqual(actual, expected)
        
        app.buttons["+/-"].tap()
        expected = "019"
        actual = app.staticTexts["operand"].label
        XCTAssertEqual(actual, expected)
    }
    
    func testEnterAndOperatorButtonAddTheCurrentOperandToTheExpression() {
        let app = XCUIApplication()
        app.launch()
        
        let operators = ["addition", "subtraction", "multiplication", "division"]
        
        app.buttons["5"].tap()
        app.buttons["6"].tap()
        app.buttons["7"].tap()
        app.buttons["enter"].tap()
        let expected = " 567"
        let actual = app.staticTexts["expression"].label
        XCTAssertEqual(actual, expected)
        
        for index in 0..<operators.count {
            app.buttons["5"].tap()
            app.buttons["6"].tap()
            app.buttons["7"].tap()
            app.buttons[operators[index]].tap()
            
            XCTAssertFalse(app.staticTexts["operand"].exists)
        }
    }
    
    func testMoreThanThreeDigitEntriesThrowsAnError() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["5"].tap()
        app.buttons["6"].tap()
        app.buttons["7"].tap()
        app.buttons["8"].tap()
        
        app.alerts["Too many digits"].buttons["Ok"].tap()
        
        let expressionActual = app.staticTexts["expression"].exists
        XCTAssertFalse(expressionActual)
        
        let operandExpected = "567"
        let operandActual = app.staticTexts["operand"].label
        XCTAssertEqual(operandActual, operandExpected)
    }
    
    func testOperatorsThrowAnErrorIfTheExpressionDoesNotExist() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["5"].tap()
        
        let operators = ["addition", "subtraction", "multiplication", "division"]
        
        for index in 0..<operators.count {
            app.buttons[operators[index]].tap()
            
            app.alerts["Insufficient operands"].buttons["Ok"].tap()
            
            let expressionActual = app.staticTexts["expression"].exists
            XCTAssertFalse(expressionActual)
            
            let operandExpected = "5"
            let operandActual = app.staticTexts["operand"].label
            XCTAssertEqual(operandActual, operandExpected)
        }
    }
    
    func testEvaluateReturnsTheCorrectEvaluationAndDisablesAllButtonsExceptForClearWhichEnablesThem() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["1"].tap()
        app.buttons["enter"].tap()
        app.buttons["1"].tap()
        app.buttons["addition"].tap()
        app.buttons["evaluate"].tap()
        
        let buttons = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "evaluate", "addition", "subtraction", "multiplication", "division"]
        for index in 0..<buttons.count {
            XCTAssertFalse(app.buttons[buttons[index]].isEnabled)
        }
        
        app.buttons["enter"].tap()
        app.alerts["Nothing to add"].buttons["Ok"].tap()
        app.buttons["+/-"].tap()
        app.alerts["Empty Expression"].buttons["Ok"].tap()
        
        let expressionExpected = " 1 1 +"
        let expressionActual = app.staticTexts["expression"].label
        XCTAssertEqual(expressionActual, expressionExpected)
        
        let operandActual = app.staticTexts["operand"].exists
        XCTAssertFalse(operandActual)
        
        app.buttons["clear"].tap()
        for index in 0..<buttons.count {
            XCTAssert(app.buttons[buttons[index]].isEnabled)
        }
    }
    
}
