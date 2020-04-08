//
//  ViewController.swift
//  Lab
//
//  Created by Nuraliev's Macbook on 4/7/20.
//  Copyright © 2020 Nuraliev's Macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var search: UITextField!
    
    
    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(downloadMovies), for: .valueChanged)
        
        return view
    }()
    
    // MARK: - Variables
    var movies: [Movie] = []
    
    // MARK: - Lifecyle
    var page = 1;
    var loadMoreStatus = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.search.text = "king"
        tableView.refreshControl = refreshControl

        tableView.delegate = self

        downloadMovies(page: page, search: self.search.text!)
        tableView.tableFooterView?.isHidden = true

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 0 {
            loadMore()
        }
    }
    
    func loadMore() {
        if ( !loadMoreStatus ) {
            self.loadMoreStatus = true
            tableView.tableFooterView?.isHidden = false
            page+=1
            downloadMovies(page: page, search: self.search.text!)
        }
    }
        
    
    
    
   
    @IBAction func dismissKey(_ sender: Any) {
        self.search.resignFirstResponder()
    }
    @IBAction func textChange(_ sender: UITextField) {
        downloadMovies(page: page, search: sender.text!)
       
    }
    
    // MARK: - Actions
    @objc func downloadMovies(page: Int, search: String) {
        
        MovieService.shared.downloadMovies(page: page, search: search) { response in
            if page==1{
                self.movies = response.movies
            }
            else{
                self.movies += response.movies

            }
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
            self.loadMoreStatus = false
            self.tableView.tableFooterView?.isHidden = true

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            if let indexpath = tableView.indexPathForSelectedRow {
            
                let destVC = segue.destination as! DetailViewController
                destVC.id = movies[indexpath.row].id
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie", for: indexPath) as! MovieTableViewCell
        cell.movie = self.movies[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
}

