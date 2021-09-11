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


//MARK: - Shared variables

public let bundleId = "org.fastdevsproject.altervista.MRGpsDataGetter"
public let appVersionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
public let copyright = Bundle.main.object(forInfoDictionaryKey: "NSHumanReadableCopyright") as! String
public let appBuildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
public let hexAppBuildNumber = String(appBuildNumber.int!, radix: 16, uppercase: true)


//MARK: - Shared functions

/// Public function for get localized string from this Bundle
/// - Parameter localizedKey: string key to localize
public func locFromBundle(_ localizedKey: String) -> String {
    return loc(localizedKey)
}

/// Public function for get an image from this Bundle
/// - Parameter named: image name
public func imgFromBundle(named: String) -> UIImage? {
    return UIImage(named: named, in: .module, with: nil)
}

/// Short function for localize string
/// - Parameter localizedKey: string key to localize
func loc(_ localizedKey: String) -> String {
    return NSLocalizedString(localizedKey, bundle: .module, comment: "")
}
