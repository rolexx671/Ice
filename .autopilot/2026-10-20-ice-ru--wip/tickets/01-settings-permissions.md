# 01 — Настройки, разрешения и сочетания клавиш по-русски

**Требования:** R02, R03i
**Зависит от:** —
**Зона:** `Ice/Settings/SettingsPanes/{General,Advanced,Hotkeys,MenuBarLayout,MenuBarAppearance}SettingsPane.swift` · `Ice/Settings/SettingsView.swift` · `Ice/Settings/SettingsWindow.swift` · `Ice/Main/` · `Ice/Permissions/` · `Ice/Hotkeys/` · `Ice/UI/HotkeyRecorder/`
**Волна:** 1
**Ревью:** нет
**Модель:** обычная

## Что должно заработать

Окно настроек (боковая панель, разделы Основные, Дополнительно, Сочетания клавиш,
Расположение, Внешний вид как раздел), окно разрешений при первом запуске, запись
сочетаний клавиш — целиком на русском.

## Из брифа, дословно

> «переводи полностью на русский язык»

## Разделы спецификации

R02, R03i; `interfaces.md` — правила, глоссарий, границы `SettingsNavigationIdentifier`,
`ControlItemImageSet.Name.displayName` (здесь только потребитель в GeneralSettingsPane),
`MenuBarSection.Name.displayString` (потребитель в MenuBarLayoutSettingsPane), множественные формы.
`notes.md` — где какие строки и что не трогать.

## Критерии приёмки

- [ ] В файлах зоны не осталось видимых пользователю английских строк (grep из `interfaces.md` по зоне — только ключи/логи)
- [ ] Боковая панель настроек и заголовки разделов — русские имена из глоссария; `rawValue` `SettingsNavigationIdentifier` не изменён
- [ ] Выбор значка Ice показывает `imageSet.name.displayName`, а не `rawValue`
- [ ] «секунда/секунды/секунд» согласуются с числом в Основных и Дополнительно
- [ ] Окно разрешений: названия, описания, кнопки — русские (Универсальный доступ, Запись экрана)
- [ ] Имена действий в «Сочетаниях клавиш» русские; `HotkeyAction.rawValue` не изменён
- [ ] Логика и ключи хранения не изменены; каждый изменённый файл проходит `xcrun swiftc -parse`
