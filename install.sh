#!/usr/bin/env bash
#
# Instalador da skill "pauta-to-post" para o Claude Code.
#
# Uso:
#   curl -fsSL https://raw.githubusercontent.com/oeduardobrandao/pauta-to-post/main/install.sh | bash
#
# Instalação só no projeto atual (./.claude/skills em vez de ~/.claude/skills):
#   curl -fsSL https://raw.githubusercontent.com/oeduardobrandao/pauta-to-post/main/install.sh | bash -s -- --project
#
set -euo pipefail

REPO="oeduardobrandao/pauta-to-post"
BRANCH="main"
SKILL="pauta-to-post"

SCOPE="personal"
for arg in "$@"; do
  case "$arg" in
    --project|-p)  SCOPE="project" ;;
    --personal)    SCOPE="personal" ;;
    -h|--help)
      echo "Instala a skill '$SKILL' em ~/.claude/skills (pessoal) ou ./.claude/skills (--project)."
      exit 0 ;;
    *)
      echo "Argumento desconhecido: $arg" >&2
      echo "Use --project para instalar só no projeto atual." >&2
      exit 2 ;;
  esac
done

if [ "$SCOPE" = "project" ]; then
  SKILLS_DIR="$PWD/.claude/skills"
else
  SKILLS_DIR="$HOME/.claude/skills"
fi
DEST="$SKILLS_DIR/$SKILL"

echo "==> Instalando a skill '$SKILL' em: $DEST"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# Baixa o repositório como tarball e usa SÓ a subpasta da skill, garantindo o
# caminho final $DEST/SKILL.md (sem aninhar um nível a mais).
URL="https://github.com/$REPO/archive/refs/heads/$BRANCH.tar.gz"
if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$URL" -o "$TMP/repo.tar.gz"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$TMP/repo.tar.gz" "$URL"
else
  echo "Erro: preciso de 'curl' ou 'wget' instalado." >&2
  exit 1
fi

tar -xzf "$TMP/repo.tar.gz" -C "$TMP"

# A subpasta da skill dentro do tarball extraído (ex.: pauta-to-post-main/pauta-to-post/)
SRC="$TMP/${REPO#*/}-$BRANCH/$SKILL"
if [ ! -f "$SRC/SKILL.md" ]; then
  echo "Erro: SKILL.md não encontrado no pacote baixado ($SRC)." >&2
  exit 1
fi

if [ -e "$DEST" ]; then
  echo "==> '$DEST' já existe; substituindo pela versão mais recente."
fi

mkdir -p "$SKILLS_DIR"
rm -rf "$DEST"
cp -R "$SRC" "$DEST"

echo "==> Pronto: $DEST/SKILL.md"
echo "    Abra o Claude Code e rode  /$SKILL"
