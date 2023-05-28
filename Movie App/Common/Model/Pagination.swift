//
//  Pagination.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 27/05/2023.
//

import Foundation
import RealmSwift

class Pagination : Object {
    @Persisted(primaryKey: true) var name : String
    @Persisted var page : Int
    @Persisted var hasMorePages : Bool
}
