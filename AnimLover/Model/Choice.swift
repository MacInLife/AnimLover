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
        MovieService.shared.getDiscovernMovies { (error, movies) in
            if let error = error {
                var notification: Notification
                if error == MovieService.MovieError.connection {
                    notification = Notification(name: .errorConnection)
                } else {
                        notification = Notification(name: .errorUndefined)
                }
                    NotificationCenter.default.post(notification)
            }
//      Informer que nous avons les films
            guard let movies = movies else {
                let notification = Notification(name: .errorUndefined)
                NotificationCenter.default.post(notification)
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
        
        //Logique métier déterminant le choix
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
    static let errorUndefined = Notification.Name("Erreur indéfini")
    static let errorConnection = Notification.Name("Erreur de connection")
}
