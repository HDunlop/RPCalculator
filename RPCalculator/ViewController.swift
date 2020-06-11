//
//  ViewController.swift
//  RPCalculator
//
//  Created by ManLikeMe on 09/06/2020.
//  Copyright © 2020 SingularBro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var stack = Stack()
    var expressionList = [String]()
    var evaluation = ""
    var currentOperand = [String]()
    var logicalMethods = LogicalMethods()
    
    @IBOutlet var Expression: UILabel!
    @IBOutlet var Evaluation: UILabel!
    @IBOutlet var Operand: UILabel!
    
    @IBOutlet var one: UIButton!
    @IBOutlet var two: UIButton!
    @IBOutlet var three: UIButton!
    @IBOutlet var four: UIButton!
    @IBOutlet var five: UIButton!
    @IBOutlet var six: UIButton!
    @IBOutlet var seven: UIButton!
    @IBOutlet var eight: UIButton!
    @IBOutlet var nine: UIButton!
    @IBOutlet var zero: UIButton!
    
    @IBOutlet var eval: UIButton!
    @IBOutlet var clr: UIButton!
    
    @IBOutlet var plus: UIButton!
    @IBOutlet var minus: UIButton!
    @IBOutlet var times: UIButton!
    @IBOutlet var obelus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setText()
    }
    
    func setText() {
        var expression = ""
        for item in self.expressionList {
            expression = expression + item
        }
        Expression.text = expression
        self.currentOperand = [String]()
        Operand.text = ""
        Evaluation.text = self.evaluation
    }
    
    func alertMessage(title: String, text: String) {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addNumber(num: String, sign: Bool) {
        let returnList = logicalMethods.addNumber(num: num, sign: sign)
        if returnList[0] != "failed" {
            self.currentOperand = returnList
            var temp = ""
            for number in currentOperand {
                temp += number
            }
            Operand.text = temp
        } else {
            alertMessage(title: returnList[1], text: returnList[2])
        }
    }
    
    func arithmeticMedium(add: String, process: Int) {
        let returnList = logicalMethods.arithmetic(add: add, process: process)
        if returnList[0][0] == "failed" {
            if (returnList[0][1] == "Too many operands") || (returnList[0][1] == "Arithmetic error") || (returnList[0][1] == "Division by 0") {
                self.expressionList = [String]()
                self.stack.empty()
                setText()
            } else {
                self.expressionList = returnList[1]
            }
            alertMessage(title: returnList[0][1], text: returnList[0][2])
        } else {
            self.expressionList = returnList[0]
            stack.push(item: self.expressionList.popLast()!)
            setText()
        }
    }
    
    @IBAction func pressOne(_ sender: Any) { addNumber(num: "1", sign: false) }
    
    @IBAction func pressTwo(_ sender: Any) { addNumber(num: "2", sign: false) }
    
    @IBAction func pressThree(_ sender: Any) { addNumber(num: "3", sign: false) }
    
    @IBAction func pressFour(_ sender: Any) { addNumber(num: "4", sign: false) }
    
    @IBAction func pressFive(_ sender: Any) { addNumber(num: "5", sign: false) }
    
    @IBAction func pressSix(_ sender: Any) { addNumber(num: "6", sign: false) }
    
    @IBAction func pressSeven(_ sender: Any) { addNumber(num: "7", sign: false) }
    
    @IBAction func pressEight(_ sender: Any) { addNumber(num: "8", sign: false) }
    
    @IBAction func pressNine(_ sender: Any) { addNumber(num: "9", sign: false) }
    
    @IBAction func pressZero(_ sender: Any) { addNumber(num: "0", sign: false) }
    
    @IBAction func switchSign(_ sender: Any) { addNumber(num: "", sign: true) }
    
    @IBAction func Enter(_ sender: Any) {
        let returnList = logicalMethods.addToExpression()
        if returnList[0] == "failed" {
            alertMessage(title: returnList[1], text: returnList[2])
        } else {
            self.expressionList = returnList
            setText()
        }
    }
    
    @IBAction func Evaluate(_ sender: Any) {
        if self.expressionList.count == 0 {
            alertMessage(title: "Empty Expression", text: "You must first define the expression to evaluate")
        } else {
            one.isEnabled = false
            two.isEnabled = false
            three.isEnabled = false
            four.isEnabled = false
            five.isEnabled = false
            six.isEnabled = false
            seven.isEnabled = false
            eight.isEnabled = false
            nine.isEnabled = false
            zero.isEnabled = false
            eval.isEnabled = false
            plus.isEnabled = false
            minus.isEnabled = false
            times.isEnabled = false
            obelus.isEnabled = false
            self.evaluation = stack.pop()
            setText()
        }
    }
    
    @IBAction func Clear(_ sender: Any) {
        if (self.currentOperand.count == 0) && (self.expressionList.count == 0) {
            alertMessage(title: "Nothing to clear",text: "You must first write an operand or an expression to clear it")
        } else {
            one.isEnabled = true
            two.isEnabled = true
            three.isEnabled = true
            four.isEnabled = true
            five.isEnabled = true
            six.isEnabled = true
            seven.isEnabled = true
            eight.isEnabled = true
            nine.isEnabled = true
            zero.isEnabled = true
            eval.isEnabled = true
            plus.isEnabled = true
            minus.isEnabled = true
            times.isEnabled = true
            obelus.isEnabled = true
            if self.currentOperand.count != 0 {
                setText()
                logicalMethods.clear(process: 1)
            } else {
                logicalMethods.clear(process: 2)
                self.expressionList = [String]()
                self.stack.empty()
                setText()
            }
        }
    }
    
    @IBAction func Addition(_ sender: Any) { arithmeticMedium(add: " +", process: 1) }
    
    @IBAction func Subtraction(_ sender: Any) { arithmeticMedium(add: " -", process: 2) }
    
    @IBAction func Multiplication(_ sender: Any) { arithmeticMedium(add: " ×", process: 3) }
    
    @IBAction func Division(_ sender: Any) { arithmeticMedium(add: " ÷", process: 4) }
    
}
