#!/bin/bash
# Instala o tema Café Espresso no Claude Code e no Terminal do Mac.
# Uso: curl -fsSL https://raw.githubusercontent.com/fefo-gith/mods/HEAD/install-mac.sh | bash
set -euo pipefail

BASE="https://raw.githubusercontent.com/fefo-gith/mods/HEAD/plugins/cafe-theme"
PROFILE="Cafe Espresso"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
CLAUDE_JSON="${CLAUDE_CONFIG_DIR:-$HOME}/.claude.json"

echo "☕ Instalando o tema Café Espresso..."

# 1. Tema do Claude Code: ~/.claude/themes/cafe-espresso.json
mkdir -p "$CLAUDE_DIR/themes"
curl -fsSL "$BASE/themes/espresso.json" -o "$CLAUDE_DIR/themes/cafe-espresso.json"
echo "  ✔ tema copiado para $CLAUDE_DIR/themes/cafe-espresso.json"

# 2. Deixa o Café Espresso como tema padrão do Claude Code
if [ -f "$CLAUDE_JSON" ]; then
  cp "$CLAUDE_JSON" "$CLAUDE_JSON.antes-do-cafe"
fi
if CLAUDE_JSON="$CLAUDE_JSON" osascript -l JavaScript >/dev/null <<'JXA'
ObjC.import('Foundation');
ObjC.import('stdlib');
var path = $.getenv('CLAUDE_JSON');
var cfg = {};
if ($.NSFileManager.defaultManager.fileExistsAtPath(path)) {
  var text = ObjC.unwrap($.NSString.stringWithContentsOfFileEncodingError(path, $.NSUTF8StringEncoding, null));
  if (text == null) throw new Error('não consegui ler ' + path);
  if (text.trim() !== '') cfg = JSON.parse(text);
}
cfg.theme = 'custom:cafe-espresso';
var ok = $(JSON.stringify(cfg, null, 2)).writeToFileAtomicallyEncodingError(path, true, $.NSUTF8StringEncoding, null);
if (!ok) throw new Error('não consegui salvar ' + path);
JXA
then
  chmod 600 "$CLAUDE_JSON"
  echo "  ✔ Claude Code configurado para abrir sempre com o Café Espresso"
else
  echo "  ⚠ não consegui definir o tema automaticamente: abra o Claude Code, digite /theme e escolha Café Espresso"
fi

# 3. Perfil do Terminal do Mac com fundo marrom espresso
TMP_PROFILE="$(mktemp -d)/cafe-espresso.terminal"
curl -fsSL "$BASE/terminal/cafe-espresso.terminal" -o "$TMP_PROFILE"
open "$TMP_PROFILE"   # importa o perfil (abre uma janela nova com ele)

for _ in 1 2 3 4 5 6 7 8 9 10; do
  if osascript -e "tell application \"Terminal\" to exists settings set \"$PROFILE\"" 2>/dev/null | grep -q true; then
    break
  fi
  sleep 0.5
done

if osascript >/dev/null <<APPLESCRIPT
tell application "Terminal"
  set espresso to settings set "$PROFILE"
  set default settings to espresso
  set startup settings to espresso
  repeat with w in windows
    repeat with t in tabs of w
      set current settings of t to espresso
    end repeat
  end repeat
end tell
APPLESCRIPT
then
  echo "  ✔ Terminal com o perfil \"$PROFILE\" como padrão"
else
  echo "  ⚠ não consegui definir o perfil: em Terminal > Ajustes > Perfis, selecione \"$PROFILE\" e clique em Padrão"
fi

echo
echo "Pronto! Feche o Claude Code (se estiver aberto) e abra de novo com: claude"
