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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
               print(movies.title)
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
