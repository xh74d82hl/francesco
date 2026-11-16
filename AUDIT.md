# AUDIT — Refactoring Francesco 2.0

Data: 2026-11-16
Stato: completato (Fase 1 → 3)

Questo documento è la traccia verificabile del refactoring. Elenca cosa è stato
rimosso, cosa è stato convertito e perché. Il repository non contiene più il
layer legacy descritto sotto. Dopo il commit, la verifica si fa con
`git show <commit>^:<file>` oppure con `git log --diff-filter=D --name-only`.

---

## 1. Fotografia del repository precedente

| Area | File | Problema |
|---|---|---|
| Orchestrazione | `SKILL.md` | Routing a tabella su 10 comandi, preflight legato a `Revisione/`, frustrazione con regex, riferimenti a `~/.francesco-setup` |
| Comandi | `commands/*.md` (10 file) | Percorsi fissi (`Revisione/`, `Bilanci/`, `Documenti acquisiti/`), convenzioni di naming obbligatorie, output DOCX/XLSX |
| Sub-skill | `skills/francesco-revisione`, `-bilancio`, `-estratto` | Duplicazione di regole, tre `SKILL.md` da tenere allineati, caricano `commands/` |
| OCR | `scripts/docling-server.py` | Dipendenza da Python, `uv`, `docling`, MCP server, cache `.docling.md` |
| Office | riferimenti a skill `docx` / `xlsx` | Dipendenza da librerie e da harness specifici; non portable su cloud |
| Installer | `install.sh`, `install.ps1` | Solo CLI, nessun bundle cloud, nessun `npx` |
| Direzione | `DIRECTION.md` | Descriveva l'architettura legacy |
| Archivio normativo | `normative/` | Cartella locale cablata, gitignorata, non portabile |
| Struttura | `commands/struttura.md` | Template cartelle obbligatorio + validazione che blocca il lavoro |

Conteggio pre-refactoring: 15 file Markdown di istruzioni (10 comandi, 3
sub-skill, 1 orchestratore, 1 direzione), 3 entry point skill, 1 server MCP,
2 installer.

---

## 2. Decisioni di migrazione

| Legacy | Azione | Sostituto |
|---|---|---|
| `commands/revisione.md` | Rimosso | `core/02-onboarding-incarico.md`, `core/04-verifiche-periodiche.md`, `core/05-carte-lavoro.md`, `core/07-relazione-finale.md` |
| `commands/inizializza.md` | Rimosso | `core/02-onboarding-incarico.md` + `templates/wiki/contesto-ente.md` |
| `commands/struttura.md` | Rimosso | Nessuna struttura obbligatoria; mappa documentale in `templates/wiki/mappa-documentale.md` |
| `commands/check.md`, `triage.md`, `riepilogo.md` | Rimossi | `core/05-carte-lavoro.md`, `core/06-controlli-sostanza.md`, `core/07-relazione-finale.md` |
| `commands/bilancio_check.md` | Convertito | `core/06-controlli-sostanza.md` + `templates/wiki/carte-lavoro/bilancio.md` |
| `commands/estratto_check.md` | Convertito | `core/06-controlli-sostanza.md` + `templates/wiki/carte-lavoro/banche.md` |
| `commands/normativa.md` | Convertito | `core/10-principi-e-normativa.md` (fonti citate nella Wiki, nessun archivio cablato) |
| `commands/setup.md` | Rimosso | Nessun setup: zero dipendenze. `npx francesco-audit doctor` verifica solo l'integrità del pacchetto |
| `skills/francesco-*` (3) | Rimossi | Un solo `SKILL.md` + moduli `core/` caricati on demand |
| `scripts/docling-server.py` | Rimosso | Vision/multimodal nativo dei modelli (Claude, Gemini, GPT) |
| skill `docx` / `xlsx` | Rimossi | Markdown, CSV, HTML self-contained con CSS `@media print` |
| `install.sh` / `install.ps1` | Rimossi | `bin/francesco.mjs` via `npx francesco-audit` |
| `DIRECTION.md` | Riscritto | Direzione prodotto 2.0, senza riferimenti legacy |
| `normative/` | Rimosso dal repo | Conoscenza normativa dentro la Wiki, citata con fonte e data |

Nessun file di dominio (contratti, bilanci, dati cliente) era presente nel
repository: la rimozione riguarda solo istruzioni, script e installer.

---

## 3. Nuova archiviazione

```
SKILL.md                     entry point universale (frontmatter standard)
skill.json                   manifest per registry / portali
package.json                 pacchetto npx zero-dependency
bin/francesco.mjs            CLI: init | bundle | install | doctor | info
core/                        moduli di lavoro caricati on demand
templates/wiki/              pagine Wiki incrementale (stato del lavoro)
templates/output/            HTML self-contained + checklist Markdown
bundle/CLOUD-BUNDLE.md       bundle unico per Claude / Gemini / ChatGPT
test/                        smoke test zero-dependency (node:test)
```

La Wiki è l'unico stato persistente. Non esiste una cartella di input
obbligatoria: l'agente scopre i documenti da allegati, glob, ricerca semantica
o file locali e costruisce la mappa documentale da ciò che trova.

---

## 4. Verifica dei pilastri

| Pilastro | Evidenza nel repo |
|---|---|
| Astrazione filesystem | `SKILL.md` §Ingestione; `core/01-ingestione.md`; nessun path obbligatorio in `templates/` |
| Wiki incrementale | `core/00-motore-wiki.md`; `templates/wiki/*`; ID `R-`, `C-`, `F-`, `CL-`, `D-`; log append-only |
| Zero dipendenze / VL | `package.json` senza `dependencies`; nessun OCR/DOCX/XLSX; `core/08-output-universali.md` |
| UX non tecnica | `core/09-guida-utente.md`; gate di conferma; banner di avanzamento |
| Portabilità cloud | `bundle/CLOUD-BUNDLE.md` + `bundle/CLOUD-BUNDLE.compact.md`; `npx ... bundle` |
| Distribuzione npx | `bin/francesco.mjs`; `init`, `bundle`, `install`, `doctor`; `test/` |

Comandi di verifica eseguiti:

```bash
npm test
node bin/francesco.mjs doctor
node bin/francesco.mjs bundle --out bundle/CLOUD-BUNDLE.md
node bin/francesco.mjs bundle --compact --out bundle/CLOUD-BUNDLE.compact.md
```
