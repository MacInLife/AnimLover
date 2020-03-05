//
//  MovieTableViewCell.swift
//  AnimLover
//
//  Created by Marie-Ange Coco on 05/03/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    
    func setUp(with movie: Movie) {
        posterImageView.image = UIImage(data: movie.poster)
        titleLabel.text = movie.title
        releaseYearLabel.text = movie.releaseYear
    }
}
