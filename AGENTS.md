<!-- autopilot:start -->
# Ice (русская версия)

Форк менеджера строки меню macOS [Ice](https://github.com/jordanbaird/Ice) (Swift, SwiftUI + AppKit, macOS 14+), весь видимый текст по-русски; сборка ad-hoc в DMG.

Словарь — `CONTEXT.md`; причины решений — `docs/adr/` (0001–0006); архитектура, поток данных и правила перевода — `docs/architecture.md`.

## Команды

| Команда | Что делает |
|---------|------------|
| `./scripts/build-dmg.sh` | Release-сборка, ad-hoc подпись, `dist/Ice-0.11.12-ru.dmg`; SPM-пакеты подтягиваются сами |
| `./scripts/install-from-dmg.sh dist/Ice-0.11.12-ru.dmg` | Ставит в `/Applications/Ice.app` (с заменой) и запускает |
| `xcrun swiftc -parse Ice/Main/AppState.swift` | Проверка синтаксиса одного файла (подставь свой путь) |
| `xcodebuild -project Ice.xcodeproj -scheme Ice -configuration Release -derivedDataPath build CODE_SIGN_IDENTITY=- DEVELOPMENT_TEAM= CODE_SIGN_STYLE=Manual ENABLE_HARDENED_RUNTIME=NO CODE_SIGN_INJECT_BASE_ENTITLEMENTS=NO build` | Полная сборка -> `build/Build/Products/Release/Ice.app` |

Тестов нет. Линтер — SwiftLint `--strict` в `.github/workflows/lint.yml`, правила в `.swiftlint.yml`.

Поиск оставшегося английского (логи и rawValue — не ошибка):

```
grep -rnE '(Text|Button|Toggle|Label|Section|Picker|help|title:|messageText|informativeText)\(?\s*"[A-Za-z]' Ice/
```

## Где что

- `Ice/Main/` — вход (`IceApp`, `AppDelegate`), `AppState` — владелец всех менеджеров.
- `Ice/MenuBar/MenuBarItems/MenuBarItemManager.swift` — ядро: чтение и перемещение объектов строки меню (~1700 строк).
- `Ice/MenuBar/` — секции, `ControlItem`, оформление; `Ice/Settings/` — менеджеры и экраны настроек; `Ice/UI/` — Ice Bar, LayoutBar.
- `Ice/Bridging/Shims/Private.swift` — приватные CGS-API; `Ice/Updates/UpdatesManager.swift` — заглушка Sparkle.
- `Packages/CompactSlider/` — локальный пакет; `scripts/` — сборка и установка DMG; `build/`, `dist/` — артефакты, в `.gitignore`.
- `README.md`, `FREQUENT_ISSUES.md`, `LICENSE` — оригинал апстрима, по-английски.

## Подводные камни

- `rawValue` сохраняемых enum не переводить: отображаемое имя — отдельным `displayName`/`localized` (ADR 0005).
- `"CODE_SIGN_IDENTITY[sdk=macosx*]=-"` в командной строке ломает xcodebuild; хватает `CODE_SIGN_IDENTITY=-`.
- Ad-hoc подпись меняется при каждой пересборке: macOS может заново спросить «Универсальный доступ» и «Запись экрана».
- CompactSlider 1.1.6 не собирается с SDK macOS 27, потому пакет локальный (ADR 0004); не возвращать на удалённый.
- Sparkle отключён, но пакет оставлен (ADR 0002): не удалять зависимость и не возвращать `SUFeedURL` в `Ice/Info.plist` — `build-dmg.sh` упадёт.
- `get-task-allow` в подписи Release тоже роняет `build-dmg.sh`; hardened runtime выключен (ADR 0003).
- Bundle id `com.jordanbaird.Ice` и версия апстримные — не менять (ADR 0006).
- Две параллельные `xcodebuild` в одном `build/` ломают друг друга.

## Как здесь работает Autopilot

Сборка ведётся навыком `/autopilot`. Требования, спецификация и таски — в `.autopilot/`.
Прогресс — `.autopilot/dashboard.html`. Требование из `manifest.md` может снять
только пользователь. Прерванную сборку продолжает «продолжи автопилот».

### Правка без автопилота

Мелкий баг или доводка после сборки — обычная сессия, без прогона.

Сначала прочитай:
1. `.autopilot/PROGRESS.md` — что не доделано, известные баги, о чём договорились с пользователем.
2. Что правили после последней сборки — первая строка таблицы в «История git».
3. Только если правка их касается: почему сделано так — `docs/adr/`; что значат слова — `CONTEXT.md`;
   что именно просили — `manifest.md` в папке сборки (указана в начале `PROGRESS.md`).

После правки:
- коммит — по правилам из «История git»;
- строка в «Правки без автопилота» в `PROGRESS.md`: дата — что — почему;
- починенный пункт из «Не доделано» или «Известные баги» — удали;
- договорились с пользователем о том, что следующая сборка не должна пересматривать, —
  строка в «Договорились», его словами.

### История git

Целиком не читай — бери срез под вопрос:

| Вопрос | Команда |
|---|---|
| что правили после последней сборки | `git log --oneline "$(git log -1 --format=%h --grep='^Autopilot: сборка сдана')"..HEAD -- . ':(exclude).autopilot'` |
| всё, что делали ради требования | `git log --oneline --grep="R02"` |
| история файла | `git log --oneline -10 -- <файл>` |
| когда появился или исчез код | `git log --oneline -S "<фрагмент>"` |
| почему строка такая | `git blame -L <с>,<по> <файл>`, затем `git show <sha>` |
| что внутри коммита | `git show --stat <sha>` |

Срез длиннее ~30 коммитов — отдай его субагенту и возьми выжимку в десять строк.

Коммит: заголовок — что (`fix: даты в одном формате`), тело — почему, трейлер
`--trailer "Requirements: R02"`, если правка касается требования из `manifest.md`.
Заголовок `Autopilot: сборка сдана` пишет только автопилот — по нему находят последнюю сборку.
<!-- autopilot:end -->
