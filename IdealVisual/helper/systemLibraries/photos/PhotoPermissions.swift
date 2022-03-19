//
//  PhotoPermissions.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 15.03.2022.
//

import Photos

final class PhotoPermissions {
    static let shared = PhotoPermissions()
    private(set) var photoLibraryStatus = PHPhotoLibrary.authorizationStatus()

    init() {
        checkPhotoLibraryPermission()
    }

    private func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            photoLibraryStatus = .authorized
        case .denied, .restricted, .limited:
            photoLibraryStatus = .denied
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    self.photoLibraryStatus = .authorized
                case .denied, .restricted, .limited:
                    self.photoLibraryStatus = .denied
                case .notDetermined:
                    self.photoLibraryStatus = .notDetermined
                @unknown default:
                    self.photoLibraryStatus = .notDetermined
                }
            }
        @unknown default:
            self.photoLibraryStatus = .notDetermined
        }
    }
}
