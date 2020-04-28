//
//  MusicService.swift
//  FileSystem
//
//  Created by Nuraliev's Macbook on 4/28/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import Foundation
import AVFoundation

class MusicService {
    // MARK: - Variables
    static let shared = MusicService()
    var player: AVPlayer?
    var cur_path: String?
    
    // MARK: - Methods
    func searchForMusic(title:String,completion: @escaping (MusicSearchResponse?, Error?) -> ()) {
        let url = URL(string: "https://itunes.apple.com/search?term=\(title)&entity=song")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MusicSearchResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(response, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    
    func play(track: Track) {
        let playerItem: AVPlayerItem
        guard let path = cur_path else { return }
        
        switch isDownloaded(track: track) {
        case true:
            print("play from file")
            playerItem = .init(url: getFileUrl(for: track, cur_path: path))
        case false:
            print("play from url")
            playerItem = .init(url: track.previewUrl)
        }

        self.player = AVPlayer(playerItem:playerItem)
        player?.volume = 1.0
        player?.play()
    }
    
    func playFromDirectory(url:URL){
        let playerItem: AVPlayerItem
        playerItem = .init(url: url)
        self.player = AVPlayer(playerItem:playerItem)
        player?.volume = 1.0
        player?.play()
    }
    func pause(){
        player?.pause()
    }
    func play_pause() {
        player?.play()
    }
    func isDownloaded(track: Track) -> Bool {
        guard let path = cur_path else { return false }
        return FileManager.default.fileExists(atPath: getFileUrl(for: track, cur_path: path).path)
    }
    
    func download(cur_path: String, track: Track, completion: @escaping (URL?, Error?) -> ()) {
        print("In")
        URLSession.shared.downloadTask(with: track.previewUrl) { tempURL, _, error in
            if let tempURL = tempURL {
                do {
                    let url = self.getFileUrl(for: track, cur_path: cur_path)
                    try FileManager.default.moveItem(at: tempURL, to: url)
                    print("successfully downloaded: \(track.trackName)")
                    DispatchQueue.main.async {
                        completion(url, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    func getFileUrl(for track: Track, cur_path: String) -> URL {
        let documentsDirectoryURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let url = documentsDirectoryURL.appendingPathComponent(cur_path+"/"+track.previewUrl.lastPathComponent)
        
        return url
    }
    
    
    
    // MARK: - Response
    class MusicSearchResponse: Codable {
        var tracks: [Track]
        
        enum CodingKeys: String, CodingKey {
            case tracks = "results"
        }
    }
}
