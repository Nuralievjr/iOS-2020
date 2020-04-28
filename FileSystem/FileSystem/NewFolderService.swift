//
//  NewFolderService.swift
//  FileSystem
//
//  Created by Nuraliev's Macbook on 4/27/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import Foundation

class NewFolderService{
    static let shared = NewFolderService()
    
    func createFolder(title: String,completion: @escaping (String) -> Void){
        
        DispatchQueue.main.async {
            completion(title)
        }
    }

}
