//
//  FeedCollectionViewFlowLayoutDelegate.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 31.01.2022.
//

import UIKit

final class FeedCollectionViewFlowLayoutDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    private var view: UIView

    init(view: UIView, collectionView: UICollectionView) {
        self.view = view
        super.init()
        collectionView.delegate = self
    }

    //MARK: - constants
    private struct UIConstants {
        static let minimumLineSpacing: CGFloat = 1.0
        static let minimumInteritemSpacing: CGFloat = 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidthAndHeight = view.bounds.width / 3 - 1
        return CGSize(width: cellWidthAndHeight, height: cellWidthAndHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        UIConstants.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        UIConstants.minimumInteritemSpacing
    }
}
