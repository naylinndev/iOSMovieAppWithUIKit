//
//  MovieModels.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 25/05/2023.
//

import Foundation
enum MovieModel{
    
    struct DisplayedMovie {
        let id: Int
        let title, date: String
        let image: String
    }
    
    enum FetchDiscoverVideos {
        struct Request {
            var page: Int = 1
            var lastID: Int?
            var lastPopularity : Double?
        }
        
        struct Response {
            var discoverMovies: [DiscoverMovie]?
            let currentPage: Int
            var lastID: Int
            var lastPopularity : Double
            let hasMorePages: Bool
            var error: MovieErrors?
        }
        
        struct ViewModel {
            var displayedMovies: [DisplayedMovie]
            let currentPage: Int
            var lastID: Int
            var lastPopularity : Double
            let hasMorePages: Bool
            var error: MovieErrors?
        }
    }
    
}
