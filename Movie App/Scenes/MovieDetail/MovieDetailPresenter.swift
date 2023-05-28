//
//  MovieDetailPresenter.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 27/05/2023.
//

import Foundation
protocol MovieDetailPresentationLogic {
    func presentDiscoverMovie(response : MovieDetailModel.GetDiscoverMovie.Response)
}


class MovieDetailPresenter :  MovieDetailPresentationLogic {
    
    var viewController : MovieDetailViewModel?
    
    func presentDiscoverMovie(response: MovieDetailModel.GetDiscoverMovie.Response) {
        
        let movie = response.discoverMovie
        let displayedMovie = MovieDetailModel.GetDiscoverMovie.ViewModel.DisplayMovie(id: movie.id, title: movie.title, description: movie.overview, posterImage: "\(APIConfig.BASE_IAMGE_URL)w1000_and_h450_multi_faces\(movie.posterPath)", date: movie.releaseDate,rating: "\(movie.voteAverage)",favorite: movie.favourite)
        
        viewController?.displayDiscoverMovie(viewModel: displayedMovie)
    }
    
}
