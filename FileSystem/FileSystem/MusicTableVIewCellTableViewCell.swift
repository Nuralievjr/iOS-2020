//
//  MusicTableVIewCellTableViewCell.swift
//  FileSystem
//
//  Created by Nuraliev's Macbook on 4/28/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import UIKit


protocol TrackTableViewCellDelegate: class {
    func didPressPlay(track: Track)
    func didPressDownload(track: Track, completion: @escaping (Track) -> ())
}

class MusicTableVIewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    var track: Track! {
        didSet {
            self.nameLabel.text = track.trackName
            self.artistLabel.text = track.artistName
            
            let isDownloaded = MusicService.shared.isDownloaded(track: self.track)
            
            downloadButton.isUserInteractionEnabled = !isDownloaded
            downloadButton.isHidden = isDownloaded
        }
    }
    weak var delegate: TrackTableViewCellDelegate?
    
    @IBAction func play(_ sender: Any) {
        delegate?.didPressPlay(track: track)
    }
    
    
    @IBAction func download(_ sender: Any) {
        delegate?.didPressDownload(track: track) { track in
            self.track = track
        }
    }
    

}
