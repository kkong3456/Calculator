//
//  ViewController.swift
//  Calculator
//
//  Created by admin on 2022/10/02.
//

import UIKit

enum Operation{
  case Add
  case Subtract
  case Divide
  case Multiply
  case unknown
}

class ViewController: UIViewController {
  
  @IBOutlet weak var numberOutputLabel: UILabel!
  
  var displayNumber=""
  var firstOperand=""
  var secondOperand=""
  var result=""
  var currentOperation:Operation = .unknown
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func tapNumberButton(_ sender: RoundButton) {
    guard let numberValue=sender.title(for:.normal) else {return}
    if self.displayNumber.count<9{
      self.displayNumber+=numberValue
      self.numberOutputLabel.text=self.displayNumber
    }
  }
  
  @IBAction func tapClearButton(_ sender: RoundButton) {
    self.displayNumber=""
    self.firstOperand=""
    self.secondOperand=""
    self.result=""
    self.currentOperation = .unknown
    self.numberOutputLabel.text="0"
  }
  @IBAction func tapDotButton(_ sender: RoundButton) {
    if self.displayNumber.count<8,!self.displayNumber.contains("."){
      self.displayNumber+=self.displayNumber.isEmpty ? "0." : "."
      self.numberOutputLabel.text=self.displayNumber
    }
    
  }
  @IBAction func tapDivideButton(_ sender: RoundButton) {
    self.operation(.Divide)
  }
  @IBAction func tapMultiplyButton(_ sender: RoundButton) {
    self.operation(.Multiply)
  }
  @IBAction func tapSubtractButton(_ sender: RoundButton) {
    self.operation(.Subtract)
  }
  @IBAction func tapAddButton(_ sender: RoundButton) {
    self.operation(.Add)
  }
  
  @IBAction func tapEqualButton(_ sender: RoundButton) {
    self.operation(self.currentOperation)
  }
  
  func operation(_ operation:Operation){
    if self.currentOperation != .unknown{
      if !self.displayNumber.isEmpty{
        
        self.secondOperand=self.displayNumber
        self.displayNumber=""
        
        guard let firstOperand=Double(self.firstOperand) else {return}
        guard let secondOperand=Double(self.secondOperand) else {return}
        
        switch self.currentOperation {
          case .Add:
            self.result="\(firstOperand + secondOperand)"
            break
          case .Subtract:
            self.result="\(firstOperand -  secondOperand)"
            break
          case . Divide:
            self.result="\(firstOperand / secondOperand)"
            break
          case .Multiply:
            self.result="\(firstOperand * secondOperand)"
            break
          default:
            break
        }
        
        if let result=Double(self.result),result.truncatingRemainder(dividingBy: 1)==0{
          self.result="\(Int(result))"
        }
      
        self.firstOperand=self.result
        self.numberOutputLabel.text=self.result
      }
    self.currentOperation=operation
      
    }else{
      self.firstOperand=self.displayNumber
      self.currentOperation=operation
      self.displayNumber=""
    }
  }
}

