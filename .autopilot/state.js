window.STATE =
{
  "version": 2,
  "slug": "ice-ru",
  "dir": "2026-10-20-ice-ru--wip",
  "title": "Ice — русская локализация и DMG",
  "mode": "semi",
  "depth": "normal",
  "tier": "T2",
  "briefFile": "2026-10-20-brief.md",
  "memoryFile": "AGENTS.md",
  "memoryOwner": "autopilot",
  "skillDir": "/Users/alex/.claude/skills/autopilot",
  "baseCommit": null,
  "startedAt": "2026-10-20T00:02:13+03:00",
  "updatedAt": "2026-10-20T00:08:20+03:00",
  "finishedAt": null,
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
      "status": "active",
      "startedAt": "2026-10-20T00:07:24+03:00"
    },
    {
      "id": "build",
      "status": "pending"
    },
    {
      "id": "review",
      "status": "pending"
    },
    {
      "id": "final",
      "status": "pending"
    }
  ],
  "requirements": {
    "total": 8,
    "done": 0,
    "inTicket": 8,
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
      "status": "pending",
      "retries": 0,
      "repairs": 0
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
      "status": "pending",
      "retries": 0,
      "repairs": 0
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
      "status": "pending",
      "retries": 0,
      "repairs": 0
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
      "status": "pending",
      "retries": 0,
      "repairs": 0
    }
  ],
  "tests": null,
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
  "concerns": [],
  "blind": null,
  "beats": [
    "2026-10-20T00:02:13+03:00",
    "2026-10-20T00:02:26+03:00",
    "2026-10-20T00:03:03+03:00",
    "2026-10-20T00:07:24+03:00",
    "2026-10-20T00:08:07+03:00",
    "2026-10-20T00:08:20+03:00"
  ],
  "rev": 14,
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
    }
  ],
  "reqList": [
    {
      "id": "R01",
      "text": "«делай форк этого проекта https://github.com/jordanbaird/Ice»",
      "status": "in-ticket"
    },
    {
      "id": "R02",
      "text": "«переводи полностью на русский язык» — весь видимый интерфейс приложения",
      "status": "in-ticket"
    },
    {
      "id": "R03i",
      "text": "(подразумевается) «полностью» — системные тексты тоже: запросы разрешений, уведомления, меню, алерты",
      "status": "in-ticket"
    },
    {
      "id": "R04i",
      "text": "(подразумевается) «полностью» — документация форка (README) тоже на русском",
      "status": "in-ticket"
    },
    {
      "id": "R05",
      "text": "«выкатывай в dmg»",
      "status": "in-ticket"
    },
    {
      "id": "R06",
      "text": "«установи на мой мак»",
      "status": "in-ticket"
    },
    {
      "id": "R07i",
      "text": "(подразумевается) приложение собирается и запускается без аккаунта разработчика Apple",
      "status": "in-ticket"
    },
    {
      "id": "R08i",
      "text": "(подразумевается) автообновление не должно заменить русскую версию английской из оригинала",
      "status": "in-ticket"
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
      "at": "2026-10-20T00:08:20+03:00",
      "problems": 0
    }
  },
  "result": null
}
