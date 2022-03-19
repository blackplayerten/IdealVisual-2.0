//
//  FeedCollectionViewCell.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 20.12.2021.
//

import UIKit

final class FeedCollectionViewCell: UICollectionViewCell {
    private let photoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppTheme.shared.colorsComponents.background
        configure()
    }

    private func configure() {
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.backgroundColor = AppTheme.shared.colorsComponents.background

        contentView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedCollectionViewCell: FeedCollectionProtocol {
    func updatePhoto(with image: UIImage) {
        photoImageView.image = image.withRenderingMode(.alwaysOriginal)
    }
}
