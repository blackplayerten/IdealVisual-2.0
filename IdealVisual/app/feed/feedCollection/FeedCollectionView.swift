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

    private var delegateCollectionView: FeedCollectionViewDelegate?
    private var dataSourceCollectionView: FeedCollectionViewDataSource?
    private var dragAndDropDelegateCollectionView: FeedCollectionViewDragAndDropDelegate?
    private let flowLayout: UICollectionViewFlowLayout = .init()

    private let collectionProtocol: FeedCollectionProtocol

    init(collectionProtocol: FeedCollectionProtocol) {
        self.collectionProtocol = collectionProtocol
        super.init(frame: .zero, collectionViewLayout: .init())
        setLayout()
        setDelegates()
        delegate = delegateCollectionView
        dataSource = dataSourceCollectionView
        dragDelegate = dragAndDropDelegateCollectionView
        dropDelegate = dragAndDropDelegateCollectionView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - func
    func registerCells(_ cells: [UICollectionViewCell.Type]) {
        cells.forEach { self.register($0, forCellWithReuseIdentifier: "feedCell") }
    }

    // MARK: - private func
    private func setLayout() {
        flowLayout.scrollDirection = .vertical
        collectionViewLayout = flowLayout
    }

    private func setDelegates() {
        delegateCollectionView = FeedCollectionViewDelegate()
        dataSourceCollectionView = FeedCollectionViewDataSource(items: items)
        dragAndDropDelegateCollectionView = FeedCollectionViewDragAndDropDelegate(delegate: collectionProtocol)
    }
}

// MARK: - extension
extension FeedCollectionView: FeedCollectionProtocol {
    func swapImages(source: Int, destination: Int) {
        collectionProtocol.swapImages(source: source, destination: destination)
    }
}
