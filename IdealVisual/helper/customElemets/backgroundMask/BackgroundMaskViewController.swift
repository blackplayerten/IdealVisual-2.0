//
//  BackgroundMaskViewController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 21.02.2022.
//

import Foundation
import UIKit
import SnapKit

final class BackgroundMaskViewController: UIViewController {
    private struct UIConstants {
        static let imageLeftPadding = 20.0
        static let imageBottomPadding = 20.0
        static let imageSize: CGSize = .init(width: 150.0, height: 150.0)
    }
    var backgroundMaskView: BackgroundMaskView
    var currentHeight: CGFloat = 0.0
    var canDismiss: Bool = false
    var makeRounded: Bool = true
    var addImage: Bool = false

    enum BackgroundMaskHeight: CGFloat {
        case small
        case half
        case large
    }

    // MARK: - init
    init(height: BackgroundMaskHeight, cornerRadusMask: CornerRaduisMask, positionCornerRadius: PositionCornerRaduisMask = .top) {
        backgroundMaskView = BackgroundMaskView(cornerRadusMask: cornerRadusMask,
                                                positionCornerRadius: positionCornerRadius)
        super.init(nibName: nil, bundle: .main)
        currentHeight = getBackgroundMaskHeight(height: height)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        addBackgroundMask(height: currentHeight)
        setupPanGesture()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresentBackgroundMask()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if makeRounded {
            backgroundMaskView.applyCornerRadius()
        }
    }

    // MARK: - func
    func getBackgroundMaskHeight(height: BackgroundMaskHeight) -> CGFloat {
        switch height {
        case .small:
            return view.frame.height * 0.2
        case .half:
            return view.frame.height / 2
        case .large:
            return view.frame.height * 4/5
        }
    }

    func setupImage() {
        let imageView = UIImageView(image: UIImage(named: "mask_hello")?.withRenderingMode(.alwaysOriginal))
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.bottom.equalTo(backgroundMaskView.snp.top).offset(UIConstants.imageBottomPadding)
            $0.left.equalToSuperview().offset(UIConstants.imageLeftPadding)
            $0.width.height.equalTo(UIConstants.imageSize)
        }
    }

    // MARK: - private func
    private func applyTheme() {
        view.backgroundColor = .clear
        backgroundMaskView.backgroundColor = AppTheme.shared.colorsComponents.background
    }

    private func addBackgroundMask(height: CGFloat) {
        view.addSubview(backgroundMaskView)
        backgroundMaskView.snp.makeConstraints {
            $0.height.equalTo(height)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            $0.width.equalTo(view.snp.width)
        }
    }
}
