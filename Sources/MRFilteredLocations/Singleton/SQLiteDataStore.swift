//
//  SQLiteDataStore.swift
//  MRFilteredLocations
//
//  Created by Marco Ricca on 11/09/2021
//
//  Created for MRFilteredLocations in 11/09/2021
//  Using Swift 5.4
//  Running on macOS 11.5.2
//
//  Copyright © 2021 Fast-Devs Project. All rights reserved.
//


import Foundation
import SQLite


protocol DataStoreProtocol {
    associatedtype T
    static func findAll() throws -> [T]
    static func findById(id: Int64) throws -> T?
}


class SQLiteDataStore {
    
    static let shared = SQLiteDataStore()
    let BBDB: Connection?
    
    
    private init() {
        do {
            let sqliteFilePath = Bundle.module.path(forResource: "Locations", ofType: "sqlite")!
            BBDB = try Connection(sqliteFilePath)
        } catch _ {
            BBDB = nil
        }
    }
    
}
