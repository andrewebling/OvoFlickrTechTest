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

    private var dataSource: FlickrFeedDataSource!
    
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
            
            self.configureDataSourceWithItems(items)
            self.collectionView?.reloadData()
            self.stopRefreshing()
            
        }) { (error) in
            
            self.stopRefreshing()
            self.showError(error)
        }
    }
    
    private func configureDataSourceWithItems(items: [FeedItem]) {
        self.dataSource = FlickrFeedDataSource(feedItems: items)
        self.collectionView?.dataSource = self.dataSource
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
}
