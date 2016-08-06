//
//  FlickrController.swift
//  OvoFlickrTechTest
//
//  Created by Andrew Ebling on 06/08/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FlickrController {
    
    func fetchPublicFeed(successBlock: ([FeedItem]) -> Void, failureBlock: (error: NSError?) -> Void) {
        Alamofire.request(.GET, "https://api.flickr.com/services/feeds/photos_public.gne",
            parameters: ["format": "json", "lang": "en-us", "nojsoncallback": "1"])
            .validate()
            .responseString(encoding: NSUTF8StringEncoding) { response in
                
                switch response.result {
                case .Success(let value):
                
                    guard let dataFromString = self.sanitizeFlickrsJSON(value).dataUsingEncoding(NSUTF8StringEncoding) else {
                        dispatch_async(dispatch_get_main_queue(), {
                            failureBlock(error: nil)
                        })
                        return
                    }
                    
                    let items = FeedParser.feedItemsFromJSON(JSON(data: dataFromString))
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        successBlock(items)
                    })
                    
                case .Failure(let error):
                    dispatch_async(dispatch_get_main_queue(), {
                        failureBlock(error: error)
                    })
                }
        }
    }
    
    private func sanitizeFlickrsJSON(json: String) -> String {
        return json.stringByReplacingOccurrencesOfString("\\'", withString: "'")
    }
}