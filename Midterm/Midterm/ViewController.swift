//
//  ViewController.swift
//  Midterm
//
//  Created by Nuraliev's Macbook on 3/7/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ChooseSector(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard
            let selectVC = storyboard.instantiateViewController(identifier: "select") as? SelectColorViewController
        else { return }
        
        selectVC.onSelect = { color in
            
            sender.backgroundColor = color
            
        }
        
        self.present(selectVC, animated: true)

    }
    

}

