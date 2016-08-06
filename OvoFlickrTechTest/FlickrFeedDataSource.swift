//
//  FlickrFeedDataSource.swift
//  OvoFlickrTechTest
//
//  Created by Andrew Ebling on 06/08/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import UIKit

class FlickrFeedDataSource: NSObject, UICollectionViewDataSource {
    
    let feedItems: [FeedItem]
    
    init(feedItems: [FeedItem]) {
        
        self.feedItems = feedItems
        super.init()
    }
    
    @objc func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    @objc func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellId", forIndexPath: indexPath) as? FeedItemCollectionViewCell else {
            preconditionFailure("Collection view configured with wrong type of cell")
        }
        if let item = self.feedItemForIndexPath(indexPath) {
            configureCell(cell, withItem: item)
        }
        
        return cell
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