//
//  DetailScreenViewController.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 02/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class DetailScreenViewController: UIViewController {
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var voteCountLabel: UILabel!
    
    @IBOutlet weak var overviewTextView: UITextView!
    
    var data : MovieData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //        movieTitle.text = data?.title
        //        voteLabel.text = "\((data?.vote_average) ?? 0)"
        //        voteCountLabel.text = "\((data?.vote_count) ?? 0)"
        //        languageLabel.text = data?.original_language
        //        overviewTextView.text = data?.overview
        if let movieImagePath = data?.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/w500" + movieImagePath){
            movieImage.downloadedFrom(url: url)
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
