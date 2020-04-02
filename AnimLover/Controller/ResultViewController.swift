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
    var selectedMovie: Movie?
    
    @IBOutlet weak var TableView: UITableView!
    
    @IBAction func restart(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        //print(movies)
        //print()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           TableView.reloadData()
           TableView.allowsSelection = true
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard segue.identifier == "toDetail", let selectedMovie = self.selectedMovie else { return }

       let detailVC = segue.destination as! DetailViewController
       detailVC.movies = selectedMovie

   }
 
 
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
extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("DELETE")
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SELECT")
        
        self.selectedMovie = movies[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
}
