//
//  MovieRouter.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 27/05/2023.
//

import Foundation
import UIKit

@objc protocol MovieRoutingLogic {
    func showMovieDetailPage(for id: Int)
}

protocol MovieDataPassing {
  var dataStore: MovieDataStore? { get }
}


class MovieRouter: NSObject, MovieRoutingLogic, MovieDataPassing, RouterProtocol {
    
    weak var viewController: MovieViewController?
    var dataStore: MovieDataStore?
    
    func showMovieDetailPage(for id: Int) {
        let selectDiscoverMovie = dataStore?.movies?.first{$0.id == id}
        
        guard let movie = selectDiscoverMovie else {return }
        show(nibIdentifier: "MovieDetailViewController") { (destinationVC : MovieDetailViewController) in
            var destinationDataStore = destinationVC.router!.dataStore!
            self.passDataToDetailPage(source: movie, destination: &destinationDataStore)
            
        }
    }
    
    // MARK: Passing data
    
    func passDataToDetailPage(source: DiscoverMovie, destination: inout MovieDetailDataStore) {
        destination.discoverMovie = source
    }
    
}
