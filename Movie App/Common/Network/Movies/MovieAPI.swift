//
//  MovieAPI.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 23/05/2023.
//

import Foundation
import Moya


enum MovieAPI {
    case getDiscoverMovies(page: Int)
}

extension MovieAPI : TargetType {
    
    var headers: [String: String]? {
        return ["Content-type": "application/json","Authorization": "Bearer \(APIConfig.appSecret)"]
    }
    
    var path: String {
        switch self {
        case .getDiscoverMovies:
            return "/discover/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDiscoverMovies:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getDiscoverMovies:
            return URLEncoding.default
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getDiscoverMovies(let page):
            return ["page" : page,"sort_by":"popularity.desc"]
        }
    }
    
    var task: Task {
        switch self {
        case .getDiscoverMovies:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
}
