//
//  FeedViewController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import UIKit

final class FeedViewController: UIViewController, FeedCollectionProtocol {
    var feed: FeedCollectionView?

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

    init() {
        super.init(nibName: nil, bundle: .main)
        feed = FeedCollectionView(collectionProtocol: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - private func
    private func bind() {
        guard let viewModel = viewModel else { return Logger.log("no view model") }
        viewModel.bind = { self.update() }
    }

    private func configureFeed() {
        guard let feed = feed else { return }
        feed.frame = view.frame
        feed.flowLayoutDelegate = FeedCollectionViewFlowLayoutDelegate(view: self.view, collectionView: feed)
        feed.registerCells([FeedCollectionViewCell.self])
    }

    private func setupFeed() {
        guard let feed = feed else { return }
        view.addSubview(feed)
        feed.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            $0.left.right.equalToSuperview()
        }
    }

    private func fetchImages() {
        guard let viewModel = self.viewModel else { return Logger.log("nil self or no view model") }
        viewModel.fetchFeedImages()
    }

    func addPost() {
        guard let viewModel = self.viewModel else { return Logger.log("nil self or no view model") }
        viewModel.addPost()
    }
}

// MARK: - extension
extension FeedViewController: FeedProtocol {
    func update() {
        if let data = viewModel?.feedPhotos {
            guard let feed = feed else { return }
            feed.items = data
            feed.reloadData()
        }
    }

    func swapImages(source: Int, destination: Int) {
        guard let viewModel = viewModel else { return Logger.log("no view model") }
        viewModel.swapImages(source: source, destination: destination) { [weak self] (swapResult) in
            if swapResult {
                guard let self = self,
                        let feed = self.feed
                else { return }
                feed.swapImages(source: source, destination: destination)
            } else {
                Logger.log("failed swap")
            }
        }
    }
}
