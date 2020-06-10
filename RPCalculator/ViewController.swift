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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eval.isEnabled = false
        clr.isEnabled = false
        setText()
    }
    
    func setText() {
        eval.isEnabled = true
        clr.isEnabled = true
        var expression = ""
        for item in self.expressionList {
            expression = expression + item
        }
        Expression.text = expression
        Operand.text = ""
        Evaluation.text = self.evaluation
    }
    
    func alertMessage(title: String, text: String) {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addToExpression() {
        var temp = " "
        for item in currentOperand {
            temp += item
        }
        self.currentOperand = [String]()
        self.expressionList.append(temp)
        setText()
    }
    
    func addNumber(num: String, sign: Bool) {
        if (self.currentOperand.count == 3) && (sign == false) {
            alertMessage(title: "Too many digits", text: "Maximum number of digits per operand is 3")
        } else if (self.currentOperand.count == 0) && (sign == true) {
            alertMessage(title: "Empty Expression",text: "You must first write an operator to change its sign")
        } else {
            if sign { self.currentOperand[0] = "-" + self.currentOperand[0] }
            else { self.currentOperand.append(num) }
            var temp = ""
            for number in currentOperand {
                temp += number
            }
            Operand.text = temp
        }
    }
    
    func isInt(value: String) -> Bool {
        if Int(value) != nil {
            return true
        }
        return false
    }
    
    func arithmetic(add: String, process: Int) {
        if self.expressionList.count <= 1 {
            alertMessage(title: "Insufficient operands",text: "Write more operands")
        } else if self.currentOperand.count != 0 {
            alertMessage(title: "Existing operand",text: "Press 'Enter' before clicking a process")
        } else {
            self.expressionList.append(add)
            var index = self.expressionList.count - 2
            let tempStack = Stack()
            if isInt(value: self.expressionList[index]) == false {
                while isInt(value: self.stack.pop() ?? "Potatoes") {
                    tempStack.push(item: self.stack.pop()!)
                }
            } else {
                while isInt(value: self.expressionList[index]) {
                    tempStack.push(item: self.expressionList[index])
                    index -= 1
                }
            }
            var number: String? = tempStack.pop()
            var sum: Int = Int(number!)!
            while number != nil {
                switch process {
                case 1:
                    sum += Int(number!)!
                case 2:
                    sum -= Int(number!)!
                case 3:
                    sum = sum * Int(number!)!
                case 4:
                    sum = sum / Int(number!)!
                default:
                    NSLog("smthing wrong with the arithmetic")
                }
                number = tempStack.pop()
            }
            stack.push(item: String(sum))
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
    
    @IBAction func Enter(_ sender: Any) { addToExpression() }
    
    @IBAction func Evaluate(_ sender: Any) {
        if self.expressionList.count == 0 {
            alertMessage(title: "Empty Expression",text: "You must first define the expression to evaluate")
        } else {
            self.evaluation = stack.pop()!
            setText()
        }
    }
    
    @IBAction func Clear(_ sender: Any) {
        if (self.currentOperand.count == 0) && (self.expressionList.count == 0) {
            alertMessage(title: "Nothing to clear",text: "You must first write an operand or an expression to clear it")
        } else {
            if self.currentOperand.count != 0 {
                self.currentOperand = [String]()
            } else {
                self.expressionList = [String]()
            }
            setText()
        }
    }
    
    @IBAction func Addition(_ sender: Any) { arithmetic(add: " +", process: 1) }
    
    @IBAction func Subtraction(_ sender: Any) { arithmetic(add: " -", process: 2) }
    
    @IBAction func Multiplication(_ sender: Any) { arithmetic(add: " ×", process: 3) }
    
    @IBAction func Division(_ sender: Any) { arithmetic(add: " ÷", process: 4) }
    
    
}

