//
//  DetailMovie.swift
//  Lab
//
//  Created by Nuraliev's Macbook on 4/8/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import Foundation


class MovieDetailService {
    //MARK: - Outlets

    // MARK: - Variables
    static let shared = MovieDetailService()
    
    // MARK: - Methods
    func downloadMovies(id: String, completion: @escaping (DownloadDetailResponse) -> Void) {
        guard let url = URL(string: "http://www.omdbapi.com/?apikey=a22a9299&i=\(id)&r=json") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(DownloadDetailResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(response)
                }

            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    class DownloadDetailResponse: Codable {
        var title: String;
        var year: String;
        var genre: String;
        var poster: String;
        var imdbRating: String;
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case year = "Year"
            case genre = "Genre"
            case poster = "Poster"
            case imdbRating = "imdbRating"
            
        }
    }
}
