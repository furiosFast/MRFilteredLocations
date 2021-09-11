# MRFilteredLocations

[![SPM ready](https://img.shields.io/badge/SPM-ready-orange.svg)](https://swift.org/package-manager/)
![Platform](https://img.shields.io/badge/platforms-iOS%2011.0%20%7C%20tvOS%2011.0%20%7C%20watchOS%204.0-F28D00.svg)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-12.0-blue.svg)](https://developer.apple.com/xcode)
[![License](https://img.shields.io/cocoapods/l/Pastel.svg?style=flat)](https://github.com/furiosFast/MRFilteredLocations/blob/master/LICENSE)
[![Twitter](https://img.shields.io/badge/twitter-@FastDevsProject-blue.svg?style=flat)](https://twitter.com/FastDevsProject)

Easy access to Sun, Moon and Location informations. In addition Weather and 5 day/3 hour Forecast (5 day/3 hour through the OpenWeatherMap.org provider).

## Requirements

- iOS 13.0+
- Xcode 12.5+
- Swift 5+

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but MRFilteredLocations does support its use on supported platforms.

Once you have your Swift package set up, adding MRFilteredLocations as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
.package(url: "https://github.com/furiosFast/MRFilteredLocations.git", from: "1.0.0")
]
```

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate MRFilteredLocations into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

```bash
$ git init
```

- Add MRFilteredLocations as a git [submodule](https://git-scm.com/docs/git-submodule) by running the following command:

```bash
$ git submodule add https://github.com/furiosfast/MRFilteredLocations.git
```

- Open the new `MRFilteredLocations` folder, and drag the `MRFilteredLocations.xcodeproj` into the Project Navigator of your application's Xcode project.

> It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `MRFilteredLocations.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `MRFilteredLocations.xcodeproj` folders each with two different versions of the `MRFilteredLocations.framework` nested inside a `Products` folder.

> It does not matter which `Products` folder you choose from, but it does matter whether you choose the top or bottom `MRFilteredLocations.framework`.

- And that's it!

> The `MRFilteredLocations.framework` is automatically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.

## Usage

### Initialization

```swift
import MRFilteredLocations
```

## Requirements

MRFilteredLocations has different dependencies and therefore needs the following libraries (also available via SPM):
- [SQLite.swift](https://github.com/stephencelis/SQLite.swift.git) 0.13.0
- [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift) 5.1.0+

It isn't necessary to add the dependencies of MRFilteredLocations, becose with SPM all is do automatically!

There files are already included into the framework.

## License

MRFilteredLocations is released under the MIT license. See [LICENSE](https://github.com/furiosFast/MRFilteredLocations/blob/master/LICENSE) for more information.
