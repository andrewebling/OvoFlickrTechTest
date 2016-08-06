//
//  JSONIntegrationTest.swift
//  OvoFlickrTechTest
//
//  Created by Andrew Ebling on 06/08/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import XCTest

class JSONIntegrationTest: XCTestCase {
    
    let kFixtureExtension = "json"
    
    func fixtureDataForResourceName(filename: String) -> NSData {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        
        guard let fixturePath = bundle.pathForResource(filename, ofType: kFixtureExtension) else {
            fatalError("Failed to find fixture named \(filename).\(kFixtureExtension)")
        }
        guard let fixtureData = NSData(contentsOfFile: fixturePath) where
        fixtureData.length > 0 else {
            fatalError("Failed to load fixture data from \(filename).\(kFixtureExtension)")
        }
        return fixtureData
    }
}
