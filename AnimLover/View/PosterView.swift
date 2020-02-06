//
//  PosterView.swift
//  AnimLover
//
//  Created by Marie-Ange Coco on 23/01/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import UIKit

class PosterView: UIView {

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var filterView: UIView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var releaseYear: UILabel!
    
    
    enum Style {
        case liked, unliked, neutral
    }
    
    //var style = Style.neutral
    var style: Style = .neutral {
        didSet {
            switch style {
            case .liked:
                filterView.backgroundColor = UIColor.alGreen
                filterView.alpha = 0.4
            case .unliked:
                filterView.backgroundColor = UIColor.alRed
                filterView.alpha = 0.4
            case .neutral:
                filterView.backgroundColor = UIColor.alBlack
                
            }
        }
    }
    var poster = Data() {
           didSet {
               imageView.image = UIImage(data: poster)
           }
       }
    var filter = Data() {
              didSet {
                  imageView.image = UIImage(data: poster)
              }
          }
    var title = String() {
        didSet{
            movieTitleLabel.text = title
        }
    }
    var year = String() {
        didSet{
            print("Année :", year)
            releaseYear.text = year
        }
    }
}
