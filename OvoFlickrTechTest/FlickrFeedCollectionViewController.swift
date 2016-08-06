//
//  FlickrFeedCollectionViewController.swift
//  OvoFlickrTechTest
//
//  Created by Andrew Ebling on 06/08/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import UIKit

class FlickrFeedCollectionViewController: UICollectionViewController {

    var feedItems = [FeedItem]()
    
    lazy var flickrController = {
        return FlickrController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.flickrController.fetchPublicFeed({ (items) in
                self.feedItems = items
                self.collectionView?.reloadData()
            }) { (error) in
                let ac = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
                let ok = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                ac.addAction(ok)
                self.presentViewController(ac, animated: true, completion: nil)
        }
    }
}

