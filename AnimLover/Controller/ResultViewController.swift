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
    
    @IBAction func restart(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       //  TableView.delegate = self
        //print(movies)
        //print()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           TableView.reloadData()
           TableView.allowsSelection = true
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }

        let movie = movies[indexPath.row]

        cell.setUp(with: movie)

        return cell
    }
 }
