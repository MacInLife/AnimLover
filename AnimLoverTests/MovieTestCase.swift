//
//  AnimTestCase.swift
//  AnimLoverTests
//
//  Created by Marie-Ange Coco on 06/02/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import XCTest
@testable import AnimLover

class AnimTestCase: XCTestCase {
    var movie: Movie!
    var choice:Choice!
    
    override func setUp() {
        super.setUp()
        movie = Movie(title: "Spartacus", poster: Data(), releaseYear: "(1952)", isLiked: nil, id: "Coco", description: "Crevette")
        choice = Choice()
    }
    
    func testGivenIsLikedIsNil_WhenUserChoiceIsTrue_ThenIsLikedShouldBeTrue() {
        // Given correspond à la variable movie crée en haut dans la fonction setUp()
        //        let  movie = Movie(title: "Spartacus", poster: Data(), releaseYear: "(1952)", isLiked: nil, id: "Coco", description: "Crevette")
        
        // When
        movie.setLike(with: true)
        choice.setLikeOfCurrentMovie(with: true)
        
        // Then
        XCTAssert(movie.isLiked == true)
    }
    
    func testGivenIsLikedIsNil_WhenUserChoiceIsFalse_ThenIsLikedShouldBeFalse() {
        // Given correspond à la variable movie crée en haut dans la fonction setUp()
        //        let  movie = Movie(title: "Spartacus", poster: Data(), releaseYear: "(1952)", isLiked: nil, id: "Coco", description: "Crevette")
        
        // When
        movie.setLike(with: false)
        choice.setLikeOfCurrentMovie(with: false)
        
        // Then
        XCTAssert(movie.isLiked == false)
    }

}
