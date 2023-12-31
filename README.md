# itoa (naming is inspired by the atoi and itoa function in the C language)
Convert iOS Localized.strings to Android strings.xml

# Motivation
During WWDC 23, Apple introduced a new localization feature that simplifies the process of localizing strings in iOS apps. 
With this feature, developers no longer need to manually define key-value pairs for localized strings. 
Additionally, the new feature supports plural strings, making iOS localized strings a reliable source of truth for localization.

This package, called "itoa" (iOS to Android), is in the early stages of development. 

# How to use
- Build the package by running `swift build`
- Convert the iOS `Localized.strings` file to `Android strings.xml` by running `.build/debug/itoa Localization.strings strings.xml`

# Inprogress

## Converting Value
|                           | iOS           | Android         | Progress |
|---------------------------|---------------|-----------------|----------|
| Multi Parameters (String) | "Hello %@ %@" | Hello %1$s %2$s |          |
| Type: String              | %@            | %s              |          |
| Type: Int                 | %d            | %d              |          |
| Type: Float               | %f            | %f              |          |

<- Will update more values

## Converting Key
android key is snake_case

# TODO
Add unit tests to ensure the accuracy of the conversion process.

# References
https://developer.android.com/guide/topics/resources/localization
https://developer.apple.com/documentation/xcode/localization
https://localise.biz/free/converter/ios-to-android
