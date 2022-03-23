//
//  FeedProtocols.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 02.02.2022.
//

import UIKit

protocol FeedCollectionProtocol: AnyObject {
    func updatePhoto(with name: UIImage)
}

protocol FeedProtocol: AnyObject {
    func update()
}
