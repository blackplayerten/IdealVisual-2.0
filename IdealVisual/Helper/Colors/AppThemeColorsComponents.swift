//
//  AppThemeColorsComponents.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 10.12.2021.
//

import Foundation
import UIKit

protocol AppThemeColorsComponents: AnyObject {
    var background: UIColor { get set }
    var titleText: UIColor { get set }
    var secondaryText: UIColor { get set }
    var inputFiledPlaceholder: UIColor { get set }
    var inputFieldText: UIColor { get set }
    var saveButtonBackground: UIColor { get set }
    var saveButtonText: UIColor { get set }
    var defaultAvatar: UIColor { get set }
    var loadingIndicator: UIColor { get set }
}
