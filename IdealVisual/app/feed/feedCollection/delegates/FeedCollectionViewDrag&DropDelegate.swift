//
//  FeedCollectionViewDrag&DropDelegate.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 31.01.2022.
//

import UIKit

final class FeedCollectionViewDragAndDropDelegate: NSObject, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession,
                        at indexPath: IndexPath) -> [UIDragItem] {
        return .init()
    }

    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
    }
}
