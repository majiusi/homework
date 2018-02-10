//
//  ViewController.swift
//  sagyou_1
//
//  Created by 王 on 2018/1/27.
//  Copyright © 2018年 王. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInNumber: Bool = false
    var operationG: String = ""
    var countType: String = ""

    
    @IBAction func clear(_ sender: UIButton) {
        
        display.text = "0"
        userIsInNumber = false
        operationG = ""
        countType = ""
    }
    
    
    @IBAction func countTap(_ sender: UIButton) {
        
        let operation = sender.currentTitle!
        operationG = ""
        if userIsInNumber {
            enter()
        }
        
        switch operation {
        case "×":
            performOperation { $0 * $1 }
            countType = "×"
        case "÷":
            performOperation { $1 / $0 }
            countType = "÷"
        case "+":
            performOperation { $0 + $1 }
            countType = "+"
        case "−":
            performOperation { $1 - $0 }
            countType = "−"
        default: break
        }
    }
    
    
    @IBAction func onClick(_ sender: UIButton) {
        
        // 获取Button上的数字
        let digit = sender.currentTitle!
        operationG = operationG + sender.currentTitle!
        // 若已输入过数字，则直接往display中添加数字，否则直接显示新点击的数字
        if userIsInNumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInNumber = true
        }
    }

    
    func performOperation(operation: (Double,Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    
    private func performOperation(operation: (Double) -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    var displayValue: Double {
        
        get {
            return (display.text! as NSString).doubleValue
        }
        set {
            display.text = "\(Int(newValue))"
            userIsInNumber = false
        }
    }
    
    
    @IBAction func result(_ sender: Any) {

        switch countType {
        case "×":
            display.text = String(Int((operationG as NSString).doubleValue * operandStack.removeLast()))
        case "÷":
            display.text = String(Int((operationG as NSString).doubleValue / operandStack.removeLast()))
        case "+":
            display.text = String(Int((operationG as NSString).doubleValue + operandStack.removeLast()))
        case "−":
            display.text = String(Int((operationG as NSString).doubleValue - operandStack.removeLast()))
        default:
            break
        }
    }
    
    func enter() {
        
        userIsInNumber = false
        operandStack.append(displayValue)
        print("operandStack的元素值：\(operandStack)")
    }
    
}

