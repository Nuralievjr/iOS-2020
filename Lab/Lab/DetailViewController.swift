//
//  DetailViewController.swift
//  Lab
//
//  Created by Nuraliev's Macbook on 4/8/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    var id = ""
    
    override func viewDidLoad() {
        load()
    }
    
    func load() {
        MovieDetailService.shared.downloadMovies(id: id) { response in
            
            self.titleDetail.text = response.title
            self.year.text = response.year
            self.genre.text = response.genre
            self.rating.text = response.imdbRating
            
            ImageService.shared.downloadImage(url: response.poster) { image in
                self.poster.image = image
            }
        }
    }

}
