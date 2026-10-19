# Границы и правила проекта

## Правила проекта
- Переводим ТОЛЬКО видимый пользователю текст. Не трогать: `Logger`-сообщения, `logString`,
  `description` у ошибок (это для логов), `rawValue` любых `Codable`/`Defaults.Key`/`HotkeyAction`/
  `ControlItem.Identifier`/`UserNotificationIdentifier`, константы `MenuBarItemInfo`, ключи в `case "…"`
  слева (переводим только результат справа), URL, bundle id, `window.title == "Menubar"`.
- Логика не меняется — только строки (и минимальный код для форм множественного числа/падежей).
- Стиль — как в системных настройках macOS на русском: безличный/инфинитив для действий
  («Показать», «Открыть»), без «ты», обращение «вы» со строчной там, где нужно. Многоточие — «…».
  Кавычки — «ёлочки». Буква «ё» пишется.
- Каждый файл читается целиком перед правкой.

## Глоссарий (обязателен)
| English | Русский |
|---|---|
| Menu bar | строка меню |
| Section | секция (`Visible` — видимая, `Hidden` — скрытая, `Always-Hidden` — всегда скрытая) |
| Menu bar item | объект строки меню |
| Ice Bar | Ice Bar (имя собственное) |
| Ice icon | значок Ice |
| Settings… / Ice Settings… | Настройки… / Настройки Ice… |
| General · Menu Bar Layout · Menu Bar Appearance · Hotkeys · Advanced · About | Основные · Расположение · Внешний вид · Сочетания клавиш · Дополнительно · О программе |
| Hotkey | сочетание клавиш |
| Click / Option-click / Right-click | нажать / нажать, удерживая клавишу Option / нажать правой кнопкой («по нажатию», не «клик»/«щелчок») |
| Tip: | Совет: |
| Quit Ice | Завершить Ice |
| Search | Поиск |
| Rehide / Rehide strategy | повторное скрытие / способ повторного скрытия |
| Smart / Timed / Focused app | Умное / По таймеру / По активному приложению |
| Tint · None · Solid · Gradient | Оттенок · Нет · Сплошной · Градиент |
| Shape · Full · Split | Форма · Полная · Разделённая |
| Border · Shadow | Граница · Тень |
| Light/Dark Appearance | Светлое/Тёмное оформление |
| Spacing / Padding | интервал / отступ |
| Accessibility (permission) | Универсальный доступ |
| Screen Recording (permission) | Запись экрана |
| Continue / Quit / Cancel / OK | Продолжить / Завершить / Отменить / ОК |
| Launch at login | Открывать при входе |
| Acknowledgements · Contribute · Report a Bug · Donate | Благодарности · Участвовать · Сообщить об ошибке · Поддержать |
| BETA | БЕТА |
| Default · None · Max | По умолчанию · Нет · Макс. |
| second(s) | секунда/секунды/секунд (по правилу русских множественных форм) |

## Границы, решённые в спецификации

### `MenuBarSection.Name.displayString` (владелец — T04)
Возвращает прилагательное женского рода, с заглавной: `"Видимая"`, `"Скрытая"`, `"Всегда скрытая"`.
Составные фразы с падежами не склеиваются из него, а пишутся целиком по `switch`:
«Показать скрытую секцию», «Скрыть всегда скрытую секцию» и т.п. Склейка допустима только
в именительном падеже: `"\(name.displayString) секция"` → «Скрытая секция».

### `ControlItemImageSet.Name.displayName: String` (владелец — T04)
Новое вычисляемое свойство, `rawValue` не меняется. Русские имена: Стрелка, Шеврон, Дверь, Точка,
Многоточие, Кубик льда, Очки, Свой. Потребитель — `GeneralSettingsPane` (T01):
`Text(imageSet.name.displayName)` вместо `Text(imageSet.name.rawValue)`.

### `SettingsNavigationIdentifier` (владелец — T01)
`rawValue` не меняется; в enum добавляется собственный `var localized: LocalizedStringKey`
(switch → русские имена разделов из глоссария), перекрывающий реализацию протокола по умолчанию.

### Множественные формы (каждый владелец файла у себя)
Для «секунд» — локальная функция в файле (или `fileprivate`) по правилу: n%10==1 && n%100!=11 → «секунда»;
n%10 in 2...4 && n%100 not in 12...14 → «секунды»; иначе «секунд». Дробное значение → «секунды».

### Обновления (владелец — T04)
`Ice/Info.plist` без `SUFeedURL`/`SUPublicEDKey`; `UpdatesManager` создаёт контроллер с
`startingUpdater: false`; UI обновлений убран из `AboutSettingsPane` и `ControlItem`.

### Сборка (владелец — T06)
`scripts/build-dmg.sh` → `dist/Ice-<MARKETING_VERSION>-ru.dmg`. Код возврата ≠ 0 при любой ошибке.

## Стек и команды
- Swift / SwiftUI + AppKit, Xcode 27.1, macOS 14+ (deployment target), проект `Ice.xcodeproj`, схема `Ice`.
  Папка `Ice/` — синхронизируемая группа: новые файлы подхватываются без правки pbxproj.
- **Проверка синтаксиса одного файла** (волна 1, пока соседи правят другие файлы):
  `xcrun swiftc -parse <файл.swift>` — должна пройти без ошибок для каждого изменённого файла.
- **Полная проверка** (с волны 2): ad-hoc сборка Release
  `xcodebuild -project Ice.xcodeproj -scheme Ice -configuration Release -derivedDataPath build CODE_SIGN_IDENTITY=- DEVELOPMENT_TEAM= CODE_SIGN_STYLE=Manual ENABLE_HARDENED_RUNTIME=NO CODE_SIGN_INJECT_BASE_ENTITLEMENTS=NO build`
  → `build/Build/Products/Release/Ice.app`. Тестов в проекте нет.
- В волне 1 полную сборку НЕ запускать: параллельные таски правят соседние файлы, и общий `build/` сломается.
- Поиск оставшегося английского: `grep -rnE '(Text|Button|Toggle|Label|Section|Picker|help|title:|messageText|informativeText)\(?\s*"[A-Za-z]' Ice/`
  — остаться могут только ключи/логи из списка «Не переводить» в `notes.md`.

## Выставлено тасками
- T01: `SettingsNavigationIdentifier.localized` — своя реализация; `fileprivate secondsWord(for: Double)` в General/AdvancedSettingsPane; GeneralSettingsPane использует `imageSet.name.displayName`.
- T03: `MenuBarSection.Name.displayString: String`; `ControlItemImageSet.Name.displayName: String`; `UpdatesManager.performSetup()/checkForUpdates()` — заглушки с логом «Updates are disabled in this build», `canCheckForUpdates` всегда false.
- T04: `scripts/build-dmg.sh` → `dist/Ice-<версия>-ru.dmg`; `scripts/install-from-dmg.sh <dmg>`; CompactSlider — локальный пакет `Packages/CompactSlider`.
