//
//  FeedProtocols.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 02.02.2022.
//

import UIKit

protocol FeedProtocol: AnyObject {
    func update()
    func swapImages(source: Int, destination: Int)
}

protocol FeedCollectionProtocol: AnyObject {
    func swapImages(source: Int, destination: Int)
}

protocol FeedCollectionCellProtocol: AnyObject {
    func updatePhoto(with name: UIImage)
    func getImage() -> UIImage?
}
