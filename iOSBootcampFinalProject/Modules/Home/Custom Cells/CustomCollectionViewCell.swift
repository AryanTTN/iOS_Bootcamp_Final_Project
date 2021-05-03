//
//  CustomCollectionViewCell.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 30/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var labelContainer: UIView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    
    static let identifier = "CustomCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CustomCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        moviePosterImage.layer.cornerRadius = 10
        moviePosterImage.clipsToBounds = true
        labelContainer.layer.cornerRadius = 10
        labelContainer.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        moviePosterImage.image = nil
        movieNameLabel.text = ""
        secondaryLabel.text = ""
    }
    
    func configure(_ data: MovieData?){
        
        if let posterPath = data?.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath){
            moviePosterImage.downloadedFrom(url: url)
        }
        movieNameLabel.text = data?.title
        secondaryLabel.text = data?.release_date
    }
}

