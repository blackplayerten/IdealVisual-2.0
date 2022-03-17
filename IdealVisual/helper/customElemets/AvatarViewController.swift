//
//  AvatarViewController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 14.03.2022.
//

import Foundation
import UIKit
import SnapKit

final class AvatarViewController: UIViewController {
    private var image: UIImage
    private let avatarImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureAvatarView()
        setupAvatarView()
    }

    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        let chooseImageGR = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        view.addGestureRecognizer(chooseImageGR)
        view.subviews.forEach { $0.addGestureRecognizer(chooseImageGR) }
    }

    private func configureAvatarView() {
        avatarImageView.clipsToBounds = true
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.image = image
    }

    private func setupAvatarView() {
        view.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
    }

    func setupImage(_ image: UIImage) {
        self.image = image
        avatarImageView.image = image.withRenderingMode(.alwaysOriginal)
    }

    // MARK: - actions
    @objc
    func chooseImage() {
        ImagePickerManager().pickImage(self) { [weak self] image in
            guard let self = self, let image = image else { return }
            self.setupImage(image)
        }
    }
}
