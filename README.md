# TDLog

[![CI Status](http://img.shields.io/travis/Mr Sa/TDLog.svg?style=flat)](https://travis-ci.org/Mr Sa/TDLog)
[![Version](https://img.shields.io/cocoapods/v/TDLog.svg?style=flat)](http://cocoapods.org/pods/TDLog)
[![License](https://img.shields.io/cocoapods/l/TDLog.svg?style=flat)](http://cocoapods.org/pods/TDLog)
[![Platform](https://img.shields.io/cocoapods/p/TDLog.svg?style=flat)](http://cocoapods.org/pods/TDLog)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Demo
![](https://lh3.googleusercontent.com/-zCnvcCzI4d8/VvOh5Bf5NHI/AAAAAAAAANU/gzEc0TZYaTIod_fUXJrs7h_zeNa80vR4g/w401-h534-no/Simulator%2BScreen%2BShot%2BMar%2B24%252C%2B2016%252C%2B3.13.14%2BPM.png)

![](https://lh3.googleusercontent.com/-o5HIKGwGCMg/VvOh5ICYoZI/AAAAAAAAANY/0tar37m7jGMbHLtrkAcDyRyZUOgCwF0pQ/w401-h534-no/Simulator%2BScreen%2BShot%2BMar%2B24%252C%2B2016%252C%2B3.13.20%2BPM.png)

## Requirements

## Installation

TDLog is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TDLog"
```

## Configure
1. Project > Build Phases > Link Binary Libraries > add "TDLog.framework"
1. Project > Build Phases > Copy Bundle Resources > add "TDLog.bundle"

## Use TDLog
```ruby
TDLOG(@"%@","content log");
```

## Use Float Icon
```ruby
[[TDLogManagement td_sharedInstance] td_show];
```

## Filter follow color
```ruby
[[TDLogManagement td_sharedInstance].td_LogFilter setValue:@"text need highlight 1" forKey:L_Red];
[[TDLogManagement td_sharedInstance].td_LogFilter setValue:@"text need highlight 2" forKey:L_LimeGreen];
```

## Handle Crash (send mail)
//STEP1: You need add email of feeback on 'TD_EmailDevelopment' field in split file!!! ***";
//STEP2: Insert '[TDEngineLog td_sharedManager];' into 'application:didFinishLaunchingWithOptions:'. The app will auto detect crash. So, enduser can choose the option to send crash log to mail did configure in above




## Author

Mr Sa, daoduythuy@gmail.com

## License

TDLog is available under the MIT license. See the LICENSE file for more info.
