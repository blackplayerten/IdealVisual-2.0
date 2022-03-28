//
//  BackgroundMaskView.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 21.02.2022.
//

import UIKit

enum CornerRaduisMask: Int {
    case min = 5
    case medium = 8
    case large = 15
}

enum PositionCornerRaduisMask {
    case top
    case bottom
}

final class BackgroundMaskView: UIView {
    private var cornerValue: CornerRaduisMask
    private var cornerPosition: PositionCornerRaduisMask

    // MARK: - init
    init(cornerRadusMask: CornerRaduisMask, positionCornerRadius: PositionCornerRaduisMask = .top) {
        cornerValue = cornerRadusMask
        cornerPosition = positionCornerRadius
        super.init(frame: .zero)
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - func
    func applyCornerRadius() {
        layer.mask = makeCornerRadius()
    }

    // MARK: - private func
    private func makeCornerRadius() -> CAShapeLayer {
        var roundingCorners: UIRectCorner = .init()
        switch cornerPosition {
        case .top:
            roundingCorners = [.topLeft, .topRight]
        case .bottom:
            roundingCorners = [.bottomLeft, .bottomRight]
        }

        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: roundingCorners,
                                cornerRadii: CGSize(width: cornerValue.rawValue, height: cornerValue.rawValue))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        return maskLayer
    }
}
