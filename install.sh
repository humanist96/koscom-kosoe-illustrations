#!/usr/bin/env bash
# 코쇠 삽화 스킬을 Claude Code / Codex 스킬 폴더에 설치한다.
# 사용법: ./install.sh            (둘 다 설치)
#         ./install.sh claude     (Claude Code만)
#         ./install.sh codex      (Codex만)
set -euo pipefail
SKILL=koscom-kosoe-illustrations
SRC="$(cd "$(dirname "$0")" && pwd)/$SKILL"
TARGET="${1:-all}"

install_to() {
  mkdir -p "$1"
  rm -rf "$1/$SKILL"
  cp -R "$SRC" "$1/"
  echo "설치 완료: $1/$SKILL"
}

case "$TARGET" in
  claude) install_to "$HOME/.claude/skills" ;;
  codex)  install_to "${CODEX_HOME:-$HOME/.codex}/skills" ;;
  all)    install_to "$HOME/.claude/skills"; install_to "${CODEX_HOME:-$HOME/.codex}/skills" ;;
  *) echo "알 수 없는 대상: $TARGET (claude|codex|all)" >&2; exit 2 ;;
esac
