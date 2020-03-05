//
//  DetailViewController.swift
//  AnimLover
//
//  Created by Marie-Ange Coco on 05/03/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var movies: Movie!
  
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
     override func viewDidLoad() {
         super.viewDidLoad()

         // Do any additional setup after loading the view.
         print(movies.title)
        print(movies.releaseYear)
        print(movies.description)
        
        posterImageView.image = UIImage(data: movies.poster)
              titleLabel.text = movies.title
              releaseYearLabel.text = movies.releaseYear
            descriptionLabel.text = movies.description
     }
    
}
