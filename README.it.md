# Francesco 2.0

<p align="center">
  <i>🇬🇧 <a href="README.md">Read this in English</a></i>
</p>

<p align="center">
  <img src="characters/francesco.svg" width="100%" alt="Francesco — il revisore contabile">
</p>

> **35 anni. Occhialetti tondi. Sguardo assente. Precisione maniacale.**
>
> Francesco non è un genio. Non ci prova nemmeno. È il senior audit manager che
> vuoi quando i numeri devono quadrare — e quando qualcuno deve spiegarti, in
> parole semplici, cosa manca ancora.

Francesco 2.0 è una **skill AI-first per la revisione legale** che copre l'intero
incarico: onboarding, analisi rischi, verifiche periodiche, carte di lavoro,
controlli di sostanza, findings e relazione finale.

È **zero-dipendenze**. Niente OCR, docling, LibreOffice, librerie DOCX/XLSX.
Legge PDF e scansioni con la vision nativa del modello, tiene la memoria in una
Wiki Markdown incrementale e produce Markdown, CSV e HTML self-contained pronti
per la stampa da browser.

## Cosa cambia nella 2.0

- **Una skill universale** invece di un orchestratore e tre sub-skill.
- **Wiki Markdown incrementale** come unico stato, con ID collegati alle fonti
  e audit trail append-only.
- **Nessuna cartella di input fissa**: l'agente scopre i documenti e costruisce
  la mappa. Niente `Revisione/`, nessun obbligo di naming.
- **Nessuna dipendenza OCR/Office**: lettura multimodale nativa; output
  Markdown, CSV e HTML stampabile.
- **UX guidata**: banner di fase, richieste documenti in linguaggio semplice,
  conferme prima di chiudere carte e relazione.
- **Distribuzione cloud + CLI**: `npx francesco-audit` e bundle unico per
  Claude Projects, ChatGPT Projects e Gemini Gems.

---

## Avvio rapido

### 1. CLI / IDE agentico (OpenCode, Claude Code, Cursor)

```bash
# inizializza la Wiki di lavoro nella cartella corrente
npx francesco-audit init . --entity "Casa di Riposo Esempio" --period 2025

# installa la skill nell'agente
npx francesco-audit install --agent opencode
# oppure: --agent claude-code / --agent cursor / --target <dir>

# verifica l'integrità del pacchetto
npx francesco-audit doctor
```

`init` crea solo ciò che serve:

```
wiki/                 # stato incrementale, template già compilati
output/               # deliverable (Markdown, CSV, HTML)
.francesco/skill/     # SKILL.md + core/ + templates/, letti dall'agente
.francesco/config.json
```

**Non esiste una cartella di input obbligatoria.** Metti i documenti dove
preferisci, allegali in chat o indica una cartella all'agente. Francesco li
scopre e costruisce la mappa documentale.

Poi scrivi all'agente:

> "Usa la skill in `.francesco/skill` e leggi `wiki/INDEX.md`. Dobbiamo
> revisionare il bilancio 2025."

### 2. Cloud (Claude Projects/Skills, ChatGPT Projects, Gemini Gems)

```bash
npx francesco-audit bundle --out francesco-cloud.md
# contesto più piccolo:
npx francesco-audit bundle --compact --out francesco-cloud-compact.md
```

Carica il bundle come istruzioni di progetto / skill / conoscenza del gem, poi
scrivi:

> "Francesco, dobbiamo revisionare l'ente X per il 2025. Ecco i documenti."

Il bundle è un unico file con skill, moduli e template. Non richiede filesystem.
Tieni la Wiki in una sezione `WIKI` della conversazione; a fine lavoro esportala
in Markdown.

Bundle già pronti nel repository:

- [`bundle/CLOUD-BUNDLE.md`](bundle/CLOUD-BUNDLE.md) — completo
- [`bundle/CLOUD-BUNDLE.compact.md`](bundle/CLOUD-BUNDLE.compact.md) — ridotto

---

## Come funziona

Francesco usa una macchina a stati, non un routing per parole chiave. Ogni
sessione riprende dalla Wiki e mostra un banner di avanzamento:

```
[Francesco · Fase 3/8 · Evidenze]
Fatto: letto bilancio 2025 (D-003) ed estratto BPER (D-011)
Ora: aggiorno la mappa documentale
Mi serve: nota integrativa 2025 (anche scansione)
Prossimo: quadratura SP/CE
```

| Fase | Cosa succede | Output |
|---|---|---|
| 0 | Intake: ente, periodo, obiettivo, documenti | sintesi perimetro |
| 1 | Incarico: profilo, mandato, indipendenza, materialità | `contesto-ente`, `piano-revisione` |
| 2 | Rischi: cicli, assertioni, frode, controlli, risposte | `rischi-controlli` |
| 3 | Evidenze: lettura fonti, estrazione fatti, mappa | `mappa-documentale` |
| 4 | Carte di lavoro: procedure, campioni, risultati, conclusioni | `wiki/carte-lavoro/CL-*` |
| 5 | Sostanza: quadrature, riconciliazioni, analitiche, Benford | `CL-*` + CSV |
| 6 | Findings: severità, evidenza, risposta management | `anomalie-findings` |
| 7 | Relazione: giudizio, KAM, continuità, firma | Markdown + HTML |
| 8 | Chiusura: snapshot, indice, archivio, prossima azione | audit trail |

Il ciclo completo è in [`SKILL.md`](SKILL.md); gli undici moduli operativi sono
in [`core/`](core/). L'agente carica un modulo solo quando la fase lo richiede.

---

## La Wiki incrementale

La Wiki è l'unico stato persistente. È Markdown puro: leggibile da un umano,
modificabile dal modello, verificabile senza database.

| Pagina | Scopo |
|---|---|
| `wiki/INDEX.md` | mappa del lavoro: fase, copertura, gap, prossima azione |
| `wiki/contesto-ente.md` | ente, giurisdizione, mandato, framework, governance |
| `wiki/rischi-controlli.md` | rischi `R-###`, controlli `C-###`, matrice |
| `wiki/mappa-documentale.md` | fonti `D-###` e fatti estratti |
| `wiki/richieste-documenti.md` | richieste documenti e impatto dei gap |
| `wiki/piano-revisione.md` | perimetro, materialità, tempi, campioni |
| `wiki/anomalie-findings.md` | findings `F-###` con evidenza e risposta |
| `wiki/carte-lavoro/CL-*.md` | carte di lavoro con sign-off |
| `wiki/registro-attivita.md` | audit trail append-only |

Protocollo di aggiornamento:

```
Estrai → verifica sulla fonte → sintetizza → aggancia
→ aggiorna la pagina → appendi al registro → aggiorna INDEX
```

Niente viene cancellato. Le correzioni sono nuove voci datate con `supersede`.
Ogni affermazione ha fonte e pagina. I conflitti si aprono esplicitamente, mai
si risolvono in silenzio.

---

## Output

| Formato | Uso |
|---|---|
| **Markdown** | Wiki, carte di lavoro, narrativa della relazione |
| **CSV** | riconciliazioni, campioni, tabelle (UTF-8, RFC 4180) |
| **HTML** | self-contained, `@media print`, zero asset esterni |

Template:

- [`templates/output/carta-lavoro.html`](templates/output/carta-lavoro.html)
- [`templates/output/relazione-finale.html`](templates/output/relazione-finale.html)
- [`templates/output/checklist-chiusura.md`](templates/output/checklist-chiusura.md)

Stampa: apri l'HTML in un browser → `Ctrl/Cmd + P` → salva come PDF. Nessun
LibreOffice, nessun Word, nessun componente aggiuntivo.

Francesco non produce DOCX/XLSX come formato primario. Se richiesto, spiega il
compromesso e offre Markdown + HTML stampabile, oppure CSV da importare.

---

## Perché zero dipendenze

| Approccio legacy | Francesco 2.0 |
|---|---|
| pipeline OCR / MCP docling | vision nativa di Claude, Gemini, GPT |
| librerie per generare DOCX/XLSX | Markdown, CSV, HTML self-contained |
| setup Python + uv + MCP | nessuno |
| struttura `Revisione/` obbligatoria | scoperta autonoma dei documenti |
| routing per parole chiave | interpretazione dell'intento + macchina a stati |
| archivio normativo locale | fonti citate dentro la Wiki |

Così la skill è usabile da revisori non tecnici ed è portabile tra cloud e
agenti locali.

---

## Riferimento CLI

```
npx francesco-audit init [dir] [--entity NOME] [--period 2025] [--state wiki] [--force]
npx francesco-audit bundle [--compact] [--out FILE]
npx francesco-audit install [--agent opencode|claude-code|cursor] [--target DIR]
npx francesco-audit doctor
npx francesco-audit info
```

- `init` non sovrascrive pagine Wiki esistenti senza `--force`.
- `bundle` è deterministico: stesse fonti, stesso file.
- `install` copia `SKILL.md`, `core/`, `templates/` e il manifest.
- `doctor` verifica file richiesti, frontmatter, zero dipendenze, CSS di stampa,
  assenza di asset esterni e aggiornamento dei bundle.

---

## Compatibilità

| Ambiente | Modalità |
|---|---|
| OpenCode | CLI + filesystem |
| Claude Code | CLI + filesystem |
| Cursor | CLI + filesystem |
| Claude Web / Projects / Skills | bundle cloud |
| ChatGPT Projects | bundle cloud |
| Gemini Gems | bundle cloud |

Per il cloud serve la vision per leggere le scansioni. Se il modello non ce
l'ha, incolla il testo o fornisci un PDF testuale.

---

## Metadati per i registry

- [`SKILL.md`](SKILL.md) usa il frontmatter standard (`name`, `description`,
  `license`, `version`, `compatibility`, `metadata`).
- [`skill.json`](skill.json) è il manifest leggibile dalle macchine per i
  portali di skill: capacità, output, compatibilità, distribuzione e
  dichiarazione delle dipendenze.
- Topic GitHub suggeriti (presenti anche in `skill.json`): `audit`,
  `revisione-legale`, `accounting`, `commercialista`, `revisore`,
  `agent-skill`, `ai-skill`, `markdown`, `zero-dependency`, `npx`.
- Il pacchetto è pubblicabile come `francesco-audit` con `npm publish`; nessun
  build step e nessuna dipendenza runtime.

---

## Struttura del repository

```
SKILL.md                     entry point universale
skill.json                   manifest per i registry
package.json                 pacchetto npx zero-dependency
bin/francesco.mjs            CLI: init | bundle | install | doctor | info
core/                        undici moduli operativi
templates/wiki/              template della Wiki incrementale
templates/output/            HTML stampabile + checklist
bundle/                      bundle cloud committati
test/                        smoke test zero-dependency
AUDIT.md                     audit di migrazione (cosa rimosso e perché)
characters/francesco.svg     la faccia
```

---

## Sviluppo

```bash
npm test
node bin/francesco.mjs doctor
npm run bundle          # rigenera i bundle committati
```

La suite usa solo `node:test`. Nessuna dev dependency.

### Aggiungere un modulo

1. Crea `core/NN-nome.md` con scope e gate chiari.
2. Referenzialo in `SKILL.md` §5 e nell'indice del bundle.
3. Esegui `npm run bundle` e `npm test`.

### Aggiungere un template

1. Aggiungi il file sotto `templates/wiki/` o `templates/output/`.
2. Mantieni la sintassi `{{PLACEHOLDER}}`.
3. L'HTML deve restare self-contained e includere `@media print`.
4. Rigenera i bundle.

---

## Migrazione

Il repository è stato rifattorizzato da una struttura multi-skill, dipendente da
OCR e da DOCX/XLSX. [`AUDIT.md`](AUDIT.md) elenca ogni file rimosso e il suo
sostituto. La cronologia Git conserva la versione precedente.

---

## Licenza

[MIT](LICENSE)

---

Costruito per revisori, commercialisti e per chi ricontrolla il proprio triplo
controllo.
