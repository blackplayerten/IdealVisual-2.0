//
//  DarkThemeColors.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 10.12.2021.
//

import Foundation
import UIKit

final class DarkThemeColors: AppThemeColorsComponents {
    var background: UIColor = {
        .black
    }()

    var titleText: UIColor = {
        .black
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
