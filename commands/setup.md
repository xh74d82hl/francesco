# commands/setup — Prima configurazione dipendenze

**Chiamato da:** orchestratore `SKILL.md` (preflight, prima esecuzione).
**Standalone:** se l'utente dice "setup" / "configura" / "installa dipendenze".

Verifica e installa tutto il necessario per far funzionare Francesco:
Python, uv, docling, MCP server, skill docx/xlsx, libreoffice.

---

## Flusso

```
Check Python → Check uv → Installa docling → Configura MCP → Installa skill docx/xlsx → Check libreoffice
```

Ogni step CHIEDE all'utente prima di agire.
Skip automatico se già presente.

---

## Step 1 — Python

```bash
python3 --version
```

- Trovato? → Salta. Mostra versione.
- Non trovato? → "Python non trovato. È richiesto per OCR.
  Installalo da https://www.python.org/downloads/ o con il tuo package manager.
  Dopo averlo installato, riavvia il setup."

Non installare automaticamente. Troppo variabile tra sistemi.

---

## Step 2 — uv

```bash
uv --version
```

- Trovato? → Salta.
- Non trovato? → "uv non trovato. Lo installo?
  (curl -LsSf https://astral.sh/uv/install.sh | sh) [S/n]"

Se utente dice si → esegui:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```
Poi verifica: `uv --version`.

---

## Step 3 — docling

```bash
uv tool list 2>/dev/null | grep docling
```

- Trovato? → Salta.
- Non trovato? → "docling non installato. Lo installo?
  (uv tool install docling) [S/n]"

Se utente dice si → esegui:
```bash
uv tool install docling
```

Verifica con:
```bash
uv tool list | grep docling
```

---

## Step 4 — MCP server (opencode)

```bash
ls ~/.config/opencode/mcp-servers/docling-server.py 2>/dev/null
```

- Trovato? → Salta.
- Non trovato? → "Configuro il server MCP docling per opencode? [S/n]"

Se utente dice si:

### 4a. Crea directory MCP servers
```bash
mkdir -p ~/.config/opencode/mcp-servers
```

### 4b. Copia script docling-server.py
```bash
cp <SKILL_DIR>/scripts/docling-server.py ~/.config/opencode/mcp-servers/docling-server.py
```

Dove `<SKILL_DIR>` e la directory della skill `francesco`.

### 4c. Aggiungi configurazione a opencode.json

Se `~/.config/opencode/opencode.json` non esiste, crealo con:
```json
{
  "mcp": {
    "docling": {
      "type": "local",
      "command": ["uv", "run", "--with", "mcp", "--with", "docling", "--no-project", "python", "~/.config/opencode/mcp-servers/docling-server.py"],
      "enabled": true
    }
  }
}
```

Se esiste gia, carica il JSON esistente e aggiungi la sezione `mcp.docling`.
Usa uno strumento JSON (es. `jq` o Python) per fare merge senza rompere la struttura esistente.

Esempio con Python:
```python
import json, os
path = os.path.expanduser("~/.config/opencode/opencode.json")
with open(path) as f:
    cfg = json.load(f)
cfg.setdefault("mcp", {})
cfg["mcp"]["docling"] = {
    "type": "local",
    "command": ["uv", "run", "--with", "mcp", "--with", "docling", "--no-project", "python", os.path.expanduser("~/.config/opencode/mcp-servers/docling-server.py")],
    "enabled": true
}
with open(path, "w") as f:
    json.dump(cfg, f, indent=2)
```

### 4d. Verifica
- `ls ~/.config/opencode/mcp-servers/docling-server.py` conferma file.
- `grep docling ~/.config/opencode/opencode.json` conferma config.
- "MCP docling configurato. Riavvia opencode per attivarlo."

---

## Step 5 — skill docx

```bash
ls ~/.agents/skills/docx/SKILL.md 2>/dev/null
```

- Trovato? → Salta.
- Non trovato? → "skill docx non trovata. La installo?
  (npx skills add docx --global --agent opencode) [S/n]"

Se utente dice si → esegui:
```bash
npx skills add docx --global --agent opencode
```

---

## Step 6 — skill xlsx

```bash
ls ~/.agents/skills/xlsx/SKILL.md 2>/dev/null
```

- Trovato? → Salta.
- Non trovato? → "skill xlsx non trovata. La installo?
  (npx skills add xlsx --global --agent opencode) [S/n]"

Se utente dice si → esegui:
```bash
npx skills add xlsx --global --agent opencode
```

---

## Step 7 — libreoffice

```bash
which libreoffice 2>/dev/null
```

- Trovato? → Salta. Mostra versione.
- Non trovato? → "libreoffice non trovato. Serve per convertire file .doc
  vecchi formato HTML. Se non hai file .doc legacy, puoi ignorare.
  Installalo con il tuo package manager (apt install libreoffice / brew --cask install libreoffice)."

Non installare automaticamente. Solo informa.

---

## Riepilogo finale

```
## Setup Francesco — completato
- Python: [OK / MANCA]
- uv: [OK / MANCA]
- docling: [OK / MANCA]
- MCP docling: [OK / MANCA / disabilitato]
- skill docx: [OK / MANCA]
- skill xlsx: [OK / MANCA]
- libreoffice: [OK / MANCA (opzionale)]
```

Se tutto OK:
> "Tutto pronto. Francesco puo lavorare."

Se qualcosa manca:
> "Manca [X]. Puoi reinstallare con 'francesco setup' quando sei pronto."

---

## Marker prima esecuzione

Dopo setup completato, Francesco salva un file `.francesco-setup` nella
directory `francesco` della skill per non ripetere il setup a ogni sessione.

```bash
touch ~/.agents/skills/francesco/.francesco-setup
```

Alla prossima sessione, preflight controlla:
- File `.francesco-setup` esiste? → skip setup.
- Non esiste? → "Prima esecuzione. Vuoi configurare le dipendenze?"
