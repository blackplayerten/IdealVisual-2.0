//
//  SignUpViewController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import Foundation
import UIKit

final class SignUpViewController: UIViewController {
    private var director: SingleLineTypesFieldBuilderBoss
    // MARK: - data
    private var viewModel: SignInViewModelProtocol? {
        didSet {
           
        }
    }
    weak var delegate: AuthViewControllerDelegate?

    init(director: SingleLineTypesFieldBuilderBoss, delegate: AuthViewControllerDelegate) {
        self.director = director
        self.delegate = delegate
        super.init(nibName: nil, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
