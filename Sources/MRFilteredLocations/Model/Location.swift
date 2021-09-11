//
//  Location.swift
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


public class Location: NSObject {
    
    public final let id: Int64
    public final let name: String
    public final let country: String
    public final let latitude: Double
    public final let longitude: Double

    init(_ id: Int64, _ name: String, _ country: String, _ latitude: Double, _ longitude: Double) {
        self.id = id
        self.name = name
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! Int64
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.country = aDecoder.decodeObject(forKey: "country") as! String
        self.latitude = aDecoder.decodeObject(forKey: "latitude") as! Double
        self.longitude = aDecoder.decodeObject(forKey: "longitude") as! Double
    }
    
    func encode(with encoder: NSCoder) {
        encoder.encode(self.id, forKey: "id")
        encoder.encode(self.name, forKey: "name")
        encoder.encode(self.country, forKey: "country")
        encoder.encode(self.latitude, forKey: "latitude")
        encoder.encode(self.longitude, forKey: "longitude")
    }
    
}
