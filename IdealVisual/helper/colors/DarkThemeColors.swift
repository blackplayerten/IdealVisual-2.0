//
//  DarkThemeColors.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 10.12.2021.
//

import UIKit

final class DarkThemeColors: AppThemeColorsComponents {
    var background: UIColor = {
        .black
    }()

    var titleText: UIColor = {
        .white
    }()

    var secondaryText: UIColor = {
        .lightGray
    }()

    var inputFiledPlaceholder: UIColor = {
        .lightGray
    }()
    
    var inputFieldText: UIColor = {
        .white
    }()
    
    var saveButtonBackground: UIColor = {
        .systemGreen
    }()

    var buttonBackground: UIColor = {
        .init(red: 0.892, green: 0.812, blue: 0.739, alpha: 1)
    }()

    var saveButtonText: UIColor = {
        .white
    }()

    var defaultAvatar: UIColor = {
        .gray
    }()

    var loadingIndicator: UIColor = {
        .orange
    }()
}
