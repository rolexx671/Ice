#!/usr/bin/env bash
# Устанавливает Ice.app из DMG в /Applications (с заменой) и запускает его.
#
# Использование: scripts/install-from-dmg.sh <путь к .dmg>
set -euo pipefail

die() { echo "Ошибка: $*" >&2; exit 1; }

[[ $# -eq 1 ]] || die "использование: $0 <путь к .dmg>"
DMG="$1"
[[ -f "$DMG" ]] || die "файл не найден: $DMG"

DEST="/Applications/Ice.app"
MOUNT_POINT="$(mktemp -d "${TMPDIR:-/tmp}/ice-mount.XXXXXX")"
MOUNTED=0

cleanup() {
    if [[ $MOUNTED -eq 1 ]]; then
        hdiutil detach "$MOUNT_POINT" -quiet || hdiutil detach "$MOUNT_POINT" -force -quiet || true
    fi
    rmdir "$MOUNT_POINT" 2>/dev/null || true
}
trap cleanup EXIT

echo "==> Монтирование $DMG…"
hdiutil attach "$DMG" -nobrowse -readonly -noautoopen -mountpoint "$MOUNT_POINT" -quiet
MOUNTED=1

SRC="$MOUNT_POINT/Ice.app"
[[ -d "$SRC" ]] || die "в образе нет Ice.app"

echo "==> Завершение запущенного Ice…"
if pgrep -x Ice >/dev/null; then
    osascript -e 'tell application id "com.jordanbaird.Ice" to quit' >/dev/null 2>&1 || true
    for _ in $(seq 1 20); do
        pgrep -x Ice >/dev/null || break
        sleep 0.5
    done
    if pgrep -x Ice >/dev/null; then
        pkill -x Ice || true
        sleep 1
    fi
    if pgrep -x Ice >/dev/null; then
        die "не удалось завершить запущенный Ice"
    fi
fi

echo "==> Копирование в $DEST…"
rm -rf "$DEST"
ditto "$SRC" "$DEST"

echo "==> Отмонтирование образа…"
hdiutil detach "$MOUNT_POINT" -quiet
MOUNTED=0

echo "==> Снятие карантина…"
xattr -dr com.apple.quarantine "$DEST" 2>/dev/null || true

codesign --verify --deep --strict "$DEST" || die "подпись $DEST не прошла проверку"

echo "==> Запуск Ice…"
open "$DEST"

echo "Готово: Ice установлен в $DEST и запущен."
