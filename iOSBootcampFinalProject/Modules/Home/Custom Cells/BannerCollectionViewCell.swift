//
//  BannerCollectionViewCell.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 01/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var bannerLabel: UILabel!
    
    static let identifier = "BannerCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BannerCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bannerLabel.layer.cornerRadius = 15
        bannerLabel.clipsToBounds = true
        bannerImageView.layer.cornerRadius = 30
        bannerImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
           bannerImageView.image = nil
           bannerLabel.text = ""
       }
    
    func configure(_ data: MovieData?){
        
        if let posterPath = data?.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath){
            bannerImageView.downloadedFrom(url: url)
        }
        bannerLabel.text = ("  \(data?.title ?? "")  ")
        
    }

}
