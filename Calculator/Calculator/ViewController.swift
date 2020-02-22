//
//  ViewController.swift
//  Calculator
//
//  Created by Nuraliev's Macbook on 1/25/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    let model = Calculator();
    var corrector = false
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func numberPressed(_ sender: UIButton) {
        guard
            let numberText = sender.titleLabel?.text
            else {return}
        if resultLabel.text == "0" || resultLabel.text == "0.0" || corrector == true{
            resultLabel.text = ""
        }
        corrector = false
        resultLabel.text?.append(numberText)
        
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
       guard
            let operation = sender.titleLabel?.text,
            let numberText = resultLabel?.text,
            let number = Double(numberText)
       else {
           return
       }
        resultLabel.text = "0"
        model.setOperand(number: number)
        model.executeOperation(symbol: operation)

        if operation == "=" {
            resultLabel.text = "\(model.result)"
            corrector = true
        }

        if operation == "pi" || operation == "sqrt" || operation == "x!" ||  operation == "%" ||  operation == "1/x"{
            resultLabel.text = "\(model.result)"
        }
        
       
    }
    
    @IBAction func Clear(_ sender: UIButton) {
        
        resultLabel.text = "0"
    }
}

