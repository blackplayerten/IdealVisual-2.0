//
//  AppThemeColorsComponents.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 10.12.2021.
//

import Foundation
import UIKit

protocol AppThemeColorsComponents: AnyObject {
    var background: UIColor { get }
    var titleText: UIColor { get }
    var secondaryText: UIColor { get }
    var inputFiledPlaceholder: UIColor { get }
    var inputFieldText: UIColor { get }
    var saveButtonBackground: UIColor { get set }
    var saveButtonText: UIColor { get set }
    var defaultAvatar: UIColor { get set }
    var loadingIndicator: UIColor { get set }
}
