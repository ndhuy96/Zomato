//
//  CategoryViewCell.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/4/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


final class CategoryViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var categoryView: UIView!
    
    func config(_ category: String, cornerRadius: CGFloat) {
        titleLabel.text = category
        categoryView.cornerRadius = cornerRadius
    }
}
