//
//  LocationDao.swift
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
		

import UIKit
import SQLite

class LocationDao: DataStoreProtocol {
    
    static let table = Table("T_LOCATION")
    static let idLocation = Expression<Int64>("ID_LOCATION")
    static let name = Expression<String>("NAME")
    static let country = Expression<String>("COUNTRY")
    static let latitude = Expression<Double>("LATITUDE")
    static let longitude = Expression<Double>("LONGITUDE")
    
    
    static func findById(id: Int64) throws -> Location? {
        guard let DB = SQLiteDataStore.shared.BBDB else { return nil }
        
        let query = table.filter(idLocation == id)
        let items = try DB.prepare(query)
        for item in items {
            return Location(item[idLocation], item[name], item[country], item[latitude], item[longitude])
        }
        
        return nil
    }
    
    static func findFirstTwentyLikeByName(name: String) throws -> [Location] {
        guard let DB = SQLiteDataStore.shared.BBDB else { return [] }
        
        var retArray = [Location]()
        let query = table.filter(self.name.lowercaseString.like(name.lowercased())).limit(20).group([country, self.name]).order([country, self.name])
        let items = try DB.prepare(query)
        for item in items {
            retArray.append(Location(item[idLocation], item[self.name], item[country], item[latitude], item[longitude]))
        }
        
        return retArray
    }
    
    static func findFirstTwentyLikeByCountry(country: String) throws -> [Location] {
        guard let DB = SQLiteDataStore.shared.BBDB else { return [] }
        
        var retArray = [Location]()
        let query = table.filter(self.country.lowercaseString.like(country.lowercased())).limit(20).group([self.country, name]).order([self.country, name])
        let items = try DB.prepare(query)
        for item in items {
            retArray.append(Location(item[idLocation], item[name], item[self.country], item[latitude], item[longitude]))
        }
        
        return retArray
    }

    static func findAll() throws -> [Location] {
        guard let DB = SQLiteDataStore.shared.BBDB else { return [] }
        
        var retArray = [Location]()
        let items = try DB.prepare(table)
        for item in items {
            retArray.append(Location(item[idLocation], item[name], item[country], item[latitude], item[longitude]))
        }
        
        return retArray
    }
    
}
