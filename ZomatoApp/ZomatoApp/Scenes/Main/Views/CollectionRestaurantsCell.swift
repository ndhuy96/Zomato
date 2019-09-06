//
//  CollectionRestaurantsCell.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/5/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import Nuke

final class CollectionRestaurantsCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCollectionRestaurants(_ collection: CollectionRestaurants) {
        titleLabel.text = collection.title
        subtitleLabel.text = collection.collectionDescription
        
        if collection.imageURL != "" {
            Nuke.loadImage(with: URL(string: collection.imageURL)!, into: thumbImageView)
        }
    }
}
