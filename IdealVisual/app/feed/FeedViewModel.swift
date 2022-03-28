//
//  FeedViewModel.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 20.12.2021.
//

import UIKit
import PromiseKit

protocol FeedViewModelProtocol: AnyObject {
    var bind: (() -> ()) { get set }
    var feedPhotos: [UIImage] { get }

    func fetchFeedImages()
    func swapImages(source: Int, destination: Int, completion: @escaping (Bool) -> Void)
    func addPost()
}

final class FeedViewModel: FeedViewModelProtocol {
    fileprivate var feedModelServise: FeedModelServiceProtocol

    var feedPhotos: [UIImage] {
        didSet {
            self.bind()
        }
    }

    var bind: (() -> ()) = {}

    init() {
        feedModelServise = FeedModelService()
        feedPhotos = []
    }

    func fetchFeedImages() {
        firstly {
            feedModelServise.getPhotosPaths()
        }.then { imagesPaths in
            self.feedModelServise.getPhotosData(with: imagesPaths)
        }.done { imagesData in
            imagesData.forEach {
                guard let image = UIImage(data: $0) else { return }
                self.feedPhotos.append(image)
            }
        }.catch { error in
            Logger.log(error)
        }
    }

    func swapImages(source: Int, destination: Int, completion: @escaping (Bool) -> Void) {
        var swapResult: Bool = true
        DispatchQueue.main.async {
            completion(swapResult)
        }
    }

    func addPost() {
        
    }
}
