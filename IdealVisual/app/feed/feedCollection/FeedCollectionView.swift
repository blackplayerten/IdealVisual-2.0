//
//  FeedCollectionViewController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 20.12.2021.
//

import UIKit

final class FeedCollectionView: UICollectionView {
    var flowLayoutDelegate: FeedCollectionViewFlowLayoutDelegate?
    var items = [UIImage]()

    private var delegateFeed: FeedCollectionViewDelegate?
    private var dataSourceFeed: FeedCollectionViewDataSource?
    private var dragAndDropDelegateFeed: FeedCollectionViewDragAndDropDelegate?
    private var flowLayout: UICollectionViewFlowLayout = .init()

    private func setLayout() {
        flowLayout.scrollDirection = .vertical
        collectionViewLayout = flowLayout
    }

    private func setDelegates() {
        delegateFeed = FeedCollectionViewDelegate()
        dataSourceFeed = FeedCollectionViewDataSource(items: items)
        dragAndDropDelegateFeed = FeedCollectionViewDragAndDropDelegate()
    }

    init() {
        super.init(frame: .zero, collectionViewLayout: .init())
        setLayout()
        setDelegates()
        delegate = delegateFeed
        dataSource = dataSourceFeed
        dragDelegate = dragAndDropDelegateFeed
        dropDelegate = dragAndDropDelegateFeed
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func registerCells(_ cells: [UICollectionViewCell.Type]) {
        cells.forEach { self.register($0, forCellWithReuseIdentifier: "feedCell") }
    }
}
