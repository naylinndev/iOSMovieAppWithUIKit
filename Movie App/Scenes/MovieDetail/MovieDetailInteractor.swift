//
//  MovieDetailInteractor.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 27/05/2023.
//

import Foundation
import UIKit

protocol MovieDetailBusinessLogic {
    func getDiscoverMovie(request : MovieDetailModel.GetDiscoverMovie.Request)
    func toggleFavorite()
}

protocol MovieDetailDataStore {
    var discoverMovie: DiscoverMovie? { get set }

}

class MovieDetailInteractor : MovieDetailBusinessLogic , MovieDetailDataStore {
    var worker : MovieDetailWorker?
    var discoverMovie: DiscoverMovie?
    var presenter : MovieDetailPresenter?
    
    func getDiscoverMovie(request: MovieDetailModel.GetDiscoverMovie.Request) {
        
        let response = MovieDetailModel.GetDiscoverMovie.Response(discoverMovie: discoverMovie!)
        
        presenter?.presentDiscoverMovie(response: response)
    }
    
    func toggleFavorite() {
        try! RealmStorageContext.init().update { [self] in
            discoverMovie!.favourite = !discoverMovie!.favourite
            
            let response = MovieDetailModel.GetDiscoverMovie.Response(discoverMovie: discoverMovie!)
            presenter?.presentDiscoverMovie(response: response)
        }
        

    }
}
