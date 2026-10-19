#!/usr/bin/env bash
# Собирает Release-сборку Ice с ad-hoc подписью и упаковывает её в
# dist/Ice-<MARKETING_VERSION>-ru.dmg (внутри Ice.app и ярлык «Программы»).
#
# Использование: scripts/build-dmg.sh
# Требуется: Xcode (xcodebuild), интернет при первом разрешении SPM-пакетов.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

BUILD_DIR="$ROOT/build"
DIST_DIR="$ROOT/dist"
APP="$BUILD_DIR/Build/Products/Release/Ice.app"

die() { echo "Ошибка: $*" >&2; exit 1; }

command -v xcodebuild >/dev/null || die "не найден xcodebuild (нужен Xcode)"
command -v hdiutil >/dev/null || die "не найден hdiutil"
command -v codesign >/dev/null || die "не найден codesign"

echo "==> Сборка Release (ad-hoc подпись)…"
# CODE_SIGN_IDENTITY=- с командной строки перекрывает и условную
# настройку таргета CODE_SIGN_IDENTITY[sdk=macosx*].
xcodebuild \
    -project Ice.xcodeproj \
    -scheme Ice \
    -configuration Release \
    -derivedDataPath "$BUILD_DIR" \
    CODE_SIGN_IDENTITY=- \
    DEVELOPMENT_TEAM= \
    CODE_SIGN_STYLE=Manual \
    ENABLE_HARDENED_RUNTIME=NO \
    build

[[ -d "$APP" ]] || die "после сборки не найден $APP"

VERSION="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$APP/Contents/Info.plist")"
[[ -n "$VERSION" ]] || die "не удалось прочитать версию из Info.plist"

if /usr/libexec/PlistBuddy -c 'Print :SUFeedURL' "$APP/Contents/Info.plist" >/dev/null 2>&1; then
    die "в Info.plist собранного приложения есть SUFeedURL — обновления должны быть отключены"
fi

echo "==> Ad-hoc подпись…"
codesign --force --deep --sign - --preserve-metadata=entitlements "$APP"
codesign --verify --deep --strict --verbose=2 "$APP"

DMG="$DIST_DIR/Ice-$VERSION-ru.dmg"
STAGING="$(mktemp -d "${TMPDIR:-/tmp}/ice-dmg.XXXXXX")"
trap 'rm -rf "$STAGING"' EXIT

echo "==> Подготовка содержимого образа…"
ditto "$APP" "$STAGING/Ice.app"
ln -s /Applications "$STAGING/Applications"

mkdir -p "$DIST_DIR"
rm -f "$DMG"

echo "==> Создание $DMG…"
hdiutil create \
    -volname "Ice" \
    -srcfolder "$STAGING" \
    -ov \
    -format UDZO \
    "$DMG"

hdiutil verify "$DMG"

echo "Готово: $DMG"
