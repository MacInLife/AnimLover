//
//  LogoAnimationViewController.swift
//  AnimLover
//
//  Created by Marie-Ange Coco on 02/04/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import UIKit

class LogoAnimationViewController: UIViewController {

    @IBOutlet weak var logoAnimation: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shortLogoOpening()
        // Do any additional setup after loading the view.
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard segue.identifier == "segueToChoice" else { return }
        }
    
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
                        }
                    }
                }
            }
        }
    }


}
