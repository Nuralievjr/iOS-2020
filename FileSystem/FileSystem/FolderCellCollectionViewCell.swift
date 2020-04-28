//
//  FolderCellCollectionViewCell.swift
//  FileSystem
//
//  Created by Nuraliev's Macbook on 4/26/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import UIKit

class FolderCellCollectionViewCell: UICollectionViewCell {
    
    var title: String? {
        didSet{
             guard let title = title else { return }
            titleFolder.text = title
        }
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleFolder: UILabel!
}
