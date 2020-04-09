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
  
  
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backgroundGradientView: UIView!
    
    
     override func viewDidLoad() {
         super.viewDidLoad()
              // Créer un calque de dégradé .
                 let gradientLayer = CAGradientLayer()
                      // Régler la taille de la couche à être égale à la taille de l' écran.
                 gradientLayer.frame = view.bounds
               //  Définir  un  tableau  de  couleurs Core  Graphics  (.cgColor) pour créer le dégradé. // Cet exemple utilise un Color Literal et un UIColor à partir des valeurs RVB .
                 gradientLayer.colors = [#colorLiteral(red: 0.4784313725, green: 0.5019607843, blue: 0.5843137255, alpha: 1).cgColor,#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1).cgColor ,#colorLiteral(red: 0.4784313725, green: 0.5019607843, blue: 0.5843137255, alpha: 1).cgColor]
             //  Rastérisez  cette  couche statique  pour améliorer les performances de l' application .
                 gradientLayer.shouldRasterize = true
                // Appliquer le gradient de la backgroundGradientView.
                 backgroundGradientView.layer.addSublayer(gradientLayer)
             
        //  Horizontal: de  gauche  à  droite.
             gradientLayer.startPoint = CGPoint(x: 0, y: 0.5) //  Côté gauche
             gradientLayer.endPoint = CGPoint(x: 1, y: 0.5) //  Côté droit
         // Do any additional setup after loading the view.
         print(movies.title)
        print(movies.releaseYear)
        print(movies.description)
        
        posterImageView.image = UIImage(data: movies.poster)
        titleLabel.text = movies.title
        releaseYearLabel.text = movies.releaseYear
        descriptionLabel.text = movies.description
        
        navigationController?.setNavigationBarHidden(false, animated: true)
     }
    override func viewWillDisappear(_ animated: Bool){
        navigationController?.setNavigationBarHidden(true, animated: true)
    }//Life cycle hook (fonction qui serve au cycle de vie de la vue)
    
}
