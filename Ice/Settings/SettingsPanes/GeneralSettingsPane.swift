//
//  GeneralSettingsPane.swift
//  Ice
//

import LaunchAtLogin
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

struct GeneralSettingsPane: View {
    @EnvironmentObject var appState: AppState
    @State private var isImportingCustomIceIcon = false
    @State private var isPresentingError = false
    @State private var presentedError: LocalizedErrorWrapper?
    @State private var isApplyingOffset = false
    @State private var tempItemSpacingOffset: CGFloat = 0 // Temporary state for the slider

    private var manager: GeneralSettingsManager {
        appState.settingsManager.generalSettingsManager
    }

    private var itemSpacingOffset: LocalizedStringKey {
        localizedOffsetString(for: manager.itemSpacingOffset)
    }

    private func localizedOffsetString(for offset: CGFloat) -> LocalizedStringKey {
        switch offset {
        case -16:
            return LocalizedStringKey("нет")
        case 0:
            return LocalizedStringKey("по умолчанию")
        case 16:
            return LocalizedStringKey("макс.")
        default:
            return LocalizedStringKey(offset.formatted())
        }
    }

    private var rehideIntervalKey: LocalizedStringKey {
        let formatted = manager.rehideInterval.formatted()
        return LocalizedStringKey(formatted + " " + secondsWord(for: manager.rehideInterval))
    }

    private var hasSpacingSliderValueChanged: Bool {
        tempItemSpacingOffset != manager.itemSpacingOffset
    }

    private var isActualOffsetDifferentFromDefault: Bool {
        manager.itemSpacingOffset != 0
    }

    var body: some View {
        IceForm {
            IceSection {
                launchAtLogin
            }
            IceSection {
                iceIconOptions
            }
            IceSection {
                iceBarOptions
            }
            IceSection {
                showOnClick
                showOnHover
                showOnScroll
            }
            IceSection {
                autoRehideOptions
            }
            IceSection {
                spacingOptions
            }
        }
        .alert(isPresented: $isPresentingError, error: presentedError) {
            Button("ОК") {
                presentedError = nil
                isPresentingError = false
            }
        }
    }

    @ViewBuilder
    private var launchAtLogin: some View {
        LaunchAtLogin.Toggle("Открывать при входе")
    }

    @ViewBuilder
    private func menuItem(for imageSet: ControlItemImageSet) -> some View {
        Label {
            Text(imageSet.name.displayName)
        } icon: {
            if let nsImage = imageSet.hidden.nsImage(for: appState) {
                switch imageSet.name {
                case .custom:
                    Image(size: CGSize(width: 18, height: 18)) { context in
                        context.draw(
                            Image(nsImage: nsImage),
                            in: context.clipBoundingRect
                        )
                    }
                default:
                    Image(nsImage: nsImage)
                }
            }
        }
    }

    @ViewBuilder
    private var iceIconOptions: some View {
        Toggle("Показывать значок Ice", isOn: manager.bindings.showIceIcon)
            .annotation {
                if !manager.showIceIcon {
                    Text("Настройки Ice по-прежнему доступны по нажатию правой кнопкой на пустом месте в строке меню")
                }
            }
        if manager.showIceIcon {
            IceMenu("Значок Ice") {
                Picker("Значок Ice", selection: manager.bindings.iceIcon) {
                    ForEach(ControlItemImageSet.userSelectableIceIcons) { imageSet in
                        Button {
                            manager.iceIcon = imageSet
                        } label: {
                            menuItem(for: imageSet)
                        }
                        .tag(imageSet)
                    }
                    if let lastCustomIceIcon = manager.lastCustomIceIcon {
                        Button {
                            manager.iceIcon = lastCustomIceIcon
                        } label: {
                            menuItem(for: lastCustomIceIcon)
                        }
                        .tag(lastCustomIceIcon)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()

                Divider()

                Button("Выбрать изображение…") {
                    isImportingCustomIceIcon = true
                }
            } title: {
                menuItem(for: manager.iceIcon)
            }
            .annotation("Выберите свой значок для отображения в строке меню")
            .fileImporter(
                isPresented: $isImportingCustomIceIcon,
                allowedContentTypes: [.image]
            ) { result in
                do {
                    let url = try result.get()
                    if url.startAccessingSecurityScopedResource() {
                        defer { url.stopAccessingSecurityScopedResource() }
                        let data = try Data(contentsOf: url)
                        manager.iceIcon = ControlItemImageSet(name: .custom, image: .data(data))
                    }
                } catch {
                    presentedError = LocalizedErrorWrapper(error)
                    isPresentingError = true
                }
            }

            if case .custom = manager.iceIcon.name {
                Toggle("Применять системную тему к значку", isOn: manager.bindings.customIceIconIsTemplate)
                    .annotation("Показывать значок монохромным изображением в соответствии с оформлением системы")
            }
        }
    }

    @ViewBuilder
    private var iceBarOptions: some View {
        useIceBar
        if manager.useIceBar {
            iceBarLocationPicker
        }
    }

    @ViewBuilder
    private var useIceBar: some View {
        Toggle("Использовать Ice Bar", isOn: manager.bindings.useIceBar)
            .annotation("Показывать скрытые объекты строки меню в отдельной панели под строкой меню")
    }

    @ViewBuilder
    private var iceBarLocationPicker: some View {
        IcePicker("Расположение", selection: manager.bindings.iceBarLocation) {
            ForEach(IceBarLocation.allCases) { location in
                Text(location.localized).tag(location)
            }
        }
        .annotation {
            switch manager.iceBarLocation {
            case .dynamic:
                Text("Расположение Ice Bar зависит от контекста")
            case .mousePointer:
                Text("Ice Bar располагается по центру под указателем мыши")
            case .iceIcon:
                Text("Ice Bar располагается по центру под значком Ice")
            }
        }
    }

    @ViewBuilder
    private var showOnClick: some View {
        Toggle("Показывать по нажатию", isOn: manager.bindings.showOnClick)
            .annotation("Нажмите на пустое место в строке меню, чтобы показать скрытые объекты строки меню")
    }

    @ViewBuilder
    private var showOnHover: some View {
        Toggle("Показывать при наведении", isOn: manager.bindings.showOnHover)
            .annotation("Наведите указатель на пустое место в строке меню, чтобы показать скрытые объекты строки меню")
    }

    @ViewBuilder
    private var showOnScroll: some View {
        Toggle("Показывать при прокрутке", isOn: manager.bindings.showOnScroll)
            .annotation("Прокрутите или проведите пальцами по строке меню, чтобы показать или скрыть объекты строки меню")
    }

    @ViewBuilder
    private var spacingOptions: some View {
        IceLabeledContent {
            IceSlider(
                localizedOffsetString(for: tempItemSpacingOffset),
                value: $tempItemSpacingOffset,
                in: -16...16,
                step: 2
            )
            .disabled(isApplyingOffset)
        } label: {
            IceLabeledContent {
                Button("Применить") {
                    applyOffset()
                }
                .help("Применить текущий интервал")
                .disabled(isApplyingOffset || !hasSpacingSliderValueChanged)

                if isApplyingOffset {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(0.5)
                        .frame(width: 15, height: 15)
                } else {
                    Button {
                        resetOffsetToDefault()
                    } label: {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                    }
                    .buttonStyle(.borderless)
                    .help("Вернуть интервал по умолчанию")
                    .disabled(isApplyingOffset || !isActualOffsetDifferentFromDefault)
                }
            } label: {
                HStack {
                    Text("Интервал между объектами строки меню")
                    BetaBadge()
                }
            }
        }
        .annotation(
            "При применении этой настройки все приложения с объектами строки меню будут перезапущены. Некоторые приложения, возможно, придётся перезапустить вручную.",
            spacing: 2
        )
        .annotation(spacing: 10, font: .callout.bold()) {
            IceGroupBox {
                Label {
                    Text("Примечание: чтобы настройка применилась корректно, может потребоваться выйти из системы и войти снова.")
                } icon: {
                    Image(systemName: "exclamationmark.circle")
                }
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear {
            tempItemSpacingOffset = manager.itemSpacingOffset
        }
    }

    @ViewBuilder
    private var rehideStrategyPicker: some View {
        IcePicker("Повторное скрытие", selection: manager.bindings.rehideStrategy) {
            ForEach(RehideStrategy.allCases) { strategy in
                Text(strategy.localized).tag(strategy)
            }
        }
        .annotation {
            switch manager.rehideStrategy {
            case .smart:
                Text("Объекты строки меню скрываются повторно по умному алгоритму")
            case .timed:
                Text("Объекты строки меню скрываются повторно через заданное время")
            case .focusedApp:
                Text("Объекты строки меню скрываются повторно при смене активного приложения")
            }
        }
    }

    @ViewBuilder
    private var autoRehideOptions: some View {
        Toggle("Скрывать повторно автоматически", isOn: manager.bindings.autoRehide)
        if manager.autoRehide {
            if case .timed = manager.rehideStrategy {
                VStack {
                    rehideStrategyPicker
                    IceSlider(
                        rehideIntervalKey,
                        value: manager.bindings.rehideInterval,
                        in: 0...30,
                        step: 1
                    )
                }
            } else {
                rehideStrategyPicker
            }
        }
    }

    /// Apply menu bar spacing offset.
    private func applyOffset() {
        isApplyingOffset = true
        manager.itemSpacingOffset = tempItemSpacingOffset
        Task {
            do {
                try await appState.spacingManager.applyOffset()
            } catch {
                let alert = NSAlert(error: error)
                alert.runModal()
            }
            isApplyingOffset = false
        }
    }

    /// Reset menu bar spacing offset to default.
    private func resetOffsetToDefault() {
        tempItemSpacingOffset = 0
        manager.itemSpacingOffset = tempItemSpacingOffset
        applyOffset()
    }
}
