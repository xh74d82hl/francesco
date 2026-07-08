# Francesco

<p align="center">
  <img src="characters/francesco.svg" width="100%" alt="Francesco — il revisore contabile">
</p>

<p align="center">
  <i>🇬🇧 <a href="README.md">Wanna read it in Francesco's broken English?</a></i>
</p>

> **35 anni. Occhialetti tondi. Sguardo assente. Precisione maniacale.**
>
> Francesco non è un genio. Non cerca di esserlo. È il robot umano che assumi quando i numeri devono tornare — tre volte, almeno.

---

## Francesco in 10 Secondi

| Se gli chiedi... | Lui fa... |
|---|---|
| "Che tipo di società è?" | ASP? SPA? SRL? Legge i documenti e te lo dice. Se non è sicuro, fa un'ipotesi e la segna. |
| "Che mandato ho?" | Revisore legale? Sindaco unico? Collegio? Ogni mandato ha la sua checklist. |
| "Fammi una revisione" | Identifica → pianifica → esegue → triplo check → chiude. Sempre. |
| "Controlla i documenti" | Legge tutto: dati coerenti? log aggiornato? lacune segnate? |
| "Quali normative si applicano?" | Controlla prima il suo archivio personale. Se non c'è, cerca su fonti ufficiali e salva in locale. |

---

## Perché Esiste Francesco

Ogni revisione produce lo stesso dolore:
- **Fogli di calcolo con trimestri mancanti**
- **Firme che non coincidono con le date**
- **"Sono sicuro di aver salvato quel file"** (non è vero)

Francesco è costruito per un lavoro solo: **documentazione di revisione, fatta bene, ogni volta.** Non si annoia, non va di fretta, e ricontrolla tutto — compreso il suo stesso triplo check.

---

## Funzionalità

| | Funzione | Cosa fa |
|---|---|---|
| 🎯 | **Flusso di Revisione** | Ciclo completo: estrazione contesto, pianificazione, esecuzione, triplo check, chiusura |
| 📋 | **Validazione Documenti** | Incrocia dati, date, firme, importi tra tutte le fonti |
| 📚 | **Archivio Normativo** | Database normativo locale costruito per società e settore. Funziona offline. |
| 🔄 | **Triplo Check** | Esegui → verifica → riverifica → rileggi un altro file per sicurezza |
| 🧠 | **Estrazione Contesto** | Scansiona i documenti esistenti per ricostruire tipo società, mandato, stato revisione |
| 🔌 | **OCR + Docling** | PDF scansionati? Francesco li legge. DOCX, XLSX? Nativo. |
| 📝 | **Auto-Logging** | Ogni sessione scrive un log datato. `PROCESSO_REVISIONE.md` sempre aggiornato. |
| 🌐 | **Multi-piattaforma** | Funziona su Linux, macOS, Windows. OpenCode, Claude Code, Cursor, altri. |

---

## Come Funziona

### 1. Safety Preflight

Prima di toccare qualsiasi cosa, Francesco:
1. Verifica che la directory società esista
2. Crea `AGENTS.md` se manca
3. Crea `Revisione/PROCESSO_REVISIONE.md` se manca
4. Testa la leggibilità dei file (`.docx`, `.xlsx`, PDF scansionati)
5. Verifica che la data dell'ultimo log sia coerente

Se qualcosa non torna, si ferma e chiede. Non procede mai alla cieca.

### 2. Flusso di Revisione

```
Identifica  →  Pianifica  →  Esegui  →  Triplo Check  →  Chiudi
  │             │             │             │              │
  │             │             │             │              ├─ Scrivi log datato
  │             │             │             │              ├─ Aggiorna PROCESSO_REVISIONE.md
  │             │             │             │              └─ Valida file prodotti
  │             │             │             │
  │             │             │             └─ 1°: esegui
  │             │             │                2°: verifica tutto
  │             │             │                3°: se dubbio → chiedi; se certo → rifai
  │             │             │                4°: rileggi ultima riga ultimo log
  │             │             │
  │             │             └─ OCR? docling. DOCX? skill docx. XLSX? skill xlsx.
  │             │
  │             └─ Cosa serve oggi? Cosa NON toccare?
  │
  └─ Tipo società? Mandato? Settore? ATECO?
```

### 3. Archivio Normativo Personale

Francesco non tiene in testa tutte le leggi. A ogni lavoro:

1. Controlla `normative/` per vedere se ha già le norme per quel tipo di società e settore
2. Se sì → procede. Se no → cerca su Normattiva, Gazzetta Ufficiale, CNDCEC
3. Salva in locale. La prossima volta è già lì. Funziona offline.

> Niente database centrali. Niente PR per aggiornare un D.Lgs. Roba sua. Locale. Aggiornata quando serve.

---

## Disciplina Token

Durante analisi, OCR, lettura fonti e controlli intermedi, Francesco scrive in stile compresso `caveman ultra` — frasi brevi, niente narrativa inutile, conserva tutti i numeri, le date, i nomi e i riferimenti.

**Leggibilità piena riservata a:** domande all'utente, warning critici, log ufficiali, documenti formali e riepilogo finale.

---

> *"N.d. è meglio di una bugia. Il dubbio è meglio di una certezza frettolosa."*
> — Francesco, a ogni sessione

---

## Installazione

```bash
# Auto-detect (consigliato)
bash <(curl -fsSL https://raw.githubusercontent.com/xh74d82hl/francesco/main/install.sh) xh74d82hl/francesco

# Via npx skills, agente esplicito
npx skills add xh74d82hl/francesco --global --skill francesco --agent opencode

# Manuale
git clone https://github.com/xh74d82hl/francesco.git ~/.agents/skills/francesco
```

Sostituisci `opencode` con `claude-code`, `cursor` o il tuo agente.

### Flag

| Flag | Cosa fa |
|---|---|
| `--agent <nome>` | Installa per un agente specifico |
| `--yes` | Salta i prompt (solo se 1 agente rilevato) |
| `--list` | Mostra gli agenti rilevati |
| `--dev-copy` | Copia i file locali per test |

### Windows

```powershell
irm https://raw.githubusercontent.com/xh74d82hl/francesco/main/install.ps1 | iex
# Poi, se serve:
.\install.ps1 xh74d82hl/francesco
```

### Copia di Sviluppo

```bash
bash install.sh --dev-copy --target ~/.agents/skills
```

Preserva `normative/` e `scripts/` esistenti. Sicura per sviluppo iterativo.

---

## Struttura

```
~/.agents/skills/francesco/
  SKILL.md              — orchestratore (regole condivise + menu)
  README.md             — versione inglese 🇬🇧
  README.it.md          — questo file (italiano) 🇮🇹
  install.sh            — installer per Linux/macOS
  install.ps1           — installer per Windows
  DIRECTION.md          — roadmap
  characters/
    francesco.svg       — la faccia
  commands/             — istruzioni riutilizzabili
    revisione.md        — sessione revisione completa
    check.md            — validazione documenti
    normativa.md        — archivio normativo + auto-aggiornamento
    triage.md           — scansione rapida società
    inizializza.md      — commissionamento nuova società
  skills/               — skill specializzate
    francesco-revisione/
      SKILL.md          — workflow revisione
    francesco-bilancio/
      SKILL.md          — controlli bilancio (in arrivo)
    francesco-estratto/
      SKILL.md          — check estratti conto (in arrivo)
  normative/            — archivio normativo per società (gitignorato)
  scripts/              — script di utilità locali (gitignorati)
```

---

## Requisiti

- **OpenCode**, **Claude Code**, **Cursor** o agente compatibile
- `npx` disponibile nel PATH
- Opzionale: MCP `docling` per PDF scansionati
- Opzionale: LibreOffice per file `.doc` legacy

---

## Licenza

MIT

---

## Crediti

Stile ispirato da **Ralph** — perché quando un bro fa un buon lavoro, si dice.

Localizzazione italiana di **Kami** — pulita, calda, precisa.

Costruito con ❤️ per revisori, commercialisti e chiunque ricontrolli il proprio controllo.
