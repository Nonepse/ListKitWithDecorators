//
//  PostSectionController.swift
//  ListKitWithDecorator
//
//  Created by Pierre Espenan on 21/03/2017.
//  Copyright © 2017 Pierre Espenan. All rights reserved.
//

import IGListKit

class PostSectionController: IGListSectionController, IGListSectionType {
    
    var cellsThatNeedTopSeparator: [Int] = []
    
    override init() {
        super.init()
        
        self.inset = UIEdgeInsets(top: 15.0, left: 0.0, bottom: 0.0, right: 0.0)
        cellsThatNeedTopSeparator = [1, 3]
    }
    
    // MARK: - IGListSectionType
    
    func numberOfItems() -> Int {
        return 4
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        
        return CGSize(width: context.containerSize.width, height: 40.0)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: PostSelfSizingCell.self, for: self, at: index) as! PostSelfSizingCell
        
        return cell
    }
    
    func didUpdate(to object: Any) { }
    
    func didSelectItem(at index: Int) { }

}

