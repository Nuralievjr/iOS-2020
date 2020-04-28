//
//  MusicPlayerViewController.swift
//  FileSystem
//
//  Created by Nuraliev's Macbook on 4/28/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import UIKit

class MusicPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    @IBAction func play(_ sender: UIButton) {
        MusicService.shared.play_pause()

    }
    
    @IBAction func pause(_ sender: UIButton) {
        MusicService.shared.pause()
    }
}
