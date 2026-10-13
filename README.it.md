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

Dopo l'installazione, invoca Francesco per nome:

> **`/francesco`** — orchestratore (menu completo, sceglie il flusso giusto)
> **`/francesco-bilancio`** — controlli bilancio
> **`/francesco-estratto`** — riconciliazione bancaria
> **`/francesco-revisione`** — documenti di revisione

L'orchestratore ti saluta, fa i controlli preflight, poi chiede cosa ti serve. Digli direttamente cosa vuoi — sceglie lui il flusso. Le sub-skill saltano il menu e vanno dritte al lavoro.

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

---

## Perché Esiste Francesco

Ogni revisione produce lo stesso dolore:
- **Fogli di calcolo con trimestri mancanti**
- **Firme che non coincidono con le date**
- **"Sono sicuro di aver salvato quel file"** (non è vero)

Francesco è costruito per un lavoro solo: **documentazione di revisione, fatta bene, ogni volta.** Non si annoia, non va di fretta, e ricontrolla tutto — compreso il suo stesso triplo check.

---

## Funzionalità

| Funzione | Cosa fa |
|---|---|
| **Flusso di Revisione** | Ciclo completo: estrazione contesto, pianificazione, esecuzione, triplo check, chiusura |
| **Validazione Documenti** | Incrocia dati, date, firme, importi tra tutte le fonti |
| **Archivio Normativo** | Database normativo locale costruito per giurisdizione, tipo società e settore. Funziona offline. |
| **Triplo Check** | Esegui → verifica → riverifica → rileggi un altro file per sicurezza |
| **Estrazione Contesto** | Scansiona i documenti esistenti per ricostruire giurisdizione, tipo società, mandato, stato revisione |
| **Documenti Scansionati** | PDF scansionati e foto? Francesco li legge direttamente e risomma i totali. Nessuno strumento OCR. |
| **Auto-Logging** | Ogni sessione scrive un log datato. `PROCESSO_REVISIONE.md` sempre aggiornato. |
| **Multi-piattaforma** | Funziona su Linux, macOS, Windows. Claude, Claude Code, OpenCode, Cursor, altri. Zero dipendenze. |
| **Controllo Bilancio** | Quadratura SP/CE, cross-foot, aggancio nota integrativa, scelte contabili |
| **Benford / Anti-Manipolazione** | Test χ², Z per cifra, bias arrotondamento, importi duplicati, terminal-digit, clustering soglie |
| **Riconciliazione Bancaria** | Abbina movimenti, classifica unreconciled, riconcilia saldo, incrocia cassa |

---

## Come Funziona

L'orchestratore (`/francesco`) esegue questo ciclo a ogni sessione:

```
Check frustrazione → Preflight → Capisci richiesta → Carica comando → Esegui → Verifica output → Triplo check → Chiudi
```

1. **Check frustrazione** — rileva frustrazione/imprecazioni (pattern IT + EN); 1-2 match → messaggio calma; 3+ consecutivi → salta, vai diretto
2. **Preflight** — trova la directory società, segnala strumenti opzionali (skill docx/xlsx), valida struttura, legge ultimo log
3. **Cosa vuoi fare?** — se non hai ancora detto nulla, si presenta e chiede cosa serve; conferma la comprensione prima di procedere
4. **Sceglie il comando giusto** — associa la tua richiesta al flusso giusto
5. **Esegue** — lancia il comando scelto
6. **Verifica output** — apre i file prodotti, controlla che il log sia stato scritto
7. **Triplo check** — 4 giri (esegui → verifica → sicurezza → rileggi ultima riga ultimo log)
8. **Chiude** — scrive log, aggiorna `PROCESSO_REVISIONE.md`, offre report DOCX

**Sub-skill** (`/francesco-bilancio`, `/francesco-estratto`, `/francesco-revisione`) saltano il punto 3 e vanno dritte al loro flusso, con triplo check e chiusura propri. Leggono regole e flussi condivisi dalla skill `francesco`, quindi installa le quattro insieme.

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
  │             │             └─ Scansioni? Lettura diretta. DOCX? skill docx. XLSX? skill xlsx.
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

Durante analisi, lettura scansioni, lettura fonti e controlli intermedi, Francesco scrive in stile compresso — frasi brevi, niente narrativa inutile, conserva tutti i numeri, le date, i nomi e i riferimenti.

**Leggibilità piena riservata a:** domande all'utente, warning critici, log ufficiali, documenti formali e riepilogo finale.

---

> *"N.d. è meglio di una bugia. Il dubbio è meglio di una certezza frettolosa."*
> — Francesco, a ogni sessione

---

## Installazione

Nessuna dipendenza: Francesco è fatto di skill in Markdown. Niente Python, niente server MCP, niente plugin.

### Un comando (Linux / macOS)

```bash
curl -fsSL https://raw.githubusercontent.com/xh74d82hl/francesco/main/install.sh | bash
```

Rileva il tuo agente e copia le quattro skill nella sua cartella skills. Riavvia l'agente, poi scrivi `/francesco`.

### Windows

```powershell
irm https://raw.githubusercontent.com/xh74d82hl/francesco/main/install.ps1 | iex
```

### App Claude (claude.ai / desktop)

1. Scarica questo repo e crea uno zip della cartella `skills/francesco` (lo zip deve contenere la cartella `francesco`).
2. In Claude: Impostazioni → Skills → carica lo zip.

La skill `francesco` contiene tutti i flussi. Le tre skill `francesco-*` sono scorciatoie per gli agenti da terminale e qui non servono.

### Altri modi

```bash
# CLI skills (richiede Node)
npx skills add xh74d82hl/francesco

# Manuale
git clone https://github.com/xh74d82hl/francesco.git
cp -R francesco/skills/* ~/.claude/skills/
```

### Flag dell'installer

| Flag | Cosa fa |
|---|---|
| `--agent <nome>` | `claude-code`, `opencode` o `agents` (`~/.agents/skills`) |
| `--dir <percorso>` | Installa in un'altra cartella skills |
| `--yes` | Non chiede mai (fallisce se rileva più di un agente) |
| `--list` | Mostra gli agenti rilevati |

Per passare i flag al comando unico: `| bash -s -- --agent claude-code`. Da un clone, `bash install.sh` installa la tua copia locale.

---

## Struttura

```
francesco/                     — questo repo
  skills/
    francesco/                 — orchestratore (regole condivise + menu)
      SKILL.md
      references/              — flussi dettagliati, caricati quando servono
        revisione.md           — sessione revisione completa
        check.md               — validazione documenti
        bilancio_check.md      — controlli bilancio + Benford/pattern
        estratto_check.md      — riconciliazione bancaria
        normativa.md           — archivio normativo + auto-aggiornamento
        triage.md              — scansione rapida società
        inizializza.md         — commissionamento nuova società
        riepilogo.md           — report DOCX riassuntivo
        struttura.md           — validazione struttura directory
    francesco-revisione/       — scorciatoia: workflow revisione
    francesco-bilancio/        — scorciatoia: controlli bilancio
    francesco-estratto/        — scorciatoia: riconciliazione bancaria
  install.sh / install.ps1     — installer
  README.md / README.it.md
  DIRECTION.md                 — roadmap
  characters/francesco.svg     — la faccia
```

Installa le quattro skill una accanto all'altra: le scorciatoie leggono i `references/` dell'orchestratore.

---

## Requisiti

- Un agente che supporta le Agent Skills (Claude, Claude Code, OpenCode, Cursor, ...) con un modello che legge PDF e immagini
- Opzionale: skill `docx` / `xlsx` per output Word ed Excel (altrimenti Markdown/CSV)
- Opzionale: LibreOffice per file `.doc` legacy

---

## Licenza

[MIT](LICENSE)

---

## Crediti

Stile ispirato da **Ralph** — perché quando un bro fa un buon lavoro, si dice.

Localizzazione italiana di **Kami** — pulita, calda, precisa.

Costruito con ❤️ per revisori, commercialisti e chiunque ricontrolli il proprio controllo.
