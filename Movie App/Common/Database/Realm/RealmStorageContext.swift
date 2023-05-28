//
//  RealmStorageContext.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 25/05/2023.
//


import Foundation
import RealmSwift

/* Storage config options */
public enum ConfigurationType {
    case basic(url: String?)
    case inMemory(identifier: String?)
    
    var associated: String? {
        get {
            switch self {
            case .basic(let url): return url
            case .inMemory(let identifier): return identifier
            }
        }
    }
}

class RealmStorageContext: StorageContext {
    
    var realm: Realm?
    
    public func configured(configuration: ConfigurationType = .basic(url: nil)) throws {
        var rmConfig = Realm.Configuration()
        rmConfig.readOnly = true
        switch configuration {
        case .basic:
            rmConfig = Realm.Configuration.defaultConfiguration
            if let url = configuration.associated {
                rmConfig.fileURL = NSURL(string: url) as URL?
            }
        case .inMemory:
            rmConfig = Realm.Configuration()
            if let identifier = configuration.associated {
                rmConfig.inMemoryIdentifier = identifier
            } else {
                throw NSError()
            }
        }
        try self.realm = Realm(configuration: rmConfig)
    }
    
    required init() throws {
        try self.realm = Realm()
    }
    
    public func safeWrite(_ block: (() throws -> Void)) throws {
        guard let realm = self.realm else {
            throw NSError()
        }

        if realm.isInWriteTransaction {
            try block()
        } else {
            try realm.write(block)
        }
    }
}
