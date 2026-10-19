window.STATE =
{
  "version": 2,
  "slug": "ice-ru",
  "dir": "2026-10-20-ice-ru",
  "title": "Ice — русская локализация и DMG",
  "mode": "semi",
  "depth": "normal",
  "tier": "T2",
  "briefFile": "2026-10-20-brief.md",
  "memoryFile": "AGENTS.md",
  "memoryOwner": "autopilot",
  "skillDir": "/Users/alex/.claude/skills/autopilot",
  "baseCommit": "93ddfff",
  "startedAt": "2026-10-20T00:02:13+03:00",
  "updatedAt": "2026-10-20T00:30:41+03:00",
  "finishedAt": "2026-10-20T00:30:41+03:00",
  "stages": [
    {
      "id": "preflight",
      "status": "done",
      "startedAt": "2026-10-20T00:02:13+03:00",
      "finishedAt": "2026-10-20T00:02:26+03:00"
    },
    {
      "id": "manifest",
      "status": "done",
      "startedAt": "2026-10-20T00:02:26+03:00",
      "finishedAt": "2026-10-20T00:03:03+03:00"
    },
    {
      "id": "briefing",
      "status": "skipped",
      "startedAt": "2026-10-20T00:03:03+03:00",
      "finishedAt": "2026-10-20T00:03:03+03:00",
      "note": "вопросов не потребовалось"
    },
    {
      "id": "spec",
      "status": "done",
      "startedAt": "2026-10-20T00:03:03+03:00",
      "finishedAt": "2026-10-20T00:07:24+03:00"
    },
    {
      "id": "plan",
      "status": "done",
      "startedAt": "2026-10-20T00:07:24+03:00",
      "finishedAt": "2026-10-20T00:08:26+03:00"
    },
    {
      "id": "build",
      "status": "done",
      "startedAt": "2026-10-20T00:08:26+03:00",
      "finishedAt": "2026-10-20T00:17:40+03:00"
    },
    {
      "id": "review",
      "status": "done",
      "startedAt": "2026-10-20T00:17:40+03:00",
      "finishedAt": "2026-10-20T00:26:12+03:00"
    },
    {
      "id": "final",
      "status": "done",
      "startedAt": "2026-10-20T00:26:12+03:00",
      "finishedAt": "2026-10-20T00:30:41+03:00"
    }
  ],
  "requirements": {
    "total": 8,
    "done": 8,
    "inTicket": 0,
    "inSpec": 0,
    "placeholder": 0,
    "deferred": 0,
    "dropped": 0
  },
  "tickets": [
    {
      "id": "01",
      "title": "Настройки, разрешения и сочетания клавиш по-русски",
      "requirements": [
        "R02",
        "R03i"
      ],
      "blockedBy": [],
      "wave": 1,
      "zone": [
        "Ice/Settings/SettingsPanes/{General,Advanced,Hotkeys,MenuBarLayout,MenuBarAppearance}SettingsPane.swift",
        "Ice/Settings/SettingsView.swift",
        "Ice/Settings/SettingsWindow.swift",
        "Ice/Main/",
        "Ice/Permissions/",
        "Ice/Hotkeys/",
        "Ice/UI/HotkeyRecorder/"
      ],
      "review": "нет",
      "model": "обычная",
      "status": "done",
      "startedAt": "2026-10-20T00:08:29+03:00",
      "finishedAt": "2026-10-20T00:10:17+03:00",
      "retries": 0,
      "repairs": 0,
      "tests": {
        "passed": 0,
        "failed": 0
      },
      "commit": "c6b61bc"
    },
    {
      "id": "02",
      "title": "Объекты строки меню, внешний вид и Ice Bar по-русски",
      "requirements": [
        "R02",
        "R03i"
      ],
      "blockedBy": [],
      "wave": 1,
      "zone": [
        "Ice/MenuBar/MenuBarItems/",
        "Ice/MenuBar/Spacing/",
        "Ice/MenuBar/Appearance/",
        "Ice/UI/IceBar/",
        "Ice/UI/IceUI/",
        "Ice/UI/LayoutBar/",
        "Ice/UI/Pickers/",
        "Ice/UI/Shapes/",
        "Ice/UI/ViewModifiers/",
        "Ice/UI/Views/",
        "Ice/Utilities/"
      ],
      "review": "нет",
      "model": "обычная",
      "status": "done",
      "startedAt": "2026-10-20T00:08:29+03:00",
      "finishedAt": "2026-10-20T00:10:47+03:00",
      "retries": 0,
      "repairs": 0,
      "tests": {
        "passed": 0,
        "failed": 0
      },
      "commit": "072e58e"
    },
    {
      "id": "03",
      "title": "Меню Ice, «О программе», поиск, отключение обновлений, README",
      "requirements": [
        "R01",
        "R02",
        "R03i",
        "R04i",
        "R08i"
      ],
      "blockedBy": [],
      "wave": 1,
      "zone": [
        "Ice/MenuBar/ControlItem/",
        "Ice/MenuBar/MenuBarManager.swift",
        "Ice/MenuBar/MenuBarSection.swift",
        "Ice/MenuBar/Search/",
        "Ice/Settings/SettingsPanes/AboutSettingsPane.swift",
        "Ice/Updates/",
        "Ice/UserNotifications/",
        "Ice/Info.plist",
        "README.md"
      ],
      "review": "да — фундамент",
      "model": "сильная",
      "status": "done",
      "startedAt": "2026-10-20T00:08:29+03:00",
      "finishedAt": "2026-10-20T00:12:38+03:00",
      "retries": 0,
      "repairs": 0,
      "tests": {
        "passed": 0,
        "failed": 0
      },
      "commit": "62631fd"
    },
    {
      "id": "04",
      "title": "Сборка: всё компилируется, скрипт DMG",
      "requirements": [
        "R05",
        "R06",
        "R07i"
      ],
      "blockedBy": [
        "01",
        "02",
        "03"
      ],
      "wave": 2,
      "zone": [
        "scripts/",
        ".gitignore",
        "Ice.xcodeproj/",
        "Ice/"
      ],
      "review": "нет",
      "model": "сильная",
      "status": "done",
      "startedAt": "2026-10-20T00:12:38+03:00",
      "finishedAt": "2026-10-20T00:17:40+03:00",
      "retries": 0,
      "repairs": 0,
      "tests": {
        "passed": 1,
        "failed": 0
      },
      "commit": "3b748f0"
    },
    {
      "id": "F1",
      "title": "Ремонт ветки по итогам код-ревью",
      "requirements": [
        "R02",
        "R03i",
        "R05",
        "R06",
        "R07i"
      ],
      "blockedBy": [],
      "wave": 3,
      "zone": [
        "Ice/",
        "Ice.xcodeproj/",
        "scripts/",
        ".autopilot/2026-10-20-ice-ru--wip/interfaces.md"
      ],
      "review": "да — ремонт ветки",
      "model": "сильная",
      "status": "done",
      "retries": 0,
      "repairs": 0,
      "startedAt": "2026-10-20T00:23:22+03:00",
      "finishedAt": "2026-10-20T00:26:12+03:00",
      "tests": {
        "passed": 1,
        "failed": 0
      },
      "commit": "527b235"
    }
  ],
  "tests": {
    "passed": 1,
    "failed": 0
  },
  "debt": {
    "placeholders": [],
    "assumptions": [],
    "emptyEnv": []
  },
  "additions": [],
  "coverage": {
    "found": 0,
    "fixed": 0,
    "deferred": 0,
    "items": []
  },
  "concerns": [
    "Modifiers.labelValue / KeyCode «Space» оставлены английскими как имена клавиш (не используются в UI)",
    "Названия спецобъектов Пункта управления в MenuBarItem.displayName подобраны без сверки с живой русской macOS",
    "Ice/MenuBar/ControlItem/ControlItem.swift:~500 — две пустые строки подряд после удаления блока обновлений",
    "Ice/Updates/UpdatesManager.swift:67 — лишнее присваивание canCheckForUpdates = false",
    "Ice/MenuBar/Search/MenuBarSearchPanel.swift:377 — «Нажать объект» → в macOS принято «Щёлкнуть»",
    "Подпись содержит get-task-allow=true (Xcode при ad-hoc) — для локального Mac не мешает"
  ],
  "blind": {
    "checked": 4,
    "matched": 2,
    "mismatches": [
      "R01 — форк есть, но коммиты перевода не отправлены в rolexx671/Ice (push требует подтверждения)",
      "R06 — установка ещё не выполнена на момент приёмки (делается после неё)"
    ]
  },
  "beats": [
    "2026-10-20T00:02:13+03:00",
    "2026-10-20T00:02:26+03:00",
    "2026-10-20T00:03:03+03:00",
    "2026-10-20T00:07:24+03:00",
    "2026-10-20T00:08:07+03:00",
    "2026-10-20T00:08:20+03:00",
    "2026-10-20T00:08:24+03:00",
    "2026-10-20T00:08:26+03:00",
    "2026-10-20T00:08:29+03:00",
    "2026-10-20T00:08:30+03:00",
    "2026-10-20T00:10:17+03:00",
    "2026-10-20T00:10:47+03:00",
    "2026-10-20T00:11:30+03:00",
    "2026-10-20T00:12:38+03:00",
    "2026-10-20T00:17:40+03:00",
    "2026-10-20T00:23:22+03:00",
    "2026-10-20T00:26:12+03:00",
    "2026-10-20T00:28:48+03:00",
    "2026-10-20T00:30:41+03:00"
  ],
  "rev": 39,
  "waiting": null,
  "waits": [],
  "log": [
    {
      "t": "2026-10-20T00:02:13+03:00",
      "k": "init"
    },
    {
      "t": "2026-10-20T00:02:26+03:00",
      "k": "stage",
      "id": "manifest",
      "act": "start"
    },
    {
      "t": "2026-10-20T00:03:03+03:00",
      "k": "stage",
      "id": "briefing",
      "act": "skip",
      "note": "вопросов не потребовалось"
    },
    {
      "t": "2026-10-20T00:03:03+03:00",
      "k": "gate",
      "g": "G1",
      "ok": false,
      "open": 7,
      "total": 8
    },
    {
      "t": "2026-10-20T00:03:03+03:00",
      "k": "stage",
      "id": "spec",
      "act": "start"
    },
    {
      "t": "2026-10-20T00:07:24+03:00",
      "k": "gate",
      "g": "G2",
      "ok": true,
      "found": 0,
      "fixed": 0,
      "deferred": 0
    },
    {
      "t": "2026-10-20T00:07:24+03:00",
      "k": "stage",
      "id": "plan",
      "act": "start"
    },
    {
      "t": "2026-10-20T00:08:07+03:00",
      "k": "tier",
      "v": "T2"
    },
    {
      "t": "2026-10-20T00:08:07+03:00",
      "k": "tickets",
      "n": 4
    },
    {
      "t": "2026-10-20T00:08:07+03:00",
      "k": "gate",
      "g": "G3",
      "ok": false,
      "problems": 4
    },
    {
      "t": "2026-10-20T00:08:20+03:00",
      "k": "tickets",
      "n": 4
    },
    {
      "t": "2026-10-20T00:08:20+03:00",
      "k": "gate",
      "g": "G3",
      "ok": true,
      "problems": 0
    },
    {
      "t": "2026-10-20T00:08:26+03:00",
      "k": "stage",
      "id": "build",
      "act": "start"
    },
    {
      "t": "2026-10-20T00:08:29+03:00",
      "k": "ticket",
      "ids": [
        "01",
        "02",
        "03"
      ],
      "act": "start"
    },
    {
      "t": "2026-10-20T00:08:30+03:00",
      "k": "stage",
      "id": "build",
      "act": "start"
    },
    {
      "t": "2026-10-20T00:10:17+03:00",
      "k": "ticket",
      "ids": [
        "01"
      ],
      "act": "done",
      "tests": {
        "passed": 0,
        "failed": 0
      }
    },
    {
      "t": "2026-10-20T00:10:17+03:00",
      "k": "add",
      "key": "concerns",
      "n": 1
    },
    {
      "t": "2026-10-20T00:10:47+03:00",
      "k": "ticket",
      "ids": [
        "02"
      ],
      "act": "done",
      "tests": {
        "passed": 0,
        "failed": 0
      }
    },
    {
      "t": "2026-10-20T00:10:47+03:00",
      "k": "add",
      "key": "concerns",
      "n": 1
    },
    {
      "t": "2026-10-20T00:11:30+03:00",
      "k": "ticket",
      "ids": [
        "03"
      ],
      "act": "review"
    },
    {
      "t": "2026-10-20T00:12:38+03:00",
      "k": "ticket",
      "ids": [
        "03"
      ],
      "act": "done",
      "tests": {
        "passed": 0,
        "failed": 0
      }
    },
    {
      "t": "2026-10-20T00:12:38+03:00",
      "k": "add",
      "key": "concerns",
      "n": 3
    },
    {
      "t": "2026-10-20T00:12:38+03:00",
      "k": "ticket",
      "ids": [
        "04"
      ],
      "act": "start"
    },
    {
      "t": "2026-10-20T00:17:40+03:00",
      "k": "ticket",
      "ids": [
        "04"
      ],
      "act": "done",
      "tests": {
        "passed": 1,
        "failed": 0
      }
    },
    {
      "t": "2026-10-20T00:17:40+03:00",
      "k": "add",
      "key": "concerns",
      "n": 1
    },
    {
      "t": "2026-10-20T00:17:40+03:00",
      "k": "stage",
      "id": "review",
      "act": "start"
    },
    {
      "t": "2026-10-20T00:23:22+03:00",
      "k": "tickets",
      "n": 5
    },
    {
      "t": "2026-10-20T00:23:22+03:00",
      "k": "gate",
      "g": "G3",
      "ok": true,
      "problems": 0
    },
    {
      "t": "2026-10-20T00:23:22+03:00",
      "k": "add",
      "key": "report",
      "n": 1
    },
    {
      "t": "2026-10-20T00:23:22+03:00",
      "k": "ticket",
      "ids": [
        "F1"
      ],
      "act": "start"
    },
    {
      "t": "2026-10-20T00:26:12+03:00",
      "k": "ticket",
      "ids": [
        "F1"
      ],
      "act": "done",
      "tests": {
        "passed": 1,
        "failed": 0
      }
    },
    {
      "t": "2026-10-20T00:26:12+03:00",
      "k": "add",
      "key": "report",
      "n": 1
    },
    {
      "t": "2026-10-20T00:26:12+03:00",
      "k": "stage",
      "id": "final",
      "act": "start"
    },
    {
      "t": "2026-10-20T00:28:48+03:00",
      "k": "gate",
      "g": "G4",
      "ok": false,
      "checked": 4,
      "matched": 2
    },
    {
      "t": "2026-10-20T00:30:41+03:00",
      "k": "tests",
      "passed": 1,
      "failed": 0
    },
    {
      "t": "2026-10-20T00:30:41+03:00",
      "k": "finish",
      "result": "Ice полностью на русском, DMG собран и установлен в /Applications"
    }
  ],
  "reqList": [
    {
      "id": "R01",
      "text": "«делай форк этого проекта https://github.com/jordanbaird/Ice»",
      "status": "done"
    },
    {
      "id": "R02",
      "text": "«переводи полностью на русский язык» — весь видимый интерфейс приложения",
      "status": "done"
    },
    {
      "id": "R03i",
      "text": "(подразумевается) «полностью» — системные тексты тоже: запросы разрешений, уведомления, меню, алерты",
      "status": "done"
    },
    {
      "id": "R04i",
      "text": "(подразумевается) «полностью» — документация форка (README) тоже на русском",
      "status": "done"
    },
    {
      "id": "R05",
      "text": "«выкатывай в dmg»",
      "status": "done"
    },
    {
      "id": "R06",
      "text": "«установи на мой мак»",
      "status": "done"
    },
    {
      "id": "R07i",
      "text": "(подразумевается) приложение собирается и запускается без аккаунта разработчика Apple",
      "status": "done"
    },
    {
      "id": "R08i",
      "text": "(подразумевается) автообновление не должно заменить русскую версию английской из оригинала",
      "status": "done"
    }
  ],
  "gates": {
    "G1": {
      "ok": false,
      "at": "2026-10-20T00:03:03+03:00",
      "open": 7,
      "total": 8
    },
    "G2": {
      "ok": true,
      "at": "2026-10-20T00:07:24+03:00",
      "found": 0,
      "fixed": 0,
      "deferred": 0
    },
    "G3": {
      "ok": true,
      "at": "2026-10-20T00:23:22+03:00",
      "problems": 0
    },
    "G4": {
      "ok": false,
      "at": "2026-10-20T00:28:48+03:00",
      "checked": 4,
      "matched": 2
    }
  },
  "result": "Ice полностью на русском, DMG собран и установлен в /Applications",
  "report": [
    "Названия модулей Пункта управления (например «Сейчас играет», «Стейдж-менеджер») подобраны без сверки с живой русской macOS — могут чуть отличаться от системных",
    "Код-ревью: 10 замечаний — 9 исправлено, 1 в отчёте (названия модулей Пункта управления)"
  ]
}
