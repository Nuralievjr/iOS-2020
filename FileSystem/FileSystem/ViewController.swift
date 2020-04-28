//
//  ViewController.swift
//  FileSystem
//
//  Created by Nuraliev's Macbook on 4/26/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import UIKit
import AVFoundation

var currentDirectory: String = ""



class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var filenames = [String]()
    var urls = [URL]()
    

    
    var forDeletePaths = [URL]()
    
    var RemoveMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let addButton   = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addFolder))
        let deleteButton   = UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(getRemoveMode))
        let downloadBtn = UIBarButtonItem(image: UIImage(systemName: "music.note.list") , style: .plain, target: self, action: #selector(ToMusic))
        navigationItem.rightBarButtonItems = [addButton, deleteButton, downloadBtn]
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        changeCurrentDicectory(title: nil)
        reloadDirectory(currentDirectory)
        

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (self.isMovingFromParent) {
            let url = URL(string: currentDirectory)
            currentDirectory = url!.deletingLastPathComponent().absoluteString
        }
    }
    
   
    
    @objc private func ToMusic() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let selectVC = storyboard.instantiateViewController(identifier: "musicVC") as? SearchMusicTableViewTableViewController
        else { return }
        
        selectVC.currentPath = currentDirectory

        navigationController?.pushViewController(selectVC, animated: true)

    }

    
    @objc private func addFolder() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
        guard
            let selectVC = storyboard.instantiateViewController(identifier: "addFolderID") as? NewFolderViewController
        else { return }
        selectVC.currentPath = currentDirectory
        
        navigationController?.pushViewController(selectVC, animated: true)

    }
    
    @objc private func getRemoveMode() {
        self.RemoveMode = true
        let ok = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(removeFolders))
        navigationItem.rightBarButtonItems = [ok]
    }
    
    @objc private func removeFolders(){
        for path in self.forDeletePaths{
            try? FileManager.default.removeItem(at: path)

        }
        
        let cells = collectionView.visibleCells
        for cell in cells{
            cell.layer.borderWidth = 0
            cell.layer.borderColor = .none
            
        }

        reloadDirectory(currentDirectory)
       
        self.RemoveMode = false
        let addButton   = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addFolder))
        let deleteButton   = UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(getRemoveMode))
        let downloadBtn = UIBarButtonItem(image: UIImage(systemName: "music.note.list") , style: .plain, target: self, action: #selector(ToMusic))
        navigationItem.rightBarButtonItems = [addButton, deleteButton, downloadBtn]
        
    }
    
    
    
    func changeCurrentDicectory(title: String?){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "folderIn")
        
        

        guard let title = title else { return }
        currentDirectory += title+"/"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func reloadDirectory(_ newPath: String){
        let fileManager = FileManager.default

        var currentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        if newPath != ""{
            currentURL.appendPathComponent(newPath, isDirectory: true)
        }

            do {

                let fileURLs = try fileManager.contentsOfDirectory(at: currentURL, includingPropertiesForKeys: nil)
                for fileurl in fileURLs{

                    urls.append(fileurl)
                    let filename = fileurl.lastPathComponent
                    if !filenames.contains(filename){
                    filenames.append(filename)
                    }
                    if !urls.contains(fileurl){
                    urls.append(fileurl)
                    }
                    
                    
                }
                self.collectionView.reloadData()

            } catch {
                print("Error while enumerating files \(currentURL.path): \(error.localizedDescription)")
                
            }
              
    }
    

    


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filenames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "folder", for: indexPath) as! FolderCellCollectionViewCell
        
        cell.title = self.filenames[indexPath.item]
        if self.urls[indexPath.item].pathExtension == "m4a"{
            cell.imageView.image = UIImage(systemName: "music.note")
        }
        else{
            cell.imageView.image = UIImage(systemName: "folder")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 120
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        

        if RemoveMode{
            
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor.gray.cgColor
            self.forDeletePaths.append(self.urls[indexPath.item])
            self.filenames.remove(at: indexPath.item)
            
        }
        else{
            if self.urls[indexPath.item].pathExtension == "m4a"{
                    
                    MusicService.shared.playFromDirectory(url: self.urls[indexPath.item])
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(identifier: "musicPlayerId")
            
                    navigationController?.pushViewController(vc, animated: true)
            }
            else{
                changeCurrentDicectory(title:self.filenames[indexPath.item])
            }
            
        }
    }
}


