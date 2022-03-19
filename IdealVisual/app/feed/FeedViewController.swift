//
//  FeedViewController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import UIKit

final class FeedViewController: UIViewController {
    var feed = FeedCollectionView()
    //MARK: - data
    private var viewModel: FeedViewModelProtocol? {
        didSet {
            bind()
        }
    }

    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FeedViewModel()
        configureFeed()
        setupFeed()
        fetchImages()
    }

    //MARK: - private func
    private func bind() {
        guard let viewModel = viewModel else { return Logger.log("no view model") }
        viewModel.bind = { self.update() }
    }

    private func configureFeed() {
        feed.frame = view.frame
        feed.flowLayoutDelegate = FeedCollectionViewFlowLayoutDelegate(view: self.view, collectionView: feed)
        feed.registerCells([FeedCollectionViewCell.self])
    }

    private func setupFeed() {
        view.addSubview(feed)
        feed.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            $0.left.right.equalToSuperview()
        }
    }

    private func fetchImages() {
        DispatchQueue.main.async {
            guard let viewModel = self.viewModel else { return Logger.log("nil self or no view model") }
            viewModel.fetchFeedImages()
        }
    }
}

// MARK: - extension
extension FeedViewController: FeedProtocol {
    func update() {
        if let data = viewModel?.feedPhotos {
            feed.items = data
            feed.reloadData()
        }
    }
}
