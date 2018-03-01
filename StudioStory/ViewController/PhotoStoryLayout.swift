//
//  PrinterestLayout.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 26/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

protocol PhotoStoryLayoutDelegate: class {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
    func collectionView(_ collectionView: UICollectionView, widthForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat

}

class PhotoStoryLayout: UICollectionViewLayout {
    
    weak var delegate: PhotoStoryLayoutDelegate!
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 25
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        /// only caculate once
        guard let collectionView = collectionView else {
            return
        }
        
        //. Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)

        // 3. Iterates through the list of items in the first section
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            // 4. Asks the delegate for the height of the picture and the annotation and calculates the cell frame.            
            let cellWidth = (UIScreen.main.bounds.width - 25 * 3) / 2

            let photoOriginHeight = delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
            let photoOriginWidth = delegate.collectionView(collectionView, widthForPhotoAtIndexPath: indexPath)
            
            let cellHeight = cellWidth / (photoOriginWidth / photoOriginHeight)
            let height = cellHeight + cellPadding
            
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // 6. Updates the collection view content height
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
