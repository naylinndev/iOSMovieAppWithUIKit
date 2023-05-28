//
//  MoviePresenter.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 27/05/2023.
//

import Foundation

protocol MoviePresentationLogic {
    func presentDiscoverMovies(respose : MovieModel.FetchDiscoverVideos.Response)
}

class MoviePresenter : MoviePresentationLogic {
    var viewController : MovieDisplayedLogic?
    
    func presentDiscoverMovies(respose: MovieModel.FetchDiscoverVideos.Response) {
        let displayMovies = getDisplayedMovies(respose.discoverMovies)
        let viewModel = MovieModel.FetchDiscoverVideos.ViewModel(displayedMovies: displayMovies, currentPage: respose.currentPage, lastID: respose.lastID, lastPopularity: respose.lastPopularity, hasMorePages: respose.hasMorePages)
        
        self.viewController?.displayDiscoverMovies(viewModel: viewModel)
    }
}


extension MoviePresenter {
    /// Creates a array of DisplayedMovie to display
    ///
    /// - Parameter movies: An array of Discover Movies
    /// - Returns: An array of MovieModel.DisplayedMovie to display in view
    private func getDisplayedMovies(_ movies: [DiscoverMovie]?) -> [MovieModel.DisplayedMovie] {
        var displayedMovies: [MovieModel.DisplayedMovie] = []

        if let movies = movies {
            for movie in movies {
                let displayedMovie = MovieModel.DisplayedMovie(id: movie.id, title: movie.title, date: movie.releaseDate, image: "\(APIConfig.BASE_IAMGE_URL)w500\(movie.posterPath)")
                displayedMovies.append(displayedMovie)
            }
        }
        
        return displayedMovies
    }
}
