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
    
    private static let kFlickrDateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    
    static let jsonDateFormatter: NSDateFormatter = {
        
        let dateFormatter = NSDateFormatter()
        // set locale to prevent user time/date format preferences from breaking this
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = kFlickrDateFormat
        return dateFormatter
    }()
    
    static func singleFeedItemFromJSON(json: JSON) -> FeedItem {
        
        let urlStr = json["media"]["m"].stringValue
        let title = json["title"].stringValue
        let dateStr = json["date_taken"].stringValue
        return FeedItem(mediaURL: NSURL(string: urlStr) ?? NSURL(),
                        title: title,
                        takenDate: jsonDateFormatter.dateFromString(dateStr) ?? NSDate())
    }
}