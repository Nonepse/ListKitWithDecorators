//
//  FeedSeparatorController.swift
//  ListKitWithDecorator
//
//  Created by Pierre Espenan on 21/03/2017.
//  Copyright © 2017 Pierre Espenan. All rights reserved.
//

import UIKit

protocol FeedLayoutDecorationDelegate: class {
    func cellsThatNeedSeparator(atSection: Int) -> [Int]
}

final class FeedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    static let decoratorIdentifier: String = "horizontalDecorator"
    weak var decorationDelegate: FeedLayoutDecorationDelegate?
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        var mutableAttributes = attributes
        for attribute in attributes {
            
            let cellsArray = self.decorationDelegate?.cellsThatNeedSeparator(atSection: attribute.indexPath.section)
            
            if (cellsArray?.contains(attribute.indexPath.row))! {
                if let horizontal = self.layoutAttributesForDecorationView(ofKind: FeedCollectionViewFlowLayout.decoratorIdentifier,
                                                                           at: attribute.indexPath) {
                    mutableAttributes.append(horizontal)
                }
            }
        }
        
        return mutableAttributes
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            guard let itemAttributes = self.layoutAttributesForItem(at: indexPath) else { return nil }
            
            let attributes = FeedCollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind,
                                                                with: indexPath)
            attributes.zIndex = itemAttributes.zIndex + 1
            attributes.backgroundColor = UIColor.red
            
            var decorationViewFrame = itemAttributes.frame
            if elementKind == FeedCollectionViewFlowLayout.decoratorIdentifier {
                decorationViewFrame.size.height = 1.0
            }
            
            attributes.frame = decorationViewFrame
            
            return attributes
    }
}

final class FeedCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    var backgroundColor: UIColor?
}

final class FeedSeparatorView: UICollectionReusableView {
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        if let attributes = layoutAttributes as? FeedCollectionViewLayoutAttributes {
            self.backgroundColor = attributes.backgroundColor
        }
    }
}

extension FeedViewController: FeedLayoutDecorationDelegate {
    func cellsThatNeedSeparator(atSection section: Int) -> [Int] {
        
        if let object = self.adapter.object(atSection: section),
            let sectionController = self.adapter.sectionController(for: object) as? PostSectionController {
            return sectionController.cellsThatNeedTopSeparator
        }
        
        return []
    }
}
