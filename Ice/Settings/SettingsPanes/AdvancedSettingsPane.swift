//
//  AdvancedSettingsPane.swift
//  Ice
//

import SwiftUI

/// Возвращает слово «секунда» в нужной форме для заданного числа.
fileprivate func secondsWord(for value: Double) -> String {
    guard value == value.rounded() else {
        return "секунды"
    }
    let n = Int(value)
    if n % 10 == 1 && n % 100 != 11 {
        return "секунда"
    }
    if (2...4).contains(n % 10) && !(12...14).contains(n % 100) {
        return "секунды"
    }
    return "секунд"
}

struct AdvancedSettingsPane: View {
    @EnvironmentObject var appState: AppState
    @State private var maxSliderLabelWidth: CGFloat = 0

    private var menuBarManager: MenuBarManager {
        appState.menuBarManager
    }

    private var manager: AdvancedSettingsManager {
        appState.settingsManager.advancedSettingsManager
    }

    private func formattedToSeconds(_ interval: TimeInterval) -> LocalizedStringKey {
        let formatted = interval.formatted()
        return LocalizedStringKey(formatted + " " + secondsWord(for: interval))
    }

    var body: some View {
        IceForm {
            IceSection {
                hideApplicationMenus
                showSectionDividers
                showAllSectionsOnUserDrag
                showContextMenuOnRightClick
            }
            IceSection {
                enableAlwaysHiddenSection
                canToggleAlwaysHiddenSection
            }
            IceSection {
                showOnHoverDelaySlider
                tempShowIntervalSlider
            }
            IceSection("Разрешения") {
                allPermissions
            }
        }
    }

    @ViewBuilder
    private var hideApplicationMenus: some View {
        Toggle("Скрывать меню приложений при показе объектов строки меню", isOn: manager.bindings.hideApplicationMenus)
            .annotation("Освободите место в строке меню, скрыв при необходимости меню приложений слева")
    }

    @ViewBuilder
    private var showSectionDividers: some View {
        Toggle("Показывать разделители секций", isOn: manager.bindings.showSectionDividers)
            .annotation {
                HStack(spacing: 2) {
                    Text("Вставлять объекты-разделители")
                    if let nsImage = ControlItemImage.builtin(.chevronLarge).nsImage(for: appState) {
                        HStack(spacing: 0) {
                            Text("(")
                                .font(.body.monospaced().bold())
                            Image(nsImage: nsImage)
                                .padding(.horizontal, -2)
                            Text(")")
                                .font(.body.monospaced().bold())
                        }
                    }
                    Text("между секциями")
                }
            }
    }

    @ViewBuilder
    private var enableAlwaysHiddenSection: some View {
        Toggle("Включить всегда скрытую секцию", isOn: manager.bindings.enableAlwaysHiddenSection)
    }

    @ViewBuilder
    private var canToggleAlwaysHiddenSection: some View {
        if manager.enableAlwaysHiddenSection {
            Toggle("Разрешить показ всегда скрытой секции", isOn: manager.bindings.canToggleAlwaysHiddenSection)
                .annotation {
                    if appState.settingsManager.generalSettingsManager.showOnClick {
                        Text("Нажмите, удерживая клавишу Option, на один из объектов Ice в строке меню или на пустое место в строке меню, чтобы показать секцию")
                    } else {
                        Text("Нажмите, удерживая клавишу Option, на один из объектов Ice в строке меню, чтобы показать секцию")
                    }
                }
        }
    }

    @ViewBuilder
    private var showOnHoverDelaySlider: some View {
        IceLabeledContent {
            IceSlider(
                formattedToSeconds(manager.showOnHoverDelay),
                value: manager.bindings.showOnHoverDelay,
                in: 0...1,
                step: 0.1
            )
        } label: {
            Text("Задержка показа при наведении")
                .frame(minHeight: .compactSliderMinHeight)
                .frame(minWidth: maxSliderLabelWidth, alignment: .leading)
                .onFrameChange { frame in
                    maxSliderLabelWidth = max(maxSliderLabelWidth, frame.width)
                }
        }
        .annotation("Время ожидания перед показом при наведении")
    }

    @ViewBuilder
    private var tempShowIntervalSlider: some View {
        IceLabeledContent {
            IceSlider(
                formattedToSeconds(manager.tempShowInterval),
                value: manager.bindings.tempShowInterval,
                in: 0...30,
                step: 1
            )
        } label: {
            Text("Задержка скрытия временно показанных объектов")
                .frame(minHeight: .compactSliderMinHeight)
                .frame(minWidth: maxSliderLabelWidth, alignment: .leading)
                .onFrameChange { frame in
                    maxSliderLabelWidth = max(maxSliderLabelWidth, frame.width)
                }
        }
        .annotation("Время ожидания перед скрытием временно показанных объектов строки меню")
    }

    @ViewBuilder
    private var showAllSectionsOnUserDrag: some View {
        Toggle("Показывать все секции при перетаскивании объектов строки меню с нажатой клавишей Command", isOn: manager.bindings.showAllSectionsOnUserDrag)
    }

    @ViewBuilder
    private var showContextMenuOnRightClick: some View {
        Toggle("Показывать контекстное меню по нажатию правой кнопкой", isOn: manager.bindings.showContextMenuOnRightClick)
    }

    @ViewBuilder
    private var allPermissions: some View {
        ForEach(appState.permissionsManager.allPermissions) { permission in
            IceLabeledContent {
                if permission.hasPermission {
                    Label {
                        Text("Разрешение выдано")
                    } icon: {
                        Image(systemName: "checkmark.circle")
                            .foregroundStyle(.green)
                    }
                } else {
                    Button("Выдать разрешение") {
                        permission.performRequest()
                    }
                }
            } label: {
                Text(permission.title)
            }
            .frame(height: 22)
        }
    }
}

#Preview {
    AdvancedSettingsPane()
        .fixedSize()
        .environmentObject(AppState())
}
