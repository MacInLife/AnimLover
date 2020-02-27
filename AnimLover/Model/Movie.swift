//
//  Movie.swift
//  AnimLover
//
//  Created by Marie-Ange Coco on 12/12/2019.
//  Copyright © 2019 Marie-Ange Coco. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var poster: Data
    var releaseYear: String
    var isLiked: Bool?
    var id: String
    var description: String
    
//  Obtenir l'année du film dans le releaseDate
//    var releaseYear: String {
//        return poster.
//    }
    
    init(title: String, poster: Data, releaseYear: String, isLiked: Bool?, id: String, description: String){
        self.title = title
        self.poster = poster
        self.releaseYear = releaseYear
        self.isLiked = isLiked
        self.id = id
        self.description = description
    }
    
    func setLike(with userChoice: Bool) {
        isLiked = userChoice
        
        if userChoice == true{
                       print(title)
               }
    }
}
