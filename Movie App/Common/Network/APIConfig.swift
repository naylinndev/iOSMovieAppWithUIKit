//
//  APIConfig.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 23/05/2023.
//

import Foundation
struct APIConfig {
    
    static let BASE_URL : String = "https://api.themoviedb.org/"
    static let BASE_IAMGE_URL : String = "https://image.tmdb.org/t/p/"
    static let apiVersion = "3"
    static let limitDisplay = 20
    static let appSecret = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZjBhZjQ1YmE1M2Y0Mzc4ZGE1NjczYWMxZjcwYjQ0YiIsInN1YiI6IjYyY2VlMmIwMmRjOWRjMDA1MTUwMmZjNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VtlbXzY_vPQug9g8JrEg_4C2d_LFOsnuI0B96u3LLaQ"

    static func getBaseUrl() -> String {
        return "\(BASE_URL)\(apiVersion)"
    }
}
