# Заметки разведки: перевод Ice на русский

Оценки числа строк приблизительные (эвристика grep по Text/Label/Button/Toggle/.help/NSAlert/NSMenuItem + литералы с пробелами). Перед переводом каждый файл надо читать целиком. Ни одного .lproj / .xcstrings / .strings в проекте нет.

## 1. Раскладка

- `Ice.xcodeproj` — проект. Папка `Ice` подключена как PBXFileSystemSynchronizedRootGroup: новые файлы подхватываются сами.
  Из сборки исключены `Info.plist` и `Resources/Acknowledgements.rtf`.
- `Ice/Info.plist` — только ключи Sparkle (см. п.4/5). Остальной Info.plist генерируется (GENERATE_INFOPLIST_FILE=YES).
- `Ice/Ice.entitlements` — sandbox=NO, files.user-selected.read-only.
- `Ice/Main` — IceApp, AppDelegate, AppState; `Main/Navigation` (AppNavigationState, NavigationIdentifiers/).
- `Ice/Settings` — SettingsView, SettingsWindow, `SettingsPanes/` (General, Advanced, Hotkeys, MenuBarLayout, MenuBarAppearance, About), `SettingsManagers/` (логика, Defaults).
- `Ice/MenuBar` — MenuBarManager, MenuBarSection, `ControlItem/`, `MenuBarItems/` (Manager, Item, Info, ImageCache), `Appearance/` (+ `MenuBarAppearanceEditor/`, Configurations), `Search/`, `Spacing/`.
- `Ice/UI` — IceBar, HotkeyRecorder, LayoutBar, IceUI (IceSection, IceMenu, IcePicker, IceSlider и т.д. — принимают LocalizedStringKey), Pickers, Shapes, ViewModifiers, Views (AnnotationView, BetaBadge).
- `Ice/Permissions` — Permission, PermissionsManager, PermissionsView, PermissionsWindow.
- `Ice/Hotkeys` — Hotkey, HotkeyAction, HotkeyRegistry, KeyCode, KeyCombination, Modifiers.
- `Ice/Updates` — UpdatesManager (Sparkle). `Ice/UserNotifications` — менеджер и идентификатор.
- `Ice/Utilities` — Defaults, MigrationManager, RehideStrategy, SystemAppearance, LocalizedErrorWrapper, TaskTimeout и пр. `Ice/Events`, `Ice/Bridging`, `Ice/Swizzling` — низкий уровень, строк для UI нет.
- `Ice/Resources` — Acknowledgements.pdf (реально открывается приложением) и .rtf (исходник, в сборку не входит). `Ice/Assets.xcassets` — иконки.
- Корневые `Resources/` — Icon.png, gif/mov для README (не в сборке). Корневые *.md (README, FREQUENT_ISSUES...) — документация, не UI.
- Всего 116 .swift файлов.

## ВАЖНО: как SwiftUI показывает строки

Литералы в `Text("...")`, `Toggle("...")`, `Button("...")`, `IceSection`, `IceMenu`, `IcePicker`, `IceLabeledContent`, `IceGroupBox`, `IceSlider`, `AnnotationView` — это `LocalizedStringKey`, так что их можно просто заменить русским текстом. Интерполяции (`"Version \(x)"`) тоже работают, порядок аргументов менять аккуратно.
Динамические строки (`LocalizedStringKey(formatted + " seconds")`) — переводить кодом: русские формы множественного числа (1 секунда / 2-4 секунды / 5+ секунд).

## 2. Файлы с видимыми строками

| Файл | ~строк | Что внутри |
|---|---|---|
| Settings/SettingsPanes/GeneralSettingsPane.swift | 31 | тоглы, пикеры, подписи, .help, NSAlert(error:), "none/default/max", "second(s)" (стр.21-43) |
| MenuBar/MenuBarItems/MenuBarItemManager.swift | 39 | EventError.message / recoverySuggestion (стр.~372-470), NSAlert стр.1352 "Not enough room to show..." Часть строк - логи, не переводить |
| Settings/SettingsPanes/AdvancedSettingsPane.swift | 18 | настройки, "second(s)" |
| MenuBar/Appearance/MenuBarAppearanceEditor/MenuBarAppearanceEditor.swift | 16 | редактор вида, стр.110 предупреждение |
| Settings/SettingsPanes/AboutSettingsPane.swift | 13 | Version, Updates-секция (стр.95-135), нижняя панель (Quit Ice, Acknowledgements, Contribute, Report a Bug, Donate?) |
| MenuBar/MenuBarItems/MenuBarItem.swift | 13 | `displayName` (стр.~71-110): "Unknown", "Accessibility Shortcuts", "Focus" и др. спецслучаи Control Center |
| MenuBar/ControlItem/ControlItem.swift | 11 | NSMenu иконки: Settings, Search, "Show/Hide the X Section" (стр.465), Check for Updates… (496), Quit Ice (506) |
| Permissions/PermissionsView.swift | 10 | онбординг, кнопки Continue и т.д. (`continueButtonText`) |
| Settings/SettingsPanes/HotkeysSettingsPane.swift | 9 | имена хоткей-действий (стр.36-48) |
| MenuBar/Appearance/MenuBarAppearanceEditor/MenuBarShapePicker.swift | 9 | |
| Utilities/MigrationManager.swift | ~6 | только NSAlert стр.244-245 (messageText/informativeText). `MigrationError.description` — для логов, НЕ переводить |
| UI/IceBar/IceBar.swift | 7 | заголовок окна "Ice Bar" (стр.28), стр.317-327 предупреждение |
| Permissions/Permission.swift | 6 | title и details для Accessibility / Screen Recording (стр.~110-145) |
| Settings/SettingsPanes/MenuBarLayoutSettingsPane.swift | 6 | `"\(section.name.displayString) Section"` стр.81, стр.54 |
| MenuBar/MenuBarManager.swift | 5 | NSMenu: "Edit Menu Bar Appearance…", "Ice Settings…" (стр.330-345) |
| MenuBar/MenuBarSection.swift | 3 | `Name.displayString` стр.18-24 (logString - НЕ трогать) |
| UI/HotkeyRecorder/HotkeyRecorder.swift | 4 | |
| Updates/UpdatesManager.swift | 3 | NSAlert (debug) стр.80, уведомление "A new update is available" / "Version X is now available" (стр.~128-129) |
| UI/LayoutBar/LayoutBarItemView.swift | 3 | NSAlert стр.112-121 ("Menu bar item is not movable." и пр.) |
| MenuBar/Appearance/MenuBarTintKind.swift | 3 | `localized` (None/Solid/Gradient) |
| Utilities/RehideStrategy.swift | 3 | `localized` (Smart/Timed/Focused app) |
| UI/IceBar/IceBarLocation.swift | 3 | `localized` (Dynamic/Mouse pointer/Ice icon) |
| MenuBar/Search/MenuBarSearchPanel.swift | 2-3 | поиск, заголовки секций (`displayString`) |
| Settings/SettingsView.swift | 2 | сайдбар `Text("Ice")` (56), `Text(identifier.localized)` (89) |
| Utilities/SystemAppearance.swift | 2 | `titleKey` "Light Appearance"/"Dark Appearance" (стр.77) |
| MenuBar/Spacing/MenuBarItemSpacingManager.swift | 2 | `GroupedRelaunchError.errorDescription/recoverySuggestion` (стр.27-37) |
| MenuBar/Appearance/MenuBarOverlayPanel.swift | 1 | заголовок окна "Menu Bar Overlay" (стр.92) |
| UI/Views/BetaBadge.swift | 1 | "BETA" |
| UI/LayoutBar/LayoutBar.swift, LayoutBarPaddingView.swift | 1-2 | проверить (NSAlert(error:) стр.138 в Padding) |
| Utilities/TaskTimeout.swift | 1 | `TaskTimeoutError.errorDescription` ("Task timed out before completion"), может показаться пользователю |
| MenuBar/ControlItem/ControlItemImageSet.swift | 8 | `Name` rawValue ("Ice Cube" и пр.) — отображаются, СМ. ЛОВУШКИ |
| Main/Navigation/NavigationIdentifiers/SettingsNavigationIdentifier.swift | 6 | СМ. ЛОВУШКИ |
| UI/IceUI/*.swift, UI/Views/AnnotationView.swift, Settings/SettingsWindow.swift, Permissions/PermissionsWindow.swift, Main/*.swift | 0-?, проверить | заголовки окон могут быть в SettingsWindow/PermissionsWindow (`Window("...")`) — при чтении проверить |

Итого порядка 250-300 строк. В IceUI/ только сигнатуры LocalizedStringKey.

### Не переводить (не видимо или ключи)
- Logger.* сообщения (категории `Logger(category:)`), `logString`, `CustomStringConvertible.description` в MigrationError, EventError.description, TaskTimeoutError.description (но errorDescription — видимое).
- `Defaults.Key` rawValue ("ShowIceIcon", "RehideStrategy"...), `UserNotificationIdentifier` ("UpdateCheck"), `ControlItem.Identifier` ("SItem","HItem","AHItem" — autosave names в defaults), `HotkeyAction` rawValue (ключи словаря сохранённых хоткеев в HotkeySettingsManager стр.40/67), `MenuBarItemSpacingManager.Key`.
- `MenuBarItemInfo` title-константы ("Clock", "Siri", "BentoBox", "AudioVideoModule", "FaceTime", "MusicRecognition", "NewItems", Namespace "Special", bundle id) — идентификаторы для сопоставления окон. `Predicates.swift` `window.title == "Menubar"` — системное имя окна. В `MenuBarItem.displayName` сравниваются `case "BentoBox"`, `"FocusModes"` и т.п. — это КЛЮЧИ (слева), переводить только результат справа.
- `Constants.swift` (URL, bundle id), `Notifications.swift`, `EventTap`, `StatusItemDefaults`, `CodableColor`, `Modifiers`/`KeyCode` (названия клавиш/символы — оставить; возможно проверить Modifiers: символы ⌘⌥).

### ЛОВУШКИ: rawValue одновременно отображается и сохраняется
1. **ControlItemImageSet.Name** (`enum Name: String, Codable`, cases Arrow/Chevron/Door/Dot/Ellipsis/"Ice Cube"/Sunglasses/Custom). Показывается через `Text(imageSet.name.rawValue)` в GeneralSettingsPane.swift:94 И кодируется в UserDefaults (`ControlItemImageSet` Codable, ключ IceIcon). Менять rawValue НЕЛЬЗЯ (сломает декодирование сохранённой иконки). Добавить `var displayName: String` (switch) и использовать в стр.94 (`Text(imageSet.name.displayName)`).
2. **SettingsNavigationIdentifier** (`String` rawValue "General", "Menu Bar Layout", "Menu Bar Appearance", "Hotkeys", "Advanced", "About"). Показ: протокол NavigationIdentifier даёт `localized = LocalizedStringKey(rawValue)`, используется SettingsView.swift:45 (navigationTitle) и :89 (сайдбар). В Defaults не пишется, сравнивается по case; значит безопасно менять rawValue, но чище: оставить rawValue и переопределить `localized` в самом enum (switch -> русские LocalizedStringKey) либо поменять сами rawValue. Рекомендую второе минимально-инвазивное: переопределить `localized` в SettingsNavigationIdentifier (расширение протокола с default - enum-реализация имеет приоритет).
3. **IceBarLocation, RehideStrategy, MenuBarTintKind** — Int rawValue, перевод в отдельном `localized` (switch) — менять только строки в switch, безопасно.
4. **HotkeyAction** — rawValue сохраняется как ключ; отображаемых имён внутри нет (имена в HotkeysSettingsPane switch) — rawValue не трогать.
5. **MenuBarSection.Name.displayString** — не rawValue, безопасно (но также используется в ControlItem.swift:465 и MenuBarSearchPanel.swift:263,269 — составная фраза "Show the X Section": по-русски падежи! Например "Показать скрытую секцию" — формировать целиком, а не склеивать).
6. **ControlItem.Identifier** rawValue ("SItem") — не отображается, не трогать.

## 3. Предложение групп (без пересечений)

- **Группа A (~70): Settings.** GeneralSettingsPane, AdvancedSettingsPane, HotkeysSettingsPane, MenuBarLayoutSettingsPane, SettingsView, SettingsWindow, SettingsNavigationIdentifier, IceBarLocation, RehideStrategy.
- **Группа B (~65): Menu bar items.** MenuBarItemManager, MenuBarItem, MenuBarItemSpacingManager, LayoutBarItemView, LayoutBar, LayoutBarPaddingView, LocalizedErrorWrapper, TaskTimeout.
- **Группа C (~50): Appearance + IceBar.** MenuBarAppearanceEditor, MenuBarShapePicker, MenuBarTintKind, SystemAppearance, MenuBarOverlayPanel, IceBar, BetaBadge, AnnotationView, Pickers/ (проверить).
- **Группа D (~45): About, Updates, меню, секции.** AboutSettingsPane, UpdatesManager, ControlItem, ControlItemImageSet (+ displayName и правка GeneralSettingsPane:94 — ОДНА правка в файле группы A, согласовать: поручить группе D только ControlItemImageSet.swift, а строку 94 правит A), MenuBarManager, MenuBarSection, MenuBarSearchPanel, UserNotificationManager.
- **Группа E (~35): Permissions, Hotkeys, Migration.** PermissionsView, Permission, PermissionsWindow, PermissionsManager, HotkeyRecorder, Hotkey*.swift, Modifiers, MigrationManager, AppDelegate, AppState, WindowInfo.
- Постфиксная проверка: `grep -rnE 'Text\("[A-Za-z]'` по всему Ice/ после перевода; остаться могут только логи/ключи.

## 4. Info.plist и ресурсы

- `Ice/Info.plist` содержит только `SUFeedURL` (https://jordanbaird.github.io/ice-releases/appcast.xml) и `SUPublicEDKey`. Пользовательского текста нет. NS*UsageDescription нет нигде.
- В project.pbxproj (обе конфигурации, Debug ~стр.320-322, Release ~352-354): `INFOPLIST_KEY_LSApplicationCategoryType = public.app-category.utilities`, `INFOPLIST_KEY_LSUIElement = YES`, `INFOPLIST_KEY_NSHumanReadableCopyright = "Copyright © 2025 Jordan Baird"` (видимое в «О программе» macOS; менять не обязательно, можно оставить — лицензия/авторство; не переводить имя автора).
- Версия: MARKETING_VERSION = 0.11.12, CURRENT_PROJECT_VERSION = 1117, PRODUCT_BUNDLE_IDENTIFIER = com.jordanbaird.Ice. PRODUCT_NAME = $(TARGET_NAME) = Ice. Форк можно не переименовывать; смена bundle id сбросит разрешения TCC/defaults.
- `SWIFT_EMIT_LOC_STRINGS = YES` — Xcode пытается экспортировать строки, не мешает.
- `Ice/Resources/Acknowledgements.pdf` (в бандле, открывается в AboutSettingsPane.swift:18 и :144) и `Acknowledgements.rtf` (в сборку не входит, список лицензий: AXSwift и т.д.). Это лицензионные тексты на английском — переводить НЕ нужно (PDF не редактируем без перегенерации).
- Заголовки по-прежнему английские в README, не трогать.

## 5. Sparkle

- Зависимость SPM: Sparkle 2.6.4 (Package.resolved). Подключён в `Ice/Updates/UpdatesManager.swift`: `import Sparkle`; `SPUStandardUpdaterController(startingUpdater: true, ...)` как lazy `updaterController` (стр.~17-21); `performSetup()` обращается к нему (запуск апдейтера) — вызывается из `Main/AppState.swift:190`. `checkForUpdates()` (стр.~76-91): в DEBUG показывает NSAlert, в Release `updater.checkForUpdates()`.
- Делегат `SPUUpdaterDelegate.updater(_:willScheduleUpdateCheckAfterDelay:)` запрашивает авторизацию уведомлений (`userNotificationManager.requestAuthorization()`), а `standardUserDriverWillHandleShowingUpdate` постит уведомление "A new update is available".
- SUFeedURL: `Ice/Info.plist` (SUFeedURL, SUPublicEDKey). Больше нигде.
- UI обновлений:
  - `Settings/SettingsPanes/AboutSettingsPane.swift`: `updatesSection` (стр.~96-104), Toggle "Automatically check for updates" (стр.~112), "Automatically download updates" (~120), Button "Check for Updates" + "Last checked: ..." (~128-132), `lastUpdateCheckString` (~36); `updatesSection` вставлена в body страницы.
  - `MenuBar/ControlItem/ControlItem.swift:496-540` — пункт меню "Check for Updates…" и `@objc checkForUpdates` (стр.540 вызывает `updatesManager.checkForUpdates()`).
  - `UserNotifications/UserNotificationManager.swift:80` — клик по уведомлению вызывает checkForUpdates.
  - `Main/AppState.swift:34,171,190` — владеет менеджером, подписка на objectWillChange.
- Минимальный безопасный способ отключить:
  1. В `Ice/Info.plist` удалить `SUFeedURL` и `SUPublicEDKey` (опционально добавить `SUEnableAutomaticChecks=false`, `SUAutomaticallyUpdate=false`). Без фида Sparkle не найдёт обновление; с `SUPublicEDKey` без фида Sparkle может ругаться в лог.
  2. В `UpdatesManager.performSetup()` не запускать апдейтер: изменить `SPUStandardUpdaterController(startingUpdater: false, ...)` и в `performSetup()` убрать `_ = updaterController`/оставить только состояние (иначе `updater.automaticallyChecksForUpdates = false` ставить в init). Важно: `canCheckForUpdates` у не запущенного апдейтера = false -> кнопка "Check for Updates" в About скрыта автоматически (условие `if updatesManager.canCheckForUpdates`).
  3. Убрать UI: в AboutSettingsPane удалить вызов `updatesSection` из body; в ControlItem.createMenu удалить блок checkForUpdatesItem + разделитель (стр.~494-503); тогда `@objc checkForUpdates` в ControlItem/UserNotificationManager можно оставить (мёртвый код) либо тоже убрать.
  4. Сохранить сам `import Sparkle`/зависимость (удаление пакета из pbxproj рискованнее, чем нужно). Тогда перевод строк уведомления update не нужен, но переведите на всякий случай.

## 6. Подпись и сборка

- project.pbxproj: на уровне проекта (Debug стр.~218, Release ~282) `DEVELOPMENT_TEAM = K2ATHQPJDP`. На уровне таргета Ice (оба конфига, стр.~308-310 / 340-342): `CODE_SIGN_ENTITLEMENTS = Ice/Ice.entitlements`, `"CODE_SIGN_IDENTITY[sdk=macosx*]" = "Apple Development"`, `CODE_SIGN_STYLE = Automatic`, `ENABLE_HARDENED_RUNTIME = YES`.
  Внимание: `CODE_SIGN_IDENTITY[sdk=macosx*]` — условная настройка таргета; в командной строке `CODE_SIGN_IDENTITY=-` может быть перекрыта ею (уровень таргета приоритетнее глобальных оверрайдов? нет: командная строка приоритетнее, но sdk-условный вариант более специфичен — проверить на сборке; если не сработает, передавать `"CODE_SIGN_IDENTITY[sdk=macosx*]=-"` либо править pbxproj).
- Команда (не запускалась):
  ```
  xcodebuild -project Ice.xcodeproj -scheme Ice -configuration Release \
    -derivedDataPath build CODE_SIGN_IDENTITY=- DEVELOPMENT_TEAM= CODE_SIGN_STYLE=Manual \
    CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=YES ENABLE_HARDENED_RUNTIME=NO build
  ```
  Результат: `build/Build/Products/Release/Ice.app`. Если ad-hoc-подпись фреймворка Sparkle (внутри XPC/Autoupdate) недостаточно - после сборки: `codesign --force --deep --sign - build/.../Ice.app`. Entitlements при ad-hoc с hardened runtime обычно ок; на всякий случай отключён.
  DMG: `hdiutil create -volname Ice -srcfolder <staging с Ice.app и ссылкой /Applications> -ov -format UDZO Ice-ru.dmg`. На другом Mac потребуется `xattr -dr com.apple.quarantine`.
- Схемы/цели: `xcodebuild -list` запускался; Ice.xcodeproj разрешает пакеты (AXSwift, Ifrit, LaunchAtLogin-Modern, Sparkle, CompactSlider), исполнение пришло с ошибкой CoreSimulator (предупреждение, не фатально). Для сборки нужен интернет (или кэш SPM) при первом резолве; `-list` уже начал клонирование.
- `Ice.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved` существует (версии: AXSwift 0.3.2, CompactSlider 1.1.6, Ifrit 2.0.3, LaunchAtLogin-Modern 1.1.0, Sparkle 2.6.4). Использовать `-skipPackageUpdates`/`-disableAutomaticPackageResolution` после первого резолва для воспроизводимости.

## 7. Ключевые сущности и механизм отображаемых имён

| Сущность | Файл | Механизм |
|---|---|---|
| `SettingsNavigationIdentifier` (general, menuBarLayout, menuBarAppearance, hotkeys, advanced, about) | Main/Navigation/NavigationIdentifiers/ | rawValue String -> `NavigationIdentifier.localized = LocalizedStringKey(rawValue)` (протокол в NavigationIdentifier.swift); иконки/тексты в SettingsView.swift (`sidebarItem`, `icon(for:)`) |
| `HotkeyAction` | Hotkeys/HotkeyAction.swift | String Codable rawValue (ключ хранения); имена в `switch` HotkeysSettingsPane.swift:36-48 (`hotkeyRecorder(forAction:)`) |
| `MenuBarSection.Name` (visible, hidden, alwaysHidden) | MenuBar/MenuBarSection.swift:12 | `displayString` (UI) и `logString` (лог) |
| `ControlItemImageSet.Name` | MenuBar/ControlItem/ControlItemImageSet.swift:10 | rawValue отображается (ЛОВУШКА) |
| `ControlItem.Identifier` | MenuBar/ControlItem/ControlItem.swift:13 | autosave names, не UI |
| `IceBarLocation` / `RehideStrategy` / `MenuBarTintKind` | UI/IceBar, Utilities, MenuBar/Appearance | Int enum + `var localized: LocalizedStringKey` (switch) |
| `SystemAppearance` | Utilities/SystemAppearance.swift:77 | `titleKey: LocalizedStringKey` |
| `Permission` (Accessibility / ScreenRecording) | Permissions/Permission.swift | init(title:, details: [String]) строки внутри подклассов |
| `MenuBarItemManager.EventError` | MenuBar/MenuBarItems/MenuBarItemManager.swift:372 | LocalizedError: errorDescription = `message`, recoverySuggestion |
| `LocalizedErrorWrapper` | Utilities/ | прокидывает errorDescription в NSAlert/алерты (GeneralSettingsPane:164,333) |
| `UserNotificationIdentifier` | UserNotifications/ | .updateCheck; title/body передаются при `addRequest(with:title:body:)` |
| `MenuBarItem.displayName` | MenuBar/MenuBarItems/MenuBarItem.swift | строка для UI; спецкейсы Control Center |
| NSMenu (ControlItem.createMenu, MenuBarManager 330+) | | NSMenuItem(title:) литералы |

Заметки: системные имена приложений (localizedName) уже локализуются macOS. Сквозное "Ice" (название продукта) можно оставить как есть.
