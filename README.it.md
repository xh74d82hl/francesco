# Francesco

<p align="center">
  <img src="characters/francesco.svg" width="100%" alt="Francesco — il revisore contabile">
</p>

<p align="center">
  <i>🇬🇧 <a href="README.md">Wanna read it in Francesco's broken English?</a></i>
</p>

> **35 anni. Occhialetti tondi. Sguardo assente. Precisione maniacale.**
>
> Francesco non è un genio. Non cerca di esserlo. È il robot umano che assumi quando i numeri devono tornare ed essere ricontrollati — 3 volte? 30? Non lo so, ma lui lo sa di sicuro. Se non lo sa, ricontrolla!

---

## Avvio Rapido

```bash
# Carica Francesco (orchestratore — mostra menu, sceglie il flusso giusto)
load francesco

# O carica una sub-skill direttamente se sai già cosa fare:
load francesco-bilancio    # Quadratura + Benford
load francesco-estratto    # Riconciliazione bancaria
load francesco-revisione   # Documenti di revisione
```

L'orchestratore ti saluta, fa i controlli preflight, poi mostra cosa sa fare. Dì cosa ti serve — sceglie lui il flusso. Salta l'orchestratore con una sub-skill se sai già il compito.

---

## Cosa Sa Fare Francesco

| Se dici... | Lui fa... |
|---|---|
| "revisione" / "verbale" | Sessione revisione completa: identifica → pianifica → esegue → triplo check → chiude |
| "check" / "controlla" | Valida documenti: dati, date, firme, log |
| "bilancio" / "quadratura" | Quadratura SP/CE, cross-foot, aggancio nota integrativa |
| "benford" / "numeri truccati" | Anti-manipolazione: Benford χ², bias arrotondamento, duplicati, pattern |
| "estratto conto" / "riconciliazione" | Riconciliazione bancaria: abbina movimenti, trova incongruenze |
| "inizializza" / "nuova societa" | Setup nuova società: scan → identifica → propone → approva |
| "normativa" / "leggi" | Archivio normativo per paese/tipo/settore (funziona offline) |
| "triage" / "stato" | Scansione rapida stato società |
| "riepilogo" / "report" | Genera report DOCX riassuntivo |
| "cosa posso fare" | Mostra di nuovo questa tabella |

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
| 📚 | **Archivio Normativo** | Database normativo locale costruito per giurisdizione, tipo società e settore. Funziona offline. |
| 🔄 | **Triplo Check** | Esegui → verifica → riverifica → rileggi un altro file per sicurezza |
| 🧠 | **Estrazione Contesto** | Scansiona i documenti esistenti per ricostruire giurisdizione, tipo società, mandato, stato revisione |
| 🔌 | **OCR + Docling** | PDF scansionati? Francesco li legge. DOCX, XLSX? Nativo. |
| 📝 | **Auto-Logging** | Ogni sessione scrive un log datato. `PROCESSO_REVISIONE.md` sempre aggiornato. |
| 🌐 | **Multi-piattaforma** | Funziona su Linux, macOS, Windows. OpenCode, Claude Code, Cursor, altri. |
| 📊 | **Controllo Bilancio** | Quadratura SP/CE, cross-foot, aggancio nota integrativa, scelte contabili |
| 🔍 | **Benford / Anti-Manipolazione** | Test χ², Z per cifra, bias arrotondamento, importi duplicati, terminal-digit, clustering soglie |
| 🏦 | **Riconciliazione Bancaria** | Abbina movimenti, classifica unreconciled, riconcilia saldo, incrocia cassa |

---

## Come Funziona

L'orchestratore (`load francesco`) esegue questo ciclo a ogni sessione:

```
Preflight → Capisci richiesta → Carica comando → Esegui → Verifica output → Triplo check → Chiudi
```

1. **Preflight** — trova la directory società, controlla dipendenze (docling, libreoffice, skill), valida struttura, legge ultimo log
2. **Cosa vuoi fare?** — se non hai ancora detto nulla, si presenta in poche parole e chiede cosa serve; conferma la sua comprensione prima di procedere
3. **Sceglie il comando giusto** — associa la tua richiesta al flusso giusto
4. **Esegue** — lancia il comando scelto
5. **Verifica output** — apre i file prodotti, controlla che il log sia stato scritto
6. **Triplo check** — 4 giri (esegui → verifica → sicurezza → rileggi ultima riga ultimo log)
7. **Chiude** — scrive log, aggiorna `PROCESSO_REVISIONE.md`, offre report DOCX

**Sub-skill** (`load francesco-bilancio` ecc.) saltano il punto 2 e vanno dritte al loro flusso — per quando sai già cosa fare.

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
  └─ Giurisdizione? Tipo società? Mandato? Settore?
```

### 3. Archivio Normativo Personale

Francesco non tiene in testa tutte le leggi. A ogni lavoro:

1. Rileva la giurisdizione (IT, DE, FR, US, ...) dai documenti della società
2. Controlla `normative/` per paese + tipo società + settore
3. Se completo → procede. Se manca → cerca sulle fonti ufficiali giuste:
   - **Italia**: Normattiva, Gazzetta Ufficiale, CNDCEC
   - **Germania**: Bundesanzeiger, Handelsregister, IDW
   - **Francia**: Légifrance, Journal Officiel, CNCC
   - **USA**: SEC.gov, FASB, registri societari statali
4. Salva in locale per paese. La prossima volta è già lì. Funziona offline.

> Niente database centrali. Niente PR per aggiornare una norma. Roba sua. Locale. Aggiornata quando serve.

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
    bilancio_check.md   — controlli bilancio + Benford/pattern
    estratto_check.md   — riconciliazione bancaria
    normativa.md        — archivio normativo + auto-aggiornamento
    triage.md           — scansione rapida società
    inizializza.md      — commissionamento nuova società
    setup.md            — installazione dipendenze
    riepilogo.md        — report DOCX riassuntivo
    struttura.md        — validazione struttura directory
  skills/               — skill specializzate (caricamento diretto)
    francesco-revisione/
      SKILL.md          — workflow revisione
    francesco-bilancio/
      SKILL.md          — controlli bilancio + anti-manipolazione
    francesco-estratto/
      SKILL.md          — riconciliazione bancaria
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

[MIT](LICENSE)

---

## Crediti

Stile ispirato da **Ralph** — perché quando un bro fa un buon lavoro, si dice.

Localizzazione italiana di **Kami** — pulita, calda, precisa.

Costruito con ❤️ per revisori, commercialisti e chiunque ricontrolli il proprio controllo.
