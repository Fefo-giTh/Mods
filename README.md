# Mods

Mods para a interface do Claude Code.

## cafe-theme ☕

Temas marrom café que combinam com o laranja do Claude.

![preview](plugins/cafe-theme/preview.png)

- **Café Espresso**: escuro, com texto creme, bordas caramelo e acentos em areia e terracota
- **Café Latte**: claro, com fundo creme e texto marrom espresso

### Instalar

No Claude Code:

```
/plugin marketplace add fefo-gith/mods
/plugin install cafe-theme@fefo-mods
```

Depois abra `/theme` e escolha **Café Espresso** ou **Café Latte**.

### Sem plugin

Copie o arquivo do tema para a sua pasta de temas e escolha-o em `/theme`:

```
mkdir -p ~/.claude/themes
curl -o ~/.claude/themes/espresso.json https://raw.githubusercontent.com/fefo-gith/mods/main/plugins/cafe-theme/themes/espresso.json
```

> O tema muda as cores que o Claude Code desenha (texto, bordas, diffs, mensagens, status).
> A cor de fundo da janela é do seu terminal: para o visual completo, use um fundo marrom
> bem escuro, como `#1E1510` (Espresso) ou `#FBF5EE` (Latte).
