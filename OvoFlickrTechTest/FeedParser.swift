//
//  FeedParser.swift
//  OvoFlickrTechTest
//
//  Created by Andrew Ebling on 06/08/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeedParser {
    private static var token: dispatch_once_t = 0
    private static var dateFormatter: NSDateFormatter!
    
    class var jsonDateFormatter: NSDateFormatter  {
        get {
            // Date formatters are expensive - do this only once
            dispatch_once(&token) {
                dateFormatter = NSDateFormatter()
                dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            }
            return dateFormatter
        }
    }
    
    static func singleFeedItemFromJSON(json: JSON) -> FeedItem {
        
        let urlStr = json["media"]["m"].stringValue
        let title = json["title"].stringValue
        let dateStr = json["date_taken"].stringValue
        return FeedItem(mediaURL: NSURL(string: urlStr) ?? NSURL(),
                        title: title,
                        takenDate: jsonDateFormatter.dateFromString(dateStr) ?? NSDate())
    }
}