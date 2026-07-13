#!/usr/bin/env bash
# eduskill 一键安装脚本
# 用法：bash install.sh   （在克隆/解压后的 eduskill 目录内运行）
# 作用：把本工具箱复制到 WorkBuddy 用户级 skills 目录，重启 WorkBuddy 即可用 /edu-* 命令
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$HOME/.workbuddy/skills/eduskill"

# 要复制的核心内容（排除 .git / dist / .workbuddy / .verify 等本地产物）
ITEMS=(SKILL.md skills knowledge docs .claude-plugin LICENSE README.md VERSION _meta.json _skillhub_meta.json tools)

mkdir -p "$(dirname "$DEST")"

# 已存在则备份
if [ -e "$DEST" ]; then
  BAK="${DEST}.bak.$(date +%s)"
  echo "检测到已安装，备份到 $BAK"
  mv "$DEST" "$BAK"
fi

mkdir -p "$DEST"
for item in "${ITEMS[@]}"; do
  if [ -e "$SRC/$item" ]; then
    cp -r "$SRC/$item" "$DEST/"
  fi
done

echo ""
echo "eduskill 已安装到：$DEST"
echo "重启 WorkBuddy 后，即可用 /edu-diagnosis 等命令调用。"
