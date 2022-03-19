//
//  FeedCollectionViewDataSource.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 31.01.2022.
//

import UIKit

final class FeedCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var items: [UIImage] = []

    init(items: [UIImage]) {
        self.items = items
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell",
                                                            for: indexPath) as? FeedCollectionViewCell
        else {
            Logger.log("not feed cell")
            return .init()
        }
        cell.updatePhoto(with: items[indexPath.item])
        return cell
    }
}
