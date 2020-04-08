//
//  MovieService.swift
//  Lab
//
//  Created by Nuraliev's Macbook on 4/7/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import Foundation


class MovieService {
    // MARK: - Variables
    static let shared = MovieService()
    
    // MARK: - Methods
    func downloadMovies(page: Int, search: String,completion: @escaping (DownloadFilmsResponse) -> Void) {
        guard let url = URL(string: "http://www.omdbapi.com/?apikey=a22a9299&s=\(search)&r=json&page=\(page)") else { return }
        
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
                let response = try decoder.decode(DownloadFilmsResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(response)
                }

            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    class DownloadFilmsResponse: Codable {
        var movies: [Movie]
        var totalResults: String
        
        enum CodingKeys: String, CodingKey {
            case movies = "Search"
            case totalResults
        }
    }
}
