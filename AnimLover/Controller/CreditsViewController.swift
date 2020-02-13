//
//  CreditsViewController.swift
//  AnimLover
//
//  Created by Marie-Ange Coco on 13/02/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBAction func shareDidPressed(_ sender: Any) {
        share()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func share() {
        let activityItems: [Any] = [
            UIImage(named: "Logo_AnimLover")!,
            URL(string: "https://ecole-webstart.com")!,
            "J'ai testé cette application, je vous la conseille !"
        ]
        let vc = UIActivityViewController(activityItems: activityItems, applicationActivities:[])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
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
