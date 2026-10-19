//
//  HotkeysSettingsPane.swift
//  Ice
//

import SwiftUI

struct HotkeysSettingsPane: View {
    @EnvironmentObject var appState: AppState

    private var hotkeySettingsManager: HotkeySettingsManager {
        appState.settingsManager.hotkeySettingsManager
    }

    var body: some View {
        IceForm {
            IceSection("Секции строки меню") {
                hotkeyRecorder(forSection: .hidden)
                hotkeyRecorder(forSection: .alwaysHidden)
            }
            IceSection("Объекты строки меню") {
                hotkeyRecorder(forAction: .searchMenuBarItems)
            }
            IceSection("Другое") {
                hotkeyRecorder(forAction: .enableIceBar)
                hotkeyRecorder(forAction: .showSectionDividers)
                hotkeyRecorder(forAction: .toggleApplicationMenus)
            }
        }
    }

    @ViewBuilder
    private func hotkeyRecorder(forAction action: HotkeyAction) -> some View {
        if let hotkey = hotkeySettingsManager.hotkey(withAction: action) {
            HotkeyRecorder(hotkey: hotkey) {
                switch action {
                case .toggleHiddenSection:
                    Text("Показать или скрыть скрытую секцию")
                case .toggleAlwaysHiddenSection:
                    Text("Показать или скрыть всегда скрытую секцию")
                case .searchMenuBarItems:
                    Text("Поиск объектов строки меню")
                case .enableIceBar:
                    Text("Включить Ice Bar")
                case .showSectionDividers:
                    Text("Показывать разделители секций")
                case .toggleApplicationMenus:
                    Text("Показать или скрыть меню приложений")
                }
            }
        }
    }

    @ViewBuilder
    private func hotkeyRecorder(forSection name: MenuBarSection.Name) -> some View {
        if appState.menuBarManager.section(withName: name)?.isEnabled == true {
            if case .hidden = name {
                hotkeyRecorder(forAction: .toggleHiddenSection)
            } else if case .alwaysHidden = name {
                hotkeyRecorder(forAction: .toggleAlwaysHiddenSection)
            }
        }
    }
}
