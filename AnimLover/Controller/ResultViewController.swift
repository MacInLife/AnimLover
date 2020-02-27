//
//  ContinuationViewController.swift
//  AnimLover
//
//  Created by Marie-Ange Coco on 30/01/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var movies: [Movie]!
    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(movies)
        //print()
        // Do any additional setup after loading the view.
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
extension ResultViewController: UITableViewDataSource {
     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return movies.count
     }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
         let movie = movies[indexPath.row]
         cell.textLabel?.text = movie.title
         return cell
     }
 }
