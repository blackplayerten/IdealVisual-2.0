//
//  AppLoaderViewController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import UIKit

class LaunchViewController: UIViewController, LaunchViewInput {
    //MARK: - constants
    private struct UIConstants {
        static let leftRightMargin: Float = 10.0
        static let sizeLoadingIndicator: CGSize = .init(width: 50.0, height: 50.0)
    }

    //MARK: - ui elements
    private var alert: UIAlertController?
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = AppTheme.shared.colorsComponents.background
        indicator.hidesWhenStopped = true
        return indicator
    }()

    //MARK: - data
    private var viewModel: LaunchViewModelProtocol & LaunchViewModelInput & LaunchViewModelOutput
    var warningType: ConnectionWarningType?

    init(viewModel: LaunchViewModelProtocol & LaunchViewModelInput & LaunchViewModelOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
        self.viewModel.bindAlertMessage = { self.updateAlertMessage() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureAlert()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let alert = alert else { return Logger.log("no app loader alert") }
        present(alert, animated: true) { [weak self] in
            DispatchQueue.main.async {
                guard let self = self, let warningType = self.warningType else { return Logger.log("nil self or no view model") }
                self.configureWarning(with: warningType)
            }
        }
    }
    
    //MARK: - private func
    private func configureAlert() {
        let alert = UIAlertController(title: nil, message: viewModel.alertUpdatedMessage, preferredStyle: .alert)

        alert.view.backgroundColor = .white
        alert.view.layer.backgroundColor = UIColor.white.cgColor
        alert.view.layer.cornerRadius = 20.0
        alert.view.layer.masksToBounds = true
        alert.setValue(NSMutableAttributedString(string: alert.message ?? "",
                                                 attributes: [NSAttributedString.Key.font: UIFont(name: UIFont.Names.system,
                                                                                                  size: UIFont.Sizes.small)!]),
                       forKey: "attributedMessage")

        alert.view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints {
            $0.left.equalTo(alert.view).inset(UIConstants.leftRightMargin)
            $0.centerY.equalTo(alert.view)
        }
        loadingIndicator.startAnimating()

        self.alert = alert
    }

    private func updateAlertMessage() {
        guard let alert = alert else { return Logger.log("no app loader alert") }
        alert.message = viewModel.alertUpdatedMessage
        loadingIndicator.stopAnimating()
    }

    private func configureWarning(with type: ConnectionWarningType) {
        viewModel.configureWarning(type: type)
    }
}

extension LaunchViewController: Presentable {
    var present: UIViewController { get{ self } set{} }
}
