//
//  EditView.swift
//  Lab3
//
//  Created by Nuraliev's Macbook on 3/7/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import UIKit

func validation(_ vx: CGFloat,_ vy: CGFloat) -> Bool {
      let size = UIScreen.main.bounds
      let dw = size.width
      let dh = size.height
      
    if vx>dw || vy>dh || vx<0 || vy<0{
          return false
      }

      return true;
  }
  
class EditView: UIViewController {
    
    var color: UIColor?
    var chosen: UIView?
    
    
    var onAdd: ((_ v: UIView) -> Void)? = nil

    @IBOutlet weak var DeleteBut: UIBarButtonItem!
    @IBOutlet weak var Width: UITextField!
    @IBOutlet weak var Height: UITextField!
    @IBOutlet weak var Xvalue: UITextField!
    @IBOutlet weak var Yvalue: UITextField!
    
    @IBOutlet weak var RedBut: UIButton!
    @IBOutlet weak var BlueBut: UIButton!
    @IBOutlet weak var PurpleBut: UIButton!
    @IBOutlet weak var YellowBut: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let v = chosen
            else{
                DeleteBut.isEnabled = false
                return
                
        }
        
        Width.text = v.frame.width.description
        Height.text = v.frame.height.description
        Xvalue.text = v.frame.origin.x.description
        Yvalue.text = v.frame.origin.y.description
        view.subviews.forEach{
            if $0.backgroundColor==v.backgroundColor{
                ($0 as? UIButton)?.isSelected = true
                color = $0.backgroundColor
            }
        }
        
        
    }
    
    @IBAction func _save(_ sender: Any) {
        guard
            let wText = Double(Width.text!),
            let hText = Double(Height.text!),
            let xText = Double(Xvalue.text!),
            let yText = Double(Yvalue.text!),
            let c = color
            else {
                let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля",  preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
                }
        
        if chosen != nil{
            
            if validation(CGFloat(xText), CGFloat(yText)) == false{
                let alert = UIAlertController(title: "Ошибка", message: "Координаты не уместны",  preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            else{
                chosen?.backgroundColor = c
                chosen?.frame = CGRect(x: xText, y: yText, width: wText, height: hText)
            }
           
        }
        else{
            
            
            if validation(CGFloat(xText), CGFloat(yText)) == false{
                let alert = UIAlertController(title: "Ошибка", message: "Координаты не уместны",  preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            else{
                let rectangle = CGRect(x:xText, y:yText, width: wText, height: hText)
                let view = UIView(frame: rectangle)
                view.backgroundColor = c
                self.onAdd?(view)
            }
            
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func ColorChoose(_ sender: UIButton) {
        guard let c = sender.backgroundColor else {
            return
        }
        color = c
        view.subviews.forEach { ($0 as? UIButton)?.isSelected = false }
        
        sender.isSelected = true
            
    }
   
    @IBAction func Delete(_ sender: UIBarButtonItem) {
        guard let f = chosen
            else
            {return}
        
        f.removeFromSuperview()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
