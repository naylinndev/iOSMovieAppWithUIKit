//
//  MovieDataManager.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 24/05/2023.
//


import PromiseKit

/// Name of the protocol to inject the network dependency managing the launches
protocol MovieNetworkInjected { }

/// Structure used to inject a instance of PhotoDataManager into the PhotoNetworkInjected protocol
struct MovieNetworkInjector {
    static var networkManager: MovieDataManager = MovieNetworkManager()
}

// MARK: - Extension of protocol including variable containing mechanism to inject
extension MovieNetworkInjected {
    var movieDataManager: MovieDataManager {
        return MovieNetworkInjector.networkManager
    }
}


protocol MovieDataManager: AnyObject {
    func getDiscoverMovies(page : Int) -> Promise<DiscoverMovies>
}


/// Class implementing the MovieDataManager protocol. Used by PhotoNetworkInjector in non test cases
final class MovieNetworkManager: MovieDataManager {
    
    func getDiscoverMovies(page: Int) -> Promise<DiscoverMovies> {
        return APIManager.callApi(MovieAPI.getDiscoverMovies(page: page), dataReturnType: DiscoverMovies.self,debugMode: true)
    }
    
}
