//
//  MovieErrors.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 25/05/2023.
//

import Foundation
enum MovieErrors : Error {
  case couldNotLoadMovies(error: String)
}
