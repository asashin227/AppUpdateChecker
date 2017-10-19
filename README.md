# AppUpdateChecker

[![CI Status](http://img.shields.io/travis/asashin227/AppUpdateChecker.svg?style=flat)](https://travis-ci.org/asashin227/AppUpdateChecker)
[![Version](https://img.shields.io/cocoapods/v/AppUpdateChecker.svg?style=flat)](http://cocoapods.org/pods/AppUpdateChecker)
[![License](https://img.shields.io/cocoapods/l/AppUpdateChecker.svg?style=flat)](http://cocoapods.org/pods/AppUpdateChecker)
[![Platform](https://img.shields.io/cocoapods/p/AppUpdateChecker.svg?style=flat)](http://cocoapods.org/pods/AppUpdateChecker)


```Bundle identifier``` and ```Bundle versions string, short``` in Info.plist is used in AppUpdateChecker.

And using [iTunes API](https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/#lookup)
## Usage 

```swift
AppUpdateChecker().conferm() {
    result in
    switch result {
    case .existUpdate(let version, let storeScheme):
        // For example, Show UIAlertController here.
        print("Now available version: \(version)")
        print("DL from hare: \(storeScheme.absoluteString)")
    case .noUpdate:
        print("Current version is newest")
    case .error(let error):
        print("error: \(error)")
    }
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

AppUpdateChecker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AppUpdateChecker'
```

## License

AppUpdateChecker is available under the MIT license. See the LICENSE file for more info.
