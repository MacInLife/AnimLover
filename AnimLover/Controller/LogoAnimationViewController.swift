//
//  LogoAnimationViewController.swift
//  AnimLover
//
//  Created by Marie-Ange Coco on 02/04/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import UIKit

class LogoAnimationViewController: UIViewController {
    var movies: [Movie]!

    @IBOutlet weak var logoAnimation: UIImageView!
    @IBOutlet weak var backgroundGradientView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shortLogoOpening()
        // Do any additional setup after loading the view.
        
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
        
    // Diagonal: top left to bottom corner.
      //  gradientLayer.startPoint = CGPoint(x: 0, y: 0) // Top left corner.
       // gradientLayer.endPoint = CGPoint(x: 1, y: 1) // Bottom right corner.
        
   //  Horizontal: de  gauche  à  droite.
       // gradientLayer.startPoint = CGPoint(x: 0, y: 0.5) //  Côté gauche
       // gradientLayer.endPoint = CGPoint(x: 1, y: 0.5) //  Côté droit
    }
//    override var shouldAutorotate: Bool {
//         return false
//     }
    
   
    
    private func shortLogoOpening() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [], animations: {
            let scaleTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.logoAnimation.transform = scaleTransform
           
    
        }) { (success) in
            if success {
                UIView.animate(withDuration: 0.6, delay: 0.4, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: [], animations: {
                    let scaleTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    self.logoAnimation.transform = scaleTransform
                    self.logoAnimation.alpha = 0
                }) { (success) in
                    if success {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                           // self.userInterface.isHidden = false
                            self.logoAnimation.transform = .identity
                            self.performSegue(withIdentifier: "segueToChoice", sender: nil)
                        }
                    }
                }
            }
        }
    }


}
