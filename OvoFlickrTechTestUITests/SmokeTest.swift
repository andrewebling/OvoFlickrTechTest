//
//  SmokeTest.swift
//  OvoFlickrTechTest
//
//  Created by Andrew Ebling on 06/08/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import XCTest

class SmokeTest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        app.launch()
    }
    
    func testSmokeTest() {
        
        let collectionView = app.otherElements.containingType(.NavigationBar, identifier:"Flickr Public Feed").descendantsMatchingType(.CollectionView).element
        
        scroll(collectionView, toBottom: true)
        scroll(collectionView, toBottom: false)
    }
    
    let kNumberOfSwipesToBottom = 10
    
    private func scroll(collectionView: XCUIElement, toBottom: Bool) {
        for _ in 0...kNumberOfSwipesToBottom {
            if toBottom {
                collectionView.swipeUp()
            } else {
                collectionView.swipeDown()
            }
        }
    }
}
