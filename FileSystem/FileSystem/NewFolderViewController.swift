//
//  NewFolderViewController.swift
//  FileSystem
//
//  Created by Nuraliev's Macbook on 4/26/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import UIKit

class NewFolderViewController: UIViewController {

    @IBOutlet weak var createFolderButton: UIButton!
    @IBOutlet weak var newTitle: UITextField!
    
    var currentPath: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ok = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(createFolder(_:)))
        navigationItem.rightBarButtonItems = [ok]
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createFolder(_ sender: UIButton) {
        guard let newtitle = newTitle.text else {
            return
        }
        guard let curPath = currentPath else { return}
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        var docURL = URL(string: documentsDirectory)!
        docURL = docURL.appendingPathComponent(curPath)
        let dataPath = docURL.appendingPathComponent(newtitle)

        if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
                navigationController?.popViewController(animated: true)


            } catch {
                print(error.localizedDescription);
            }
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
