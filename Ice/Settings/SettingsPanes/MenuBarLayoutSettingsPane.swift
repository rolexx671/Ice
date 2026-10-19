//
//  MenuBarLayoutSettingsPane.swift
//  Ice
//

import SwiftUI

struct MenuBarLayoutSettingsPane: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        if !ScreenCapture.cachedCheckPermissions() {
            missingScreenRecordingPermission
        } else if appState.menuBarManager.isMenuBarHiddenBySystemUserDefaults {
            cannotArrange
        } else {
            IceForm(alignment: .leading, spacing: 20) {
                header
                layoutBars
            }
        }
    }

    @ViewBuilder
    private var header: some View {
        Text("Перетащите объекты строки меню, чтобы расставить их")
            .font(.title2)

        IceGroupBox {
            AnnotationView(
                alignment: .center,
                font: .callout.bold()
            ) {
                Label {
                    Text("Совет: объекты строки меню можно также расставлять, перетаскивая их в строке меню с нажатой клавишей Command")
                } icon: {
                    Image(systemName: "lightbulb")
                }
            }
        }
    }

    @ViewBuilder
    private var layoutBars: some View {
        VStack(spacing: 25) {
            ForEach(MenuBarSection.Name.allCases, id: \.self) { section in
                layoutBar(for: section)
            }
        }
    }

    @ViewBuilder
    private var cannotArrange: some View {
        Text("Ice не может расставлять объекты в автоматически скрываемой строке меню")
            .font(.title3)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }

    @ViewBuilder
    private var missingScreenRecordingPermission: some View {
        VStack {
            Text("Для расположения объектов строки меню требуется разрешение на запись экрана")
                .font(.title2)

            Button {
                appState.navigationState.settingsNavigationIdentifier = .advanced
            } label: {
                Text("Перейти в дополнительные настройки")
            }
            .buttonStyle(.link)
        }
    }

    @ViewBuilder
    private func layoutBar(for section: MenuBarSection.Name) -> some View {
        if
            let section = appState.menuBarManager.section(withName: section),
            section.isEnabled
        {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(section.name.displayString) секция")
                    .font(.system(size: 14))
                    .padding(.leading, 2)

                LayoutBar(section: section)
                    .environmentObject(appState.imageCache)
            }
        }
    }
}
