//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    //Table View Data Source Variable
    @IBOutlet weak var songTableView: UITableView!
    
    var songs: [Song] = []
    
    //Search Bar Variables
    var filteredSongs: [Song] {
        guard let searchTerm = searchTerm, searchTerm != "" else {
            return songs
        }
        
        let selectedScopeIndex = searchBar.selectedScopeButtonIndex
        let filteringCriteria = searchBar.scopeButtonTitles![selectedScopeIndex]
        
        switch filteringCriteria {
        case "Title":
            return songs.filter{$0.name.lowercased().contains(searchTerm)}
        case "Artist":
            return songs.filter{$0.artist.lowercased().contains(searchTerm)}
        default:
            return songs
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchTerm: String? {
        didSet {
            songTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        songTableView.delegate = self
        songTableView.dataSource = self
        searchBar.delegate = self
    }
    
    func loadData() {
        songs = Song.loveSongs
    }

    //MARK: - Table View Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "DetailedViewSegue", sender: selectedCell)
    }
    
    
    //MARK: - Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let currentSong = filteredSongs[indexPath.row]
        
        cell.textLabel?.text = currentSong.name
        cell.detailTextLabel?.text = currentSong.artist
        
        return cell
    }
    
    
    //MARK: - Search Bar Delegate Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        songTableView.reloadData()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedCell = sender as? UITableViewCell, let currentIndexPath = songTableView.indexPath(for: selectedCell) else {
            return
        }
        
        if segue.identifier == "DetailedViewSegue", let destinationVC = segue.destination as? DetailedViewController {
            destinationVC.song = songs[currentIndexPath.row]
        }
        
    }
    
}

