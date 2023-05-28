//
//  MovieInteractor.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 27/05/2023.
//

import Foundation
import PromiseKit

protocol MovieBusinessLogic {
    func fetchDiscoverMovies(request: MovieModel.FetchDiscoverVideos.Request)
}

protocol MovieDataStore {
    var movies: [DiscoverMovie]? { get }
}


final class MovieInteractor: MovieBusinessLogic, MovieDataStore {
    var worker = MovieWorker()
    var movies: [DiscoverMovie]?

    var presenter: MoviePresentationLogic?
    let debugMode = false

    func fetchDiscoverMovies(request: MovieModel.FetchDiscoverVideos.Request) {
        var response: MovieModel.FetchDiscoverVideos.Response!
        
        worker.movieDataManager.getDiscoverMovies(page: request.page).done { discoverMovies in
            
            response = self.storeDiscoverMoviesAndRetrieveByPage(discoverMovies: discoverMovies, request: request, error: nil)
        }.catch { error in
            response = self.storeDiscoverMoviesAndRetrieveByPage(discoverMovies: nil, request: request, error: error.localizedDescription)
        }.finally {
            self.presenter?.presentDiscoverMovies(respose: response)
        }
        
    }
    
}


extension MovieInteractor {
    
    func storeDiscoverMoviesAndRetrieveByPage(discoverMovies : DiscoverMovies?,request : MovieModel.FetchDiscoverVideos.Request , error : String?) -> MovieModel.FetchDiscoverVideos.Response{
        var predicate : NSPredicate? = nil
        var moviesFromDB : [DiscoverMovie]?
        var page : Int = 1
        var hasMorePages : Bool = false
        let key : String  = "discover_movies"
        
        if let discoverMovies = discoverMovies {
            
            
            page = discoverMovies.page
            hasMorePages = discoverMovies.totalPages > discoverMovies.page
            
            let pagination : Pagination = Pagination()
            pagination.name = key
            pagination.page = page
            pagination.hasMorePages = hasMorePages
            try! RealmStorageContext.init().save(object: pagination)
            
            if page == 1 {
              //  try! RealmStorageContext.init().deleteAll(DiscoverMovie.self)
            }
            for object in discoverMovies.results {
               try! RealmStorageContext.init().save(object: object)
            }

        }else {
            
            try! RealmStorageContext.init().fetchSingle(Pagination.self,predicate: NSPredicate(format: "name == %@",key),completion: { (paginate) in
                if let paginate = paginate {
                    page = paginate.page
                    hasMorePages = paginate.hasMorePages
                }else {
                    page = 0
                    hasMorePages = false
                }
                
                
                
            })
            
        }
        
        
        if request.lastID != 0 && request.lastPopularity != 0.0 {
            predicate = NSPredicate(format: "popularity < %f AND id != %d",request.lastPopularity!,request.lastID!)
        }
        
        try! RealmStorageContext.init().fetch(DiscoverMovie.self, predicate: predicate,limit: discoverMovies != nil ? APIConfig.limitDisplay : 0,sorted: Sorted(key: "popularity",ascending: false), completion: { (movies) in
           
           moviesFromDB = movies
           
        })
        
        
        
        if moviesFromDB?.count == 0 {
            return MovieModel.FetchDiscoverVideos.Response(discoverMovies: [],currentPage: page, lastID: 0,lastPopularity : 0, hasMorePages: hasMorePages,error: MovieErrors.couldNotLoadMovies(error: error ?? ""))
        }
        
        //movies = moviesFromDB
        if movies == nil {
            movies = moviesFromDB
        }else {
            movies!.append(contentsOf: moviesFromDB ?? [])
        }
        
        return MovieModel.FetchDiscoverVideos.Response(discoverMovies: moviesFromDB,currentPage: page, lastID: (moviesFromDB?.last!.id)!, lastPopularity : (moviesFromDB?.last!.popularity)!, hasMorePages: hasMorePages,error: MovieErrors.couldNotLoadMovies(error: error ?? ""))
        
    }
}
