//
//  CustomCollectionViewFlowLayout.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/5/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0
    private var offsetForFirstPage: CGFloat = 0
    private var itemsPerPage: Float = 0
    
    init(itemsPerPage: Float, offsetForFirstPage: CGFloat) {
        self.itemsPerPage = itemsPerPage
        self.offsetForFirstPage = offsetForFirstPage
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let itemsCountSec = collectionView.numberOfItems(inSection: 0)
        let numPage = Int(ceilf(Float(itemsCountSec) / itemsPerPage))

        // Imitating paging behaviour
        // Check previous offset and scroll direction
        if previousOffset > collectionView.contentOffset.x && velocity.x < 0 { // if velocity.x < 0 -> scroll to left
            currentPage = max(currentPage - 1, 0)
        } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
            currentPage = min(currentPage + 1, numPage - 1)
        }
        
        // Update offset by using item size + spacing
        
        var updatedOffset: CGFloat = 0.0

        if currentPage == 1 {
            updatedOffset = offsetForFirstPage
        } else {
            updatedOffset = offsetForFirstPage * CGFloat(currentPage)
        }
        
        previousOffset = updatedOffset
        return CGPoint(x: updatedOffset, y: proposedContentOffset.y)
    }
}
