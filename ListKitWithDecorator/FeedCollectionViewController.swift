//
//  FeedCollectionViewController.swift
//  ListKitWithDecorator
//
//  Created by Pierre Espenan on 22/03/2017.
//  Copyright © 2017 Pierre Espenan. All rights reserved.
//

import UIKit

class FeedCollectionViewController: UIViewController, UICollectionViewDataSource {
    
    private let reuseIdentifier = "CollectionViewCell"
    private var collectionView: UICollectionView
    private let feedLayout = FeedCollectionViewFlowLayout()
    
    init() {
        self.collectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: self.feedLayout)
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "UICollectionView Feed"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.feedLayout.decorationDelegate = self
        self.feedLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width,
                                                   height: 100.0)
        self.collectionView.dataSource = self
        self.collectionView.register(PostSelfSizingCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
        self.collectionView.backgroundColor = UIColor(red:0.900, green:0.930, blue:0.950, alpha:1.0)
        
        self.feedLayout.sectionInset = UIEdgeInsets(top: 15.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.feedLayout.minimumLineSpacing = 0.0
        self.collectionView.collectionViewLayout.register(FeedSeparatorView.self,
                                                          forDecorationViewOfKind: FeedCollectionViewFlowLayout.decoratorIdentifier)
        
        self.view.backgroundColor = .white
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.autoCreateAndInstallConstraints {
            self.collectionView.autoPinEdgesToSuperviewEdges()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! PostSelfSizingCell
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
}
