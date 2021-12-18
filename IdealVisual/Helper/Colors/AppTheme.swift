//
//  Colors.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import Foundation
import UIKit

final class AppTheme {
    static let shared: AppTheme = AppTheme(theme: .light)
    private static let configParameterName = "theme"
    private(set) var colorsComponents: AppThemeColorsComponents

    enum Mode: Int {
        case light = 1
        case dark
    }

     var mode: Mode {
         willSet(newValue) {
             switch newValue {
             case .light:
                 colorsComponents = AppTheme.light
             case .dark:
                 colorsComponents = AppTheme.dark
             }
             let userDefaults = UserDefaults.standard
             userDefaults.setValue(newValue.rawValue, forKey: AppTheme.configParameterName)
             userDefaults.synchronize()
         }
     }

     private init(theme: Mode) {
         self.colorsComponents = AppTheme.light
         self.mode = theme
     }

    static let light = LightThemeColors()
    static let dark = DarkThemeColors()
 }

