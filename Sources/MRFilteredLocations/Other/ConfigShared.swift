//
//  ConfigShared.swift
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


//MARK: - Shared functions

/// Public function for get localized string from this Bundle
/// - Parameter localizedKey: string key to localize
public func locFromBundle(_ localizedKey: String) -> String {
    return loc(localizedKey)
}

/// Public function for get an image from this Bundle
/// - Parameter named: image name
public func colorFromBundle(named: String) -> UIColor? {
    return UIColor(named: named, in: .module, compatibleWith: nil)
}

/// Short function for localize string
/// - Parameter localizedKey: string key to localize
func loc(_ localizedKey: String) -> String {
    return NSLocalizedString(localizedKey, bundle: .module, comment: "")
}
