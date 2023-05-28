//
//  MovieDetailModel.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 27/05/2023.
//

import Foundation
enum MovieDetailModel {
    
    enum GetDiscoverMovie {
        struct Request {}
        
        struct Response {
            var discoverMovie : DiscoverMovie
        }
        
        struct ViewModel {
            struct DisplayMovie {
                var id : Int
                var title: String
                var description : String
                var posterImage : String
                var date : String
                var rating : String
                var favorite : Bool
            }
        }
        
    }
    
}
