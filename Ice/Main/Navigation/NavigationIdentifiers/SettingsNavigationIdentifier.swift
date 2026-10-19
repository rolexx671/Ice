//
//  SettingsNavigationIdentifier.swift
//  Ice
//

import SwiftUI

/// An identifier used for navigation in the settings interface.
enum SettingsNavigationIdentifier: String, NavigationIdentifier {
    case general = "General"
    case menuBarLayout = "Menu Bar Layout"
    case menuBarAppearance = "Menu Bar Appearance"
    case hotkeys = "Hotkeys"
    case advanced = "Advanced"
    case about = "About"

    /// Русское имя раздела для отображения (``rawValue`` не меняется).
    var localized: LocalizedStringKey {
        switch self {
        case .general: "Основные"
        case .menuBarLayout: "Расположение"
        case .menuBarAppearance: "Внешний вид"
        case .hotkeys: "Сочетания клавиш"
        case .advanced: "Дополнительно"
        case .about: "О программе"
        }
    }
}
