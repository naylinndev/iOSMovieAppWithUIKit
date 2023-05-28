//
//  Dog.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 25/05/2023.
//

import Foundation
import RealmSwift

class Dog: Object {
    @Persisted(primaryKey: true) var name = ""
    @Persisted var age = 0
    @Persisted var color = ""
}
