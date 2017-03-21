//
//  PostSelfSizingCell.swift
//  ListKitWithDecorator
//
//  Created by Pierre Espenan on 21/03/2017.
//  Copyright © 2017 Pierre Espenan. All rights reserved.
//

import UIKit
import PureLayout

class PostSelfSizingCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.height = ceil(size.height)
        
        layoutAttributes.frame = newFrame
        
        return layoutAttributes
    }

    private func setupCell() {
        self.backgroundColor = .white
        
        self.contentView.addSubview(self.postTextLabel)
        
        NSLayoutConstraint.autoCreateAndInstallConstraints {
            self.postTextLabel.autoPinEdgesToSuperviewMargins()
        }
    }
    
    private lazy var postTextLabel: UILabel = {
        let postTextLabel = UILabel()
        postTextLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum porttitor rhoncus enim eget dapibus. Cras rutrum mauris augue, a suscipit libero efficitur quis."
        postTextLabel.numberOfLines = 0

        return postTextLabel
    }()
}
