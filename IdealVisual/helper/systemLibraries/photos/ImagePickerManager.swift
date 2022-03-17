//
//  ImagePickerManager.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 15.03.2022.
//

import Foundation
import UIKit

protocol ImagePickerManagerProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    var pickImageCallback: (UIImage?) -> Void { get set }
}

final class ImagePickerManager: NSObject, ImagePickerManagerProtocol {
    // MARK: - ui elements
    private let picker = UIImagePickerController()
    private let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?

    // MARK: - data
    var pickImageCallback: (UIImage?) -> Void = { _ in }

    // MARK: - lifecycle
    override init() {
        super.init()
        picker.delegate = self
        addActions()
    }

    // MARK: - private func
    private func addActions() {
        let cameraAction = UIAlertAction(title: PhotoStrings.camera.localized, style: .default) { _ in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: PhotoStrings.gallery.localized, style: .default) { _ in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: CommonStrings.cancel.localized, style: .cancel)
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
    }

    private func openCamera() {
        alert.dismiss(animated: true)
        switch PhotoPermissions.shared.photoLibraryStatus {
        case .authorized:
            if  UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
                guard let viewController = self.viewController else {
                    Logger.log("no view controller")
                    return
                }
                viewController.present(picker, animated: true, completion: nil)
            } else {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let warningAlert = configureWarningAlertWith(sourceType: .photoLibrary)
                    showAlert(warningAlert)
                }
                if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                    let warningAlert = configureWarningAlertWith(sourceType: .savedPhotosAlbum)
                    showAlert(warningAlert)
                }
            }
        case .notDetermined, .restricted, .denied, .limited:
            let errorAlert = configureErrorAlert()
            showAlert(errorAlert)
        @unknown default:
            let errorAlert = configureErrorAlert()
            showAlert(errorAlert)
        }
    }

    private func openGallery() {
        alert.dismiss(animated: true)
        picker.sourceType = .photoLibrary
        guard let viewController = self.viewController else {
            Logger.log("no view controller")
            return
        }
        viewController.present(picker, animated: true)
    }

    private func configureWarningAlertWith(sourceType: UIImagePickerController.SourceType) -> UIAlertController {
        var message: String
        switch sourceType {
        case .camera:
            message = PhotoStrings.haventCamera.localized
        case .photoLibrary:
            message = PhotoStrings.wrongGallery.localized
        case .savedPhotosAlbum:
            message = PhotoStrings.wrongSavedPhoto.localized
        @unknown default:
            message = ErrorStrings.unknown.localized
        }
        let alertWarning = UIAlertController(title: ErrorStrings.warning.localized, message: message,
                                             preferredStyle: .alert)
        let action = UIAlertAction(title: CommonStrings.ok.localized, style: .default)
        alertWarning.addAction(action)
        return alertWarning
    }

    private func configureErrorAlert() -> UIAlertController {
        let alertWarning = UIAlertController(title: ErrorStrings.unknown.localized, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: CommonStrings.ok.localized, style: .default)
        alertWarning.addAction(action)
        return alertWarning
    }

    private func showAlert(_ alert: UIAlertController) {
        guard let viewController = self.viewController else {
            Logger.log("no view controller")
            return
        }
        viewController.present(alert, animated: true)
    }
}

// MARK: - extension
extension ImagePickerManager: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func pickImage(_ viewController: UIViewController, _ callback: @escaping (UIImage?) -> Void) {
        pickImageCallback = callback
        self.viewController = viewController
        guard let viewController = self.viewController else {
            Logger.log("no view controller")
            return
        }
        alert.popoverPresentationController?.sourceView = viewController.view
        viewController.present(alert, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            Logger.log("Expected a dictionary containing an image, but was provided the following: \(info)")
            return pickImageCallback(nil)
        }
        pickImageCallback(image)
    }
}
