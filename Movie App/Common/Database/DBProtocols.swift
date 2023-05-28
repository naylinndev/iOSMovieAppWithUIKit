//
//  DBProtocols.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 25/05/2023.
//

import Foundation
import RealmSwift

public protocol Storable {
}
extension Object: Storable {
}



struct Sorted {
    var key: String
    var ascending: Bool = true
}

/*
 Operations on context
 */
protocol StorageContext {
    /*
     Create a new object with default values
     return an object that is conformed to the `Storable` protocol
     */
    func create<T: Storable>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws
    /*
     Save an object that is conformed to the `Storable` protocol
     */
    func save(object: Storable) throws
    /*
     Update an object that is conformed to the `Storable` protocol
     */
    func update(block: @escaping () -> ()) throws
    /*
     Delete an object that is conformed to the `Storable` protocol
     */
    func delete(object: Storable) throws
    /*
     Delete all objects that are conformed to the `Storable` protocol
     */
    func deleteAll<T: Storable>(_ model: T.Type) throws
    /*
     Return a list of objects that are conformed to the `Storable` protocol
     */
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, limit : Int, sorted: Sorted?, completion: (([T]) -> ()))
    
    /*
     Return a object that are conformed to the `Storable` protocol
     */
    func fetchSingle<T: Storable>(_ model: T.Type, predicate: NSPredicate?, completion: ((T?) -> ()))
}
