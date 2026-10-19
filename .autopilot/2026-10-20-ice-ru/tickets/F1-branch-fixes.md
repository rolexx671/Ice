# F1 — Ремонт ветки по итогам код-ревью

**Требования:** R02, R03i, R05, R06, R07i
**Зависит от:** —
**Зона:** `Ice/` · `Ice.xcodeproj/` · `scripts/` · `.autopilot/2026-10-20-ice-ru--wip/interfaces.md`
**Волна:** 3
**Ревью:** да — ремонт ветки
**Модель:** сильная

## Что должно заработать

Последние английские слова, которые рисуют пакет и система, становятся русскими; одно действие
называется одним словом везде; установка не может оставить Mac без приложения.

## Из брифа, дословно

> «переводи полностью на русский язык»
> «установи на мой мак»

## Критерии приёмки

- [ ] GeneralSettingsPane.swift:99 — `LaunchAtLogin.Toggle()` получает подпись «Открывать при входе»
- [ ] Язык разработки проекта — русский (`developmentRegion = ru`, `ru` в `knownRegions`), в собранном Info.plist `CFBundleDevelopmentRegion = ru`, чтобы системные кнопки «ОК» в NSAlert, панель выбора файла и системные ошибки шли по-русски при любом языке системы; приложение собирается
- [ ] «click» везде одним глаголом «нажать» (как в русской macOS): «Нажмите, удерживая клавишу Option, …», «по нажатию правой кнопкой» и т.п. — AdvancedSettingsPane, GeneralSettingsPane, MenuBarAppearanceEditor, MenuBarSearchPanel, IceBar; глагол записан в глоссарий `interfaces.md`
- [ ] scripts/install-from-dmg.sh — новое приложение сначала копируется во временный путь рядом (`/Applications/.Ice.app.new`), старое заменяется только после успешного копирования
- [ ] «Tip:» везде одним словом — «Совет:» (MenuBarAppearanceEditor.swift:82, MenuBarLayoutSettingsPane.swift:35)
- [ ] GeneralSettingsPane.swift:299 — подпись согласуется по роду со значениями RehideStrategy («Умное», «По таймеру», …), например «Повторное скрытие»
- [ ] AdvancedSettingsPane.swift:138 — «Задержка скрытия временно показанных объектов»
- [ ] PermissionsView.swift:142 — «Это разрешение нужно Ice, чтобы:»
- [ ] scripts/build-dmg.sh — Release-сборка без `get-task-allow` (например `CODE_SIGN_INJECT_BASE_ENTITLEMENTS=NO`), проверено `codesign -d --entitlements -`
- [ ] ControlItem.swift:500-501 — одна пустая строка вместо двух
- [ ] `scripts/build-dmg.sh` проходит целиком, DMG создан
