//
//  MovieAPIMockData.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 23/05/2023.
//

import Foundation
import Moya

extension MovieAPI {
    var sampleData: Data {
        switch self {
        case .getDiscoverMovies:
            return stubbedResponse("DiscoverMovies")
        }
    }
}
