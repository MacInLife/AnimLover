//
//  Choice.swift
//  AnimLover
//
//  Created by Marie-Ange Coco on 09/01/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import Foundation

//Le choix sert à la gestion des cartes
class Choice {
    private var discoverMovies = [Movie]()
    private var currentIndex = 0
    private var likedMovies = [Movie]()
    
//Etat de l'avancement
    enum State {
        case ongoing, over
    }
    var state: State = .ongoing
    
    //Film actuel
    var currentMovie: Movie {
        return discoverMovies[currentIndex]
    }
    func start() {
        likedMovies = [Movie]()
        currentIndex = 0
        state = .ongoing
        
        //Lancement de la requête
        MovieService.shared.getDiscoverMovies { (error, movies) in
            if let error = error {
                print("ERROR!!!!",error)
              var title: String
              var message: String
              switch error {
              case .connection:
//                        notification = Notification(name: .errorConnection)
                  print("connection error!!!!!")
                  title = "Pas de connexion internet"
                  message = "Merci de vérifier votre connexion."
              case .response:
//                        notification = Notification(name: .errorResponse)
                  title = "Erreur dans la réponse"
                  message = "La réponse de l’API n’est pas correcte."
              case .statusCode:
//                        notification = Notification(name: .errorStatusCode)
                  title = "Mauvais code de status"
                  message = "L’API a répondu avec un mauvais code de status."
              case .data:
//                        notification = Notification(name: .errorData)
                  title = "Mauvaises données"
                  message = "Les données renvoyées par l’API ne sont pas exploitables."
              case .pictures:
//                        notification = Notification(name: .errorPictures)
                  print("PICTURES!!!!")
                  title = "Erreur dans les affiches"
                  message = "Une ou plusieurs affiches n’ont pas pu être récupérées."
              
//                    notification = Notification(name: .errorUndefined)
                case .undefined:
//                        notification = Notification(name: .errorPictures)
                 print("Indéfinie!!!!")
                 title = "Erreur indéfinie"
                 message = "Une erreur est survenue."
              }
              
//                DÉPLACÉ, IL ÉTAIT DANS LE SWITCH
              NotificationCenter.default.post(name: .apiError, object: self, userInfo: ["title": title, "message": message])

//                AJOUTÉ :
              return
            }
//      Informer que nous avons les films
            guard let movies = movies, !movies.isEmpty else {
                           print("ERROR OF GETUPCOMINGMOVIES IN CHOICE")
                           let title = "Pas de film à l’affiche"
                           let message = "Les films prochainement à l’affiche n’ont pas été obtenus."
                           NotificationCenter.default.post(name: .apiError, object: self, userInfo: ["title": title, "message": message])
                           return
                       }
            
//            movies.forEach { (movie) in
//                print(movie.title)
//            }
            self.discoverMovies = Array(movies.shuffled().prefix(10))
//            print("------------------------------------")
//            self.discoverMovies.forEach{ (movie) in
//                print(movie.title)
//            }
            self.state = .ongoing
            
            let notification = Notification(name: .discoverMoviesLoaded)
            NotificationCenter.default.post(notification)
        }
    }
    func finish(){
        state = .over
        
        let likedMovies = discoverMovies.filter{ $0.isLiked == true }
        
        guard !likedMovies.isEmpty else {
                   let notification = Notification(name: .noMovieSelected)
                   NotificationCenter.default.post(notification)
                   return
               }
        //Logique métier déterminant le choix
        NotificationCenter.default.post(name: .likedMoviesLoaded, object: self, userInfo: ["likedMovies" : likedMovies])
       
    }
    private func goToNextMovie(){
        currentIndex < discoverMovies.count - 1 ? currentIndex += 1 : finish()
    }
    func setLikeOfCurrentMovie(with userChoise: Bool){
        currentMovie.setLike(with: userChoise)
        goToNextMovie()
    }
}

extension Notification.Name {
    static let discoverMoviesLoaded = Notification.Name("La découverte des films est en cours de chargement")
    static let likedMoviesLoaded = Notification.Name("Erreur de chargement des movies aimés")
    static let noMovieSelected = Notification.Name("Erreur de sélection des movies")
    static let apiError = Notification.Name("Erreur avec l'api !!")
}
