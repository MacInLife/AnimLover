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
    @IBOutlet weak var backgroundGradientView: UIView!
    
    @IBAction func restart(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        //print(movies)
        //print()
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
             
        //  Horizontal: de  gauche  à  droite.
             gradientLayer.startPoint = CGPoint(x: 0, y: 0.5) //  Côté gauche
             gradientLayer.endPoint = CGPoint(x: 1, y: 0.5) //  Côté droit
        TableView.backgroundColor = .none
        
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           TableView.reloadData()
           TableView.allowsSelection = true
        // Set the background color to match better
  
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
        //Ajout du fond blanc opacity 0.5
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
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
