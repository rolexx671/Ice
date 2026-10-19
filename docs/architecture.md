# Архитектура Ice (русский форк)

Словарь терминов — `CONTEXT.md`. Решения «почему так» — `docs/adr/`.

## Поток данных
- Вход: `Ice/Main/IceApp.swift` -> `Ice/Main/AppDelegate.swift` -> `AppState` (`Ice/Main/AppState.swift`). `AppState` владелец всех менеджеров (lazy-свойства), менеджеры получают его в `init(appState:)`.
- Объекты строки меню: `Ice/MenuBar/MenuBarItems/MenuBarItemManager.swift` (самый большой файл, ~1700 строк) читает окна через `Ice/Bridging/` (приватные CGS-функции, объявления в `Bridging/Shims/Private.swift`) и `Ice/Utilities/WindowInfo.swift`; перемещает объекты синтетическими `CGEvent` (нужен «Универсальный доступ»).
- Картинки объектов: `MenuBarItemImageCache.swift` + `Ice/Utilities/ScreenCapture.swift` (ScreenCaptureKit, нужна «Запись экрана»).
- Секции: `MenuBarManager` держит три `MenuBarSection`; каждая управляется своим `ControlItem` (`Ice/MenuBar/ControlItem/`). Показ/скрытие секции = смена длины статус-элемента.
- Ввод: `Ice/Events/` (`EventManager`, `EventTap`, мониторы) -> наведение/нажатия в строке меню; `Ice/Hotkeys/` -> `HotkeyRegistry` -> `HotkeyAction`.
- Настройки: `Ice/Settings/SettingsManagers/*` (состояние, хранится через `Ice/Utilities/Defaults.swift`) и `Ice/Settings/SettingsPanes/*` (SwiftUI-экраны). Навигация — `Ice/Main/Navigation/`.
- Вывод: Ice Bar — `Ice/UI/IceBar/`; редактор «Расположение» — `Ice/UI/LayoutBar/`; оформление строки меню — `Ice/MenuBar/Appearance/`.
- Миграции сохранённых настроек: `Ice/Utilities/MigrationManager.swift`.

## Границы модулей
- Менеджеры получают друг друга через `appState`.
- Папка `Ice/` — синхронизируемая группа Xcode: новые файлы подхватываются без правки `project.pbxproj`.
- Внешние пакеты: LaunchAtLogin-Modern, AXSwift, Ifrit, Sparkle (подключён, но отключён — ADR 0002), `Packages/CompactSlider` (локальный — ADR 0004).
- Обновления: `Ice/Updates/UpdatesManager.swift` — заглушка (`startingUpdater: false`, `canCheckForUpdates` всегда false); `Ice/Info.plist` без `SUFeedURL`/`SUPublicEDKey`.

## Соглашения перевода
- Русский пишется литералами прямо в исходниках, без `.strings`/`.xcstrings` (ADR 0001); `developmentRegion = ru`.
- Переводим только видимый пользователю текст. Не трогать: сообщения `Logger`, `logString`, `description` у ошибок, URL, bundle id, `window.title == "Menubar"`, константы `MenuBarItemInfo`, ключи слева в `case "…"` (переводится результат справа).
- `rawValue` любых `Codable`/`Defaults.Key`/`HotkeyAction`/`ControlItem.Identifier`/`UserNotificationIdentifier` не меняется; отображаемое имя — отдельным свойством (ADR 0005):
  - `MenuBarSection.Name.displayString` — «Видимая» / «Скрытая» / «Всегда скрытая»;
  - `ControlItemImageSet.Name.displayName`;
  - `SettingsNavigationIdentifier.localized`.
- Падежные фразы не клеятся из `displayString`; пишутся целиком по `switch` («Показать скрытую секцию»). Склейка допустима только в именительном: «Скрытая секция».
- Множественное число («секунда/секунды/секунд») — `fileprivate secondsWord(for: Double)` в `GeneralSettingsPane` и `AdvancedSettingsPane`; правило: n%10==1 и n%100!=11 — «секунда»; n%10 в 2...4 и n%100 не в 12...14 — «секунды»; иначе «секунд»; дробное — «секунды».
- Стиль как в системных настройках macOS: инфинитив для действий («Показать»), без «ты», «вы» со строчной, многоточие «…», кавычки «ёлочки», «ё» пишется. «нажать», не «клик»/«щелчок».
- Глоссарий: см. `CONTEXT.md` (термины и запрещённые синонимы). Дополнительно: Hotkey — «сочетание клавиш»; Rehide — «повторное скрытие» (Умное / По таймеру / По активному приложению); разделы настроек — Основные · Расположение · Внешний вид · Сочетания клавиш · Дополнительно · О программе; Accessibility — «Универсальный доступ»; Screen Recording — «Запись экрана»; Launch at login — «Открывать при входе»; Tip: — «Совет:».
- Не переводить: `Ice Bar` (имя собственное), `Ice`.
- Логика не меняется ради перевода — только строки и минимальный код для падежей и множественных форм.
