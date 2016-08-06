//
//  FeedParserTests.swift
//  OvoFlickrTechTest
//
//  Created by Andrew Ebling on 06/08/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import XCTest
import SwiftyJSON

class FeedParserTests: JSONIntegrationTest {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseSingleFeetItem() {
        let fixtureData = self.fixtureDataForResourceName("single-feed-item-test-fixture")

        let json = JSON(data: fixtureData)
        
        let feedItem = FeedParser.singleFeedItemFromJSON(json)
        
        XCTAssertEqual(feedItem.title, "1999-02-09 18.42.03")
        XCTAssertEqual(feedItem.mediaURL.absoluteString, "https://farm9.staticflickr.com/8642/28692948882_ccd2a69d2a_m.jpg")
        XCTAssertEqual(feedItem.takenDate, NSDate(timeIntervalSince1970: 918614523))
    }
}
