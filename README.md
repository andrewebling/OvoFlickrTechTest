# OvoFlickrTechTest
Technical test for Ovo Energy by Andrew Ebling.

# Requirements

* Xcode 7.3.1/iOS 9 SDK
* Carthage 0.11.0 or later

# Building

1. Clone the project
1. Open a terminal and issue the following command within the top level project directory: ```carthage update --platform iOS```
1. Open the Xcode project file and build in the normal way

# Architecture

As the app is fairly simple, it follows fairly standard MVC. In the interests of keeping the main ```UIViewController``` subclass small, the implementation of ```UICollectionViewDataSource``` has been broken out into a separate class.

I chose to use a ```UICollectionView``` over a ```UITableView``` so that a grid of photos can be displayed easily in landscape and on larger screened devices.

The app uses Storyboards, in the interests of rapid development and minimising the volume of code required.

# Tests

The ```OvoFlickrTechTestTests``` target containts some unit and integration tests, while ```OvoFlickrTechTestUITests``` target contains a single "smoke test" which is designed to exercise the app and put it through it's paces.

# Areas for Improvement

I would invest further time in unit testing ```FlickrFeedDataSource``` as well as investigating why XCUITests are not currently starting up on devices reliably. I suspect this may be related to a frameworks embedding and signing problem which I had to fix on order to get the tests running in the iOS Simulator.

# Credits & Libraries Used

* Alamofire - by the Alamofire Software Foundation; a library written in Swift which provides a much more convenient wrapper around more modern iOS networking APIs. 
* AlamofireImageView - by the Alamofire Software Foundation; a library written in Swift which makes working with images in a network environment much simpler and cleaner.
* SwiftyJSON - written by tangplin & lingoer; a library written in Swift which makes JSON parsing code a lot more readable and maintainable.
* TimeAgo - single class written by Zemirco for producing fuzzy/friendly/human readable dates.