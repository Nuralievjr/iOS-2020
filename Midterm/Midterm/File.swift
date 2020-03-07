//
//  File.swift
//  Midterm
//
//  Created by Nuraliev's Macbook on 3/7/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import UIKit

class SelectColorViewController: UIViewController {
    
    var onSelect: ((UIColor) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func colorSelected(_ sender: UIButton) {
        if sender.titleLabel?.text == "RED" {
            self.onSelect?(UIColor.red)
        } else {
            self.onSelect?(UIColor.blue)
        }
        
        self.dismiss(animated: true)
    }
}
