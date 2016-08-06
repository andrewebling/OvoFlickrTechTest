//
//  FeedItemCollectionViewCell.swift
//  OvoFlickrTechTest
//
//  Created by Andrew Ebling on 06/08/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import UIKit

class FeedItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.titleLabel.text = ""
        self.imageView.image = nil
        self.timeAgoLabel.text = ""
    }
}
