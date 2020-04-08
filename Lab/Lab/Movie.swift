//
//  Movie.swift
//  Lab
//
//  Created by Nuraliev's Macbook on 4/7/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import Foundation

class Movie: Codable {
    var title: String
    var type: String
    var year: String
    var id: String
    var posterURL: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case type = "Type"
        case year = "Year"
        case id = "imdbID"
        case posterURL = "Poster"
    }
}
