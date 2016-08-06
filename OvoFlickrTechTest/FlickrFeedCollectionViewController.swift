//
//  FlickrFeedCollectionViewController.swift
//  OvoFlickrTechTest
//
//  Created by Andrew Ebling on 06/08/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import UIKit
import AlamofireImage

class FlickrFeedCollectionViewController: UICollectionViewController {

    private var feedItems = [FeedItem]()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(pullToRefresh), forControlEvents: UIControlEvents.ValueChanged)
        return refresh
    }()
    
    private lazy var flickrController = {
        return FlickrController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePullToRefresh()
        fetchFeed()
    }
    
    func pullToRefresh(sender: AnyObject) {
        fetchFeed()
    }
    
    private func fetchFeed() {
        
        self.flickrController.fetchPublicFeed({ (items) in
            
            self.feedItems = items
            self.collectionView?.reloadData()
            self.stopRefreshing()
            
        }) { (error) in
            
            self.stopRefreshing()
            self.showError(error)
        }
    }
    
    private func stopRefreshing() {
        if self.refreshControl.refreshing {
            self.refreshControl.endRefreshing()
        }
    }
    
    private func showError(error: NSError?) {
        let ac = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    private func configurePullToRefresh() {
        self.collectionView?.addSubview(refreshControl)
        // make pull-to-refresh available even if the feed is empty or displaying too few items to scroll
        self.collectionView?.alwaysBounceVertical = true
    }
    
    private func feedItemForIndexPath(indexPath: NSIndexPath) -> FeedItem? {
        
        guard indexPath.row < self.feedItems.count else {
            return nil
        }
        return self.feedItems[indexPath.row]
    }
    
    private func configureCell(cell: FeedItemCollectionViewCell, withItem item: FeedItem) {
        cell.titleLabel.text = item.title
        cell.imageView.af_setImageWithURL(item.mediaURL, placeholderImage: nil, imageTransition: .CrossDissolve(0.2))
        cell.timeAgoLabel.text = item.takenDate.timeAgo()
    }
}

extension FlickrFeedCollectionViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = self.collectionView!.dequeueReusableCellWithReuseIdentifier("CellId", forIndexPath: indexPath) as? FeedItemCollectionViewCell else {
            preconditionFailure("Collection view configured with wrong type of cell")
        }
        if let item = self.feedItemForIndexPath(indexPath) {
            configureCell(cell, withItem: item)
        }
        
        return cell
    }
}