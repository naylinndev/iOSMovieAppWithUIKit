//
//  MovieDetailRouter.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 27/05/2023.
//

import Foundation

protocol MovieDetailRoutingLogic {
    
}

protocol MovieDetailDataPassing {
    var dataStore : MovieDetailDataStore? {get}
}

class MovieDetailRouter : NSObject, MovieDetailRoutingLogic,MovieDetailDataPassing {
    
    var dataStore: MovieDetailDataStore?
}
