//
//  MovieService.swift
//  AnimLover
//
//  Created by Marie-Ange Coco on 12/12/2019.
//  Copyright © 2019 Marie-Ange Coco. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieService {
    private let movieApi = "https://api.themoviedb.org/3"
    private let picture = "https://image.tmdb.org/t/p/w200"
    private let apiKey = "29c2415582d443dae2eda12a8813084a"
//  - Remplacer cette requête par la nôtre (moi genre Animation, région FR, 2019)
//      api.themoviedb.org/3/discover/movie?api_key=29c2415582d443dae2eda12a8813084a&with_genre=16®ion=FR
//      api.themoviedb.org/3/discover/movie?api_key=29c2415582d443dae2eda12a8813084a&with_genre=16%C2%AEion=FR
    
//  Avant --> private let discoverUrl = URL (string: "\(movieApi)/discover/movie?api_key=\(apiKey)&with_genre=16&region=FR")!
//  Maintenant -->
    private var discoverUrl: URL {
        return URL(string: "\(movieApi)/discover/movie?api_key=\(apiKey)&with_genre=16&region=FR")!
    }
//  \(movieApi)/discover/movie?api_key=\(apiKey)&region=FR
    
//  Permet d'avoir une instance unique de MovieService
    static let shared = MovieService()
    private init() {}
    
    enum MovieError {
        case connection
        case undefined
        case response
        case statusCode
        case data
        case pictures
    }
    
//  - Remplacer le nom de la fermeture par la nôtre
    func getDiscoverMovies(completion: @escaping (MovieError?, [Movie]?) -> Void) {
        let task = URLSession.shared.dataTask(with: discoverUrl) { (data, response, error) in
//            DispatchQueue.main.async {
//
//            }
//            Traiter error - Vérifie que error vaut nil
            if let error = error as? URLError {
                if error.code == URLError.Code.notConnectedToInternet {
                    print("Erreur car pas de connexion à internet !")
                    
                    completion(MovieError.connection, nil)
                    return
                } else {
                    print("Erreur indéfini de l'image...")
                    completion(MovieError.undefined, nil)
                    return
                }
//                print("Erreur : ", error)
//                return
            }
//            Traiter response - Vérifie qu'il y a une réponse
             guard let response = response as? HTTPURLResponse
                else {
                    print("Erreur avec la réponse !")
                    completion(MovieError.response, nil)
                    return
            }
//             Vérifie que le Status Code vaut 200
            guard response.statusCode == 200 else {
                print("Erreur avec le Status Code : ", response.statusCode)
                completion(MovieError.statusCode, nil)
                return
            }
//            Traiter data (données)
            guard let data = data else {
                print("Erreur avec les données !")
                completion(MovieError.data, nil)
                return
            }
            print("data", JSON(data))
//              Récupérer la propriété "results" du JSON
            let results = JSON(data)["results"]
//              Créer un tableau vide
            var movies = [(title: String, posterPath: String, id: String, description: String, releaseYear: String)]()
//              Remplir le tableu movies
//              !!! Vérifier si aucune propriété n'est égale à null dans le JSON
            for movie in results.arrayValue {
                let title = movie["title"].stringValue
                let posterPath = movie["poster_path"].stringValue
                let id = movie["id"].stringValue
                let description = movie["overview"].stringValue
                let releaseDate = movie["release_date"].stringValue
                let releaseYear = "(\(releaseDate.split(separator: "-")[0]))" //"2019-01-17" devient ["2019", "01", "17"] > [0] = premiere chaine => "(2019)"
                
                movies.append((title: title, posterPath: posterPath, id: id, description: description, releaseYear: releaseYear))
            }
            //print(movies)
//          Pour chaque film de movies, récupérer le poster puis créer une instance de Movie
//          Cela se fera dans une boucle for movie in movies {...}
            var discoverMovies = [Movie]()
            
//          Créer un groupe de tâches
            let group = DispatchGroup()
            
            for movie in movies {
                group.enter()
//          Obtenir d'un poster
                self.getPoster(movie.posterPath) { (poster) in
                    guard let poster = poster else {
                        print("Erreur dans la boucle qui récupère les poster - ERROR IN GET POSTERS LOOP")
                        completion(MovieError.pictures, nil)
                        group.leave()
                        return
                    }
//          Créer l'instance de Movie appelée discoverMovie avec le Poster, le title, etc.
                    let discoverMovie = Movie(title: movie.title, poster: poster, releaseYear: movie.releaseYear, isLiked: nil, id: movie.id, description: movie.description)
                

//          Ajouter ce discoverMovie au tableau discoverMovies
                    discoverMovies.append(discoverMovie)
                    group.leave()
                }
                
            }
            
            group.notify(queue: DispatchQueue.main) {
                //Afficher la liste des films récupérer
//                 print(" dicoverMovies :", discoverMovies)
                //Afficher la liste de tous les films de l'API
//                for discoverMovie in discoverMovies {
//                    print("discoverMovies:", discoverMovie)
//                }
                //Afficher une boucle récupérant le titre et la données de chaques films
//                discoverMovies.forEach{ (discoverMovie) in
//                    print("Titre : ", discoverMovie.title)
//                    print("Données : ", discoverMovie.poster)
//                }
                
                completion(nil, discoverMovies)
            }
           
        }
        task.resume()
    }

    private func getPoster(_ posterPath: String, pictureCompletionHandler: @escaping (Data?) -> Void) {
        let posterUrl = URL(string: "\(picture)\(posterPath)")!
        let task = URLSession.shared.dataTask(with: posterUrl) { (data, response, error) in
            //Error est de plusieurs types à la fois via son héritage //as sert a caster l'erreur pour qu'elle soit du bon type
            if let error = error as? URLError {
                if error.code == URLError.Code.notConnectedToInternet {
                    print("Erreur car pas de connexion à internet !")
                    pictureCompletionHandler(nil)
                    return
                } else {
                    print("Erreur indéfini de l'image...")
                    pictureCompletionHandler(nil)
                    return
                }
            }
            guard let response = response as? HTTPURLResponse else {
                print("Erreur de la récupération de l'image par rapport à la réponse")
                pictureCompletionHandler(nil)
                return
            }
            guard response.statusCode == 200 else {
                print("Problème de l'image avec le statut code : ", response.statusCode)
                pictureCompletionHandler(nil)
                return
            }
            guard let poster = data else {
                print("Problème avec les données de l'image")
                pictureCompletionHandler(nil)
                return
            }
            pictureCompletionHandler(poster)
        }
        task.resume()
    }
}

