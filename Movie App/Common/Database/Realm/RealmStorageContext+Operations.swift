//
//  RealmStorageContext+Operations.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 25/05/2023.
//


import Foundation
import RealmSwift

extension RealmStorageContext {
    func create<T: Storable>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws {
        guard let realm = self.realm else {
            throw NSError()
        }
        
        try self.safeWrite {
            let newObject = realm.create(model as! Object.Type, value: [] as NSArray,update: Realm.UpdatePolicy.modified) as! T
            completion(newObject)
        }
    }
    
    func save(object: Storable) throws {
        guard let realm = self.realm else {
            throw NSError()
        }
        
        try self.safeWrite {
            realm.add(object as! Object,update: .all)
        }
    }
    
    func update(block: @escaping () -> Void) throws {
        try self.safeWrite {
            block()
        }
    }
}

extension RealmStorageContext {
    func delete(object: Storable) throws {
        guard let realm = self.realm else {
            throw NSError()
        }
        
        try self.safeWrite {
            realm.delete(object as! Object)
        }
    }
    
    func deleteAll<T : Storable>(_ model: T.Type) throws {
        guard let realm = self.realm else {
            throw NSError()
        }
        
        try self.safeWrite {
            let objects = realm.objects(model as! Object.Type)
            
            for object in objects {
                realm.delete(object)
            }
        }
    }
    
    func reset() throws {
        guard let realm = self.realm else {
            throw NSError()
        }
        
        try self.safeWrite {
            realm.deleteAll()
        }
    }
}

extension RealmStorageContext {
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate? = nil, limit : Int, sorted: Sorted? = nil, completion: (([T]) -> ())) {
        var objects = self.realm?.objects(model as! Object.Type)
        
        if let predicate = predicate {
            objects = objects?.filter(predicate)
        }
        
        if let sorted = sorted {
            objects = objects?.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }
        
        var accumulate: [T] = [T]()
        
        if (objects!.count > limit && limit > 0){
            for index in 0..<objects!.count {
                accumulate.append(objects![index] as! T)
            }
        }else {
            for object in objects! {
                accumulate.append(object as! T)
            }
        }
        
        completion(accumulate)
    }
}


extension RealmStorageContext {

    func fetchSingle<T: Storable>(_ model: T.Type, predicate: NSPredicate?, completion: ((T?) -> ())){
        var objects = self.realm?.objects(model as! Object.Type)
        
        if let predicate = predicate {
            objects = objects?.filter(predicate)
        }
        
        if objects != nil {
            completion(objects?.first as? T)
        }else {
            completion(nil)
        }

    }
}
