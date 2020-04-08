//
//  File.swift
//  Lab
//
//  Created by Nuraliev's Macbook on 4/7/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    // MARK: - Variables
    var movie: Movie! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Methods
    func updateUI() {
        self.title.text = movie.title
        self.Description.text = movie.year
        
        ImageService.shared.downloadImage(url: movie.posterURL) { image in
            self.poster.image = image
        }
    }
}
