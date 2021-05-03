//
//  CustomTableViewCell.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 30/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

protocol CustomTableCellProtocol: AnyObject where Self: UITableViewDelegate {
    func cellTapped(sectionIndex: Int, itemIndex: Int)
}


class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: CustomTableCellProtocol?
    var cellIndex: Int = 0
    var movieData: [MovieData]?
    
    static let identifier = "CustomTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CustomTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        expandButton.isHidden = true
       // self.selectionStyle = .none
        genreCollectionView.register(CustomCollectionViewCell.nib(), forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        genreCollectionView.layer.cornerRadius = 10
        genreCollectionView.layer.shadowColor = UIColor.gray.cgColor
        genreCollectionView.layer.shadowOpacity = 1
        genreCollectionView.layer.shadowOffset = .zero
        genreCollectionView.layer.shadowRadius = 10
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ data: HomeData){
        titleLabel.text = data.sectionTitle
        movieData = data.movieData
        genreCollectionView.reloadData()
        //buttonAction()
    }
//    func buttonAction() {
//        collectionViewHeightConstraint.constant = expandButton.isSelected ? 0 : 260
//        expandButton.isSelected = !expandButton.isSelected
//    }
    
}

extension CustomTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = genreCollectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.configure(movieData?[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cellTapped(sectionIndex: cellIndex, itemIndex: indexPath.row)
    }
    
}


