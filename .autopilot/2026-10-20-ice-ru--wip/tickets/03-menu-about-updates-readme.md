# 03 — Меню Ice, «О программе», поиск, отключение обновлений, README

**Требования:** R01, R02, R03i, R04i, R08i
**Зависит от:** —
**Зона:** `Ice/MenuBar/ControlItem/` · `Ice/MenuBar/MenuBarManager.swift` · `Ice/MenuBar/MenuBarSection.swift` · `Ice/MenuBar/Search/` · `Ice/Settings/SettingsPanes/AboutSettingsPane.swift` · `Ice/Updates/` · `Ice/UserNotifications/` · `Ice/Info.plist` · `README.md`
**Волна:** 1
**Ревью:** да — фундамент
**Модель:** сильная

## Что должно заработать

Меню по клику на значок Ice и меню строки меню, окно поиска, раздел «О программе» —
на русском. Приложение больше не ищет и не ставит обновления оригинала (иначе русская версия
заменится английской). README форка — на русском.

## Из брифа, дословно

> «переводи полностью на русский язык»
> «делай форк этого проекта https://github.com/jordanbaird/Ice»

## Разделы спецификации

R02, R03i, R04i, R08i; `interfaces.md` — границы `MenuBarSection.Name.displayString`,
`ControlItemImageSet.Name.displayName` (владелец — этот таск), «Обновления»; `notes.md` §5.

## Критерии приёмки

- [ ] `MenuBarSection.Name.displayString` → «Видимая»/«Скрытая»/«Всегда скрытая»; `logString` не тронут
- [ ] `ControlItemImageSet.Name.displayName` существует, русские имена; `rawValue` не изменён
- [ ] Меню значка Ice: «Настройки…», «Поиск», «Показать/Скрыть … секцию» с правильным падежом, «Завершить Ice»; пункта проверки обновлений нет
- [ ] «О программе»: версия, кнопки внизу — русские; раздела обновлений нет
- [ ] `Info.plist` без `SUFeedURL` и `SUPublicEDKey`; апдейтер Sparkle не стартует (`startingUpdater: false`), автопроверок нет
- [ ] Окно поиска и заголовки секций в нём — русские
- [ ] `README.md` на русском: что это за форк, отличия (перевод, обновления выключены), как собрать DMG (`scripts/build-dmg.sh` → `dist/`), что после пересборки может понадобиться заново выдать разрешения, ссылка на оригинал jordanbaird/Ice и лицензию GPL-3.0
- [ ] Каждый изменённый Swift-файл проходит `xcrun swiftc -parse`
