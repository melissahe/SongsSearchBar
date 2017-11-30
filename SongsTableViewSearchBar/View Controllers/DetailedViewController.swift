//
//  DetailedViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var songAndArtistNavigationItem: UINavigationItem!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songArtistLabel: UILabel!
    
    var song: Song!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songAndArtistNavigationItem.title = "\(song.name) - \(song.artist)"
        songImageView.image = #imageLiteral(resourceName: "loveSongs")
        songTitleLabel.text = song.name
        songArtistLabel.text = song.artist
    }
    
}
