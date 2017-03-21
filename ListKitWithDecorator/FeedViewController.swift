//
//  FeedViewController.swift
//  ListKitWithDecorator
//
//  Created by Pierre Espenan on 21/03/2017.
//  Copyright © 2017 Pierre Espenan. All rights reserved.
//

import UIKit
import IGListKit

class FeedViewController: UIViewController, IGListAdapterDataSource {

    var collectionView: IGListCollectionView
    var feedLayout: FeedCollectionViewFlowLayout
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(),
                             viewController: self,
                             workingRangeSize: 0)
    }()

    init() {
        self.feedLayout = FeedCollectionViewFlowLayout()
        self.collectionView = IGListCollectionView(frame: .zero,
                                                   collectionViewLayout: self.feedLayout)
        
        super.init(nibName: nil, bundle: nil)
        
        self.feedLayout.estimatedItemSize = CGSize(width: 1.0, height: 1.0)
        self.feedLayout.decorationDelegate = self
        
        self.collectionView.backgroundColor = UIColor(red:0.900, green:0.930, blue:0.950, alpha:1.0)
        self.collectionView.collectionViewLayout.register(FeedSeparatorView.self,
                                                          forDecorationViewOfKind: FeedCollectionViewFlowLayout.decoratorIdentifier)
        
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
        
        self.title = "Feed"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.autoCreateAndInstallConstraints {
            self.collectionView.autoPinEdgesToSuperviewEdges()
        }
    }
    
    // MARK: - IGListAdapterDataSource
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return [UIView(frame: .zero),
                UIView(frame: .zero),
                UIView(frame: .zero),
                UIView(frame: .zero)
        ]
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return PostSectionController()
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }
}
