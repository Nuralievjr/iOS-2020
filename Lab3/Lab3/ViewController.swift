//
//  ViewController.swift
//  Lab3
//
//  Created by Nuraliev's Macbook on 3/6/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func ToEdit(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
        guard
            let selectVC = storyboard.instantiateViewController(identifier: "edit") as? EditView
        else { return }
            
        selectVC.onAdd = { [weak self] rect in
            guard let self = self else { return }
            self.view.addSubview(rect)
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.figureDidTap))
            rect.addGestureRecognizer(tapGestureRecognizer)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.figureDidPan(recognizer:)))
            rect.addGestureRecognizer(panGestureRecognizer)
            
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.figureDidPinch))
            rect.addGestureRecognizer(pinchGestureRecognizer)
        }
        
        
        
        navigationController?.pushViewController(selectVC, animated: true)

        }
    
        @objc func figureDidTap(_ recognizer: UITapGestureRecognizer) {
            let nv = recognizer.view!
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let edtview = storyboard.instantiateViewController(identifier: "edit") as EditView
            edtview.chosen = nv
            navigationController?.pushViewController(edtview, animated: true)
        }
    
        var baseOrigin: CGPoint!
        @objc func figureDidPan(recognizer: UIPanGestureRecognizer) {
            let nv = recognizer.view!
            let translation = recognizer.translation(in: view)
            switch recognizer.state {
            case .changed:
                nv.center = CGPoint(x: nv.center.x + translation.x, y: nv.center.y + translation.y)
                recognizer.setTranslation(CGPoint.zero, in: view)
            default:
                break
            }
        }
        @objc func figureDidPinch(_ recognizer: UIPinchGestureRecognizer) {
            recognizer.view?.transform = ((recognizer.view?.transform.scaledBy(x: recognizer.scale, y: recognizer.scale))!)
            recognizer.scale = 1
        }
    }
    
    
        
    
    
 


