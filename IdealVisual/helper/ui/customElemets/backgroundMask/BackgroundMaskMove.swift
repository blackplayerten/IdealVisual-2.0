//
//  BackgroundMaskMove.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 21.02.2022.
//

import UIKit

extension BackgroundMaskViewController {
    // MARK: - func
    func setupPanGesture() {
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanAction(gesture:)))
        panGR.delaysTouchesBegan = false
        panGR.delaysTouchesEnded = false
        view.addGestureRecognizer(panGR)
    }

    func animatePresentBackgroundMask() {
        UIView.animate(withDuration: 0.5) {
            self.backgroundMaskView.snp.remakeConstraints {
                $0.left.right.bottom.equalTo(self.view)
                $0.height.equalTo(self.currentHeight)
            }
            if self.addImage {
                self.setupImageView()
            }
            self.view.layoutIfNeeded()
        }
    }

    func animateMaskHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.backgroundMaskView.snp.remakeConstraints {
                $0.left.right.bottom.equalTo(self.view)
                $0.height.equalTo(height)
            }
            self.view.layoutIfNeeded()
        }
        currentHeight = height
    }

    func animateDismissMask() {
        UIView.animate(withDuration: 0.3) {
            self.backgroundMaskView.snp.remakeConstraints {
                $0.height.equalTo(0)
                $0.left.right.bottom.equalTo(self.view)
            }
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }

    // MARK: - private func
    @objc
    private func handlePanAction(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let newHeight = currentHeight - translation.y

        switch gesture.state {
        case .changed:
            if newHeight < getBackgroundMaskHeight(height: .large) {
                backgroundMaskView.snp.remakeConstraints {
                    $0.left.right.bottom.equalTo(self.view)
                    $0.height.equalTo(newHeight)
                }
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < getBackgroundMaskHeight(height: .half) {
                animateMaskHeight(getBackgroundMaskHeight(height: .small))
            }
            if newHeight < getBackgroundMaskHeight(height: .large) && isDraggingDown {
                animateMaskHeight(getBackgroundMaskHeight(height: .half))
            }
            if newHeight > getBackgroundMaskHeight(height: .small) && !isDraggingDown {
                animateMaskHeight(getBackgroundMaskHeight(height: .large))
            }
            if newHeight < getBackgroundMaskHeight(height: .small) {
                canDismiss ? animateDismissMask() : animateMaskHeight(getBackgroundMaskHeight(height: .small))
            }
        default:
            break
        }
    }
}
