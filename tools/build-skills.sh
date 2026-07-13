#!/usr/bin/env bash
# eduskill 打包脚本：把当前目录打成可分发的 .skill 包（本质是一个 zip）。
# 用法：bash tools/build-skills.sh
# 产出：dist/eduskill-<VERSION>.skill，解压后顶层为 eduskill/，可直接放进 ~/.workbuddy/skills/
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

VERSION="$(cat VERSION 2>/dev/null | tr -d '[:space:]' || echo dev)"
SLUG="eduskill"
DIST="$ROOT/dist"
OUT="$DIST/$SLUG-$VERSION.skill"

mkdir -p "$DIST"

# 在临时目录构造标准包结构：顶层 <slug>/，内含 SKILL.md、子技能、参考库、知识原子、平台 meta
TMP="$(mktemp -d)"
PKG="$TMP/$SLUG"
mkdir -p "$PKG"

cp -r SKILL.md skills knowledge docs .claude-plugin LICENSE README.md VERSION _meta.json _skillhub_meta.json "$PKG/"

cd "$TMP"
zip -r "$OUT" "$SLUG" -x '*.DS_Store' >/dev/null

rm -rf "$TMP"

echo "已打包：$OUT ($(du -h "$OUT" | cut -f1))"
