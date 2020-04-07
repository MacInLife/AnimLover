//
//  ViewController.swift
//  AnimLover
//
//  Created by Marie-Ange Coco on 28/11/2019.
//  Copyright © 2019 Marie-Ange Coco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var posterView: PosterView!
    @IBOutlet weak var labelSwipe: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backgroundGradientView: UIView!
    //    @IBAction func dragPosterView(_ sender: UIPanGestureRecognizer) {
//        switch sender.state {
//        case .began, .changed: print("began/changed")
//        case .ended, .cancelled: print("ended/cancelled")
//        default: break
//        }
//
//    }
    
    @IBAction func dragPosterView(_ sender: UIPanGestureRecognizer) {
            switch sender.state {
            case .began, .changed:
                transformPosterViewWith(gesture: sender)
                //print("began/changed")
            case .ended, .cancelled:
                //print("ended/cancelled")
                setUserChoiceFrom(gesture: sender)
            default: break
                
        }
    }
    
    
    var choice = Choice()
    private var likedMovies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //MovieService.shared.getDiscovernMovies()
        NotificationCenter.default.addObserver(self, selector:
            #selector(discoverMoviesLoaded), name:
            Notification.Name.discoverMoviesLoaded, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:
            #selector(likedMoviesLoaded( _:)), name:
            Notification.Name.likedMoviesLoaded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(presentNoMovieSelectedAlert), name: .noMovieSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(presentAlert(about:)), name: .apiError, object: nil)
        
        //choice.start()
        
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

    }
    override func viewWillAppear(_ animated: Bool) {
        self.posterView.isHidden = false
        self.labelSwipe.isHidden = false
        self.activityIndicator.isHidden = false
          choice.start()
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toResult" else { return }
//        let resultVC = segue.destination as! ResultViewController
//        resultVC.movies = likedMovies
        
        let tabVC = segue.destination as! UITabBarController
        let resultVC = tabVC.viewControllers![0] as! ResultViewController
        resultVC.movies = likedMovies
    }

    @objc func discoverMoviesLoaded() {
        //Afficher le premier film
        //print("Notification reçu")
        //print(choice.currentMovie)
        posterView.poster = choice.currentMovie.poster
        posterView.title = choice.currentMovie.title
        posterView.year = choice.currentMovie.releaseYear
        self.posterView.isHidden = false
        self.labelSwipe.isHidden = false
        self.activityIndicator.isHidden = true
    }
    
    @objc func likedMoviesLoaded(_ notification: NSNotification) {
        guard let movies = notification.userInfo?["likedMovies"] as? [Movie] else { return }
        likedMovies = movies
        performSegue(withIdentifier: "toResult", sender: nil)
      }
    @objc func presentConnectionAlert() {
        let alertVC = UIAlertController(title: "Pas de connexion internet", message: "Merci de vérifier votre connexion.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Recommencer", style: .default, handler: { action in
            self.choice.start()
//            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: [], animations: {
//                   // self.logoAnimation.transform = .identity
//                }) { (success) in
//                    self.choice.start()
//                }
        }))
        present(alertVC, animated: true, completion: nil)
    }
    @objc func presentUndefinedAlert() {
        self.posterView.isHidden = true
        self.labelSwipe.isHidden = true
        let alertVC = UIAlertController(title: "Erreur", message: "Erreur indéterminée.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Recommencer", style: .default, handler: { action in
            self.choice.start()
        }))
        present(alertVC, animated: true, completion: nil)
    }
    @objc func presentNoMovieSelectedAlert() {
        self.posterView.isHidden = true
        self.labelSwipe.isHidden = true
        let alertVC = UIAlertController(title: "Aucune sélection", message: "Vous n’avez sélectionné aucun film.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Recommencer", style: .default, handler: { (action) in
            self.choice.start()
        }))
        present(alertVC, animated: true, completion: nil)
    }
    @objc func presentAlert(about notification: Notification) {
        self.posterView.isHidden = true
        self.labelSwipe.isHidden = true
        print("ALERT ABOUT")
        guard let title = notification.userInfo?["title"] as? String,
            let message = notification.userInfo?["message"] as? String else {
            return
        }
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Recommencer", style: .default, handler: { (action) in
            self.choice.start()
        }))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func transformPosterViewWith(gesture: UIPanGestureRecognizer){
    // 1.0 Création du déplacement
        // Récupération du geste
        //Repérer les coordonnées du doigt dans l'écran
        let gestureTranslation = gesture.translation(in: posterView)
        print(gestureTranslation)
          //Donner ces coordonnées au posterView pour qu'il suive le doigt
          //Le doigt déplace le posterView
        let translationTransform = CGAffineTransform(translationX: gestureTranslation.x, y: gestureTranslation.y)
        
    // 2.0 Création de la rotation
        //Appliquer une légère rotation quand le posterView se déplace
        let screenWidth = UIScreen.main.bounds.width
        let ratioOfTranslationAndScreenWidth = gestureTranslation.x / (screenWidth / 2)
        //Angle de rotation
        let rotationAngle = (CGFloat.pi / 8) * ratioOfTranslationAndScreenWidth
        let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
        
    // 3.0 Combinaison du déplacement et de la rotation
        let transform = translationTransform.concatenating(rotationTransform)
        
    // 4.0 Application de la combinaison des deux transformations à la PosterView
        posterView.transform = transform
        
        posterView.style = gestureTranslation.x > 0 ? .liked : .unliked
        
    }
    private func setUserChoiceFrom(gesture: UIPanGestureRecognizer){
        //Récupération du geste et calcul du ration geste (1/4 de la largeur de l'écran)
        let gestureTranslation = gesture.translation(in: posterView)
               print(gestureTranslation)
        let screenWidth = UIScreen.main.bounds.width
        let ratioOfTranslationAndScreenWidth = gestureTranslation.x / (screenWidth / 4)
    

        //Tout stopper si le geste n'est pas significatif
        guard ratioOfTranslationAndScreenWidth < -1 || ratioOfTranslationAndScreenWidth > 1 else {
        posterView.transform = .identity
        posterView.style = .neutral
        return
        }
        
        //Régler le choix de l'utilisateur pour le film en cours
        switch posterView.style {
        case .liked: choice.setLikeOfCurrentMovie(with: true)
        case .unliked:
            choice.setLikeOfCurrentMovie(with: false)
            
        default: break
        }
        
         //Animer la sortie du posterView
        var translationTransform: CGAffineTransform
        var rotationTransform: CGAffineTransform
        let rotationAngle = (CGFloat.pi / 8)
        if posterView.style == .liked {
            rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
            translationTransform = CGAffineTransform(translationX: screenWidth, y: 0)
        } else {
            rotationTransform = CGAffineTransform(rotationAngle: -rotationAngle)
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
        }
       let transform = translationTransform.concatenating(rotationTransform)
              
        
        UIView.animate(withDuration: 0.3, animations:  {
            self.posterView.transform = transform
           // self.posterView.transform = translationTransform
        }) { (success) in
            guard success else { return }
            self.showPoster()
        }
    }
    
       
        private func showPoster(){
        //Replacer le posterView à sa place d'origine et passer un film suivant
                 posterView.transform = .identity
                 posterView.style = .neutral
                 
                 switch choice.state {
                 case .ongoing:
                     posterView.poster = choice.currentMovie.poster
                     posterView.movieTitleLabel.text = choice.currentMovie.title
                     posterView.releaseYear.text = choice.currentMovie.releaseYear
                 case .over:
                    //performSegue(withIdentifier: "toResult", sender: nil)
                     posterView.poster = Data()
                     posterView.movieTitleLabel.text = ""
                     posterView.releaseYear.text = ""
             }
            
            // Animer l'apparition du posterView
            posterView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 4, options: [], animations: {
                self.posterView.transform = .identity
            })
         }
        
     
   
}

