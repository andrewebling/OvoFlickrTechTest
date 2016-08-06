//
//  OvoFlickrTechTestTests.swift
//  OvoFlickrTechTestTests
//
//  Created by Andrew Ebling on 06/08/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import XCTest
@testable import OvoFlickrTechTest

class FlickrFeedCollectionViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    
    override func setUp() {
        super.setUp()
        
        self.storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStoryboardInstantiatesNavigationAndFlickrFeedCollectionViewController() {
        
        guard let navigationController = self.storyboard.instantiateInitialViewController() as? UINavigationController else {
            XCTFail("Did not find a navigation controller as the root view controller in storyboard")
            return
        }
        
        guard let _ = navigationController.topViewController as? FlickrFeedCollectionViewController else {
            XCTFail("Did not find an instance of FlickrFeedCollectionViewController as the navigationController's topViewController")
            return
        }
    }
}
