//
//  MovieAppRealmTests.swift
//  Movie AppTests
//
//  Created by Nay Linn (WW) on 26/05/2023.
//

import XCTest
import Quick

@testable import Movie_App

final class MovieAppRealmTests: XCTestCase {
    var storage: StorageContext?

    override func setUp() {
        super.setUp()
        
        do {
            try RealmStorageContext().configured(configuration: ConfigurationType.inMemory(identifier: self.name))
            try self.storage = RealmStorageContext.init()
        } catch {
            XCTFail()
        }
    }
    
    override func tearDown() {
        super.tearDown()
        
        do {
            try self.storage?.deleteAll(Dog.self)
        } catch {
            XCTFail()
        }
    }
    
    func testCreateEmptyRecord() {
        let exp = self.expectation(description: "waiting for object created")
        
        try! self.storage?.create(Dog.self, completion: { (storedObject) in
            print("😚🤠: \(storedObject)")
            
            exp.fulfill()
        })
        
        self.waitForExpectations(timeout: 2)
    }
    
    func testSaveRecord() {
        let record = Dog()
        record.name = "A"
        record.age = 1
        record.color = "red"
        
        let record1 = Dog()
        record1.name = "AB"
        record1.age = 2
        record1.color = "red"

        do {
            try self.storage?.save(object: record)
        } catch _ as NSError {
            XCTFail("Impossible to save the current record")
        }
        
        do {
            try self.storage?.save(object: record1)
        } catch _ as NSError {
            XCTFail("Impossible to save the current record")
        }
    }
    
    func testSaveAndFetch() {
        self.testSaveRecord()
        
        do {
            let exp = self.expectation(description: "wait for fetch")
            
            self.storage?.fetch(Dog.self, predicate: nil, limit : 0,sorted: nil, completion: { (records) in
                XCTAssertEqual(records.count, 2)
                exp.fulfill()
            })
            
            self.waitForExpectations(timeout: 2, handler: nil)
        }
    }
    
    func testSaveAndFetchWithPredicate() {
        self.testSaveRecord()
        
        do {
            let exp = self.expectation(description: "wait for fetch")
            
            self.storage?.fetch(Dog.self, predicate: NSPredicate.init(format: "age == 1"), limit : 0, sorted: nil, completion: { (records) in
                XCTAssertEqual(records.count, 1)
                exp.fulfill()
            })
            
            self.waitForExpectations(timeout: 2, handler: nil)
        }
    }

}
