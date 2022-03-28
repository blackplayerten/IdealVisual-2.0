//
//  FeedCollectionViewDrag&DropDelegate.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 31.01.2022.
//

import UIKit

final class FeedCollectionViewDragAndDropDelegate: NSObject, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    var delegate: FeedCollectionProtocol

    init(delegate: FeedCollectionProtocol) {
        self.delegate = delegate
    }

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession,
                        at indexPath: IndexPath) -> [UIDragItem] {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FeedCollectionViewCell,
              let image = cell.getImage()
        else { return .init() }
        let provider = NSItemProvider(object: image)
        let dragItem = UIDragItem(itemProvider: provider)
        return [dragItem]
    }

    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let items = coordinator.items
        for item in items {
            guard let sourceIndexPath = item.sourceIndexPath,
                let destinationIndexPath = coordinator.destinationIndexPath
            else { return }
            delegate.swapImages(source: sourceIndexPath.item, destination: destinationIndexPath.item)
        }
    }
}
