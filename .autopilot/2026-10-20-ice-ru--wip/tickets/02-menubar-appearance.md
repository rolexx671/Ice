# 02 — Объекты строки меню, внешний вид и Ice Bar по-русски

**Требования:** R02, R03i
**Зависит от:** —
**Зона:** `Ice/MenuBar/MenuBarItems/` · `Ice/MenuBar/Spacing/` · `Ice/MenuBar/Appearance/` · `Ice/UI/IceBar/` · `Ice/UI/IceUI/` · `Ice/UI/LayoutBar/` · `Ice/UI/Pickers/` · `Ice/UI/Shapes/` · `Ice/UI/ViewModifiers/` · `Ice/UI/Views/` · `Ice/Utilities/`
**Волна:** 1
**Ревью:** нет
**Модель:** обычная

## Что должно заработать

Редактор внешнего вида строки меню, Ice Bar, панель расположения (layout bar),
ошибки перемещения объектов и их подсказки, имена спецобъектов Пункта управления,
бейдж «БЕТА», пикеры цвета/градиента, способы повторного скрытия, алерт миграции настроек — целиком на русском.

## Из брифа, дословно

> «переводи полностью на русский язык»

## Разделы спецификации

R02, R03i; `interfaces.md` — правила и глоссарий; `notes.md` — ловушки `MenuBarItemInfo`
и `MenuBarItem.displayName` (ключи слева не трогать), `EventError` (переводить `message`/
`recoverySuggestion`, не `description`).

## Критерии приёмки

- [ ] В файлах зоны не осталось видимых пользователю английских строк (grep из `interfaces.md` по зоне — только ключи/логи)
- [ ] Ошибки `EventError` и `GroupedRelaunchError`, `TaskTimeoutError.errorDescription` — русские; `description` для логов не тронут
- [ ] `MenuBarItem.displayName` возвращает русские имена спецобъектов; строки-ключи сравнения не изменены
- [ ] Редактор вида: оттенок, форма, граница, тень, светлое/тёмное оформление — по глоссарию
- [ ] Заголовки окон Ice Bar и оверлея, алерты Layout Bar — русские
- [ ] Логика не изменена; каждый изменённый файл проходит `xcrun swiftc -parse`
