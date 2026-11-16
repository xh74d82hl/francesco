# Francesco 2.0

<p align="center">
  <i>🇮🇹 <a href="README.it.md">Preferisci l'italiano? Leggi il README italiano.</a></i>
</p>

<p align="center">
  <img src="characters/francesco.svg" width="100%" alt="Francesco — il revisore contabile">
</p>

> **35 years old. Round glasses. Distant stare. Maniacal precision.**
>
> Francesco is not a genius. He doesn't try to be. He is the senior audit
> manager you want when the numbers must tie out — and when someone has to
> explain, in plain language, what is still missing.

Francesco 2.0 is an **AI-first legal audit skill** covering the full engagement:
onboarding, risk assessment, periodic verifications, working papers,
substantive testing, findings and the final report.

It is **zero-dependency**. No OCR, no docling, no LibreOffice, no DOCX/XLSX
libraries. It reads PDFs and scans with the model's native vision, keeps its
memory in an incremental Markdown wiki, and produces Markdown, CSV and
self-contained HTML ready for browser printing.

## What's new in 2.0

- **One universal skill** instead of an orchestrator plus three sub-skills.
- **Incremental Markdown wiki** as the only state, with source-linked IDs and
  an append-only audit trail.
- **No fixed input folders**: the agent discovers documents and builds its own
  map. No `Revisione/`, no naming obligations.
- **No OCR/Office dependencies**: native multimodal reading; Markdown, CSV and
  printable HTML output.
- **Guided UX**: phase banner, plain-language document requests, confirmation
  gates before closing working papers and the report.
- **Cloud + CLI distribution**: `npx francesco-audit` and a single-file bundle
  for Claude Projects, ChatGPT Projects and Gemini Gems.

---

## Quick start

### 1. Agentic CLI / IDE (OpenCode, Claude Code, Cursor)

```bash
# initialize a working wiki in the current directory
npx francesco-audit init . --entity "Casa di Riposo Esempio" --period 2025

# install the skill into your agent
npx francesco-audit install --agent opencode
# or: --agent claude-code / --agent cursor / --target <dir>

# check package integrity
npx francesco-audit doctor
```

`init` creates only what the skill needs:

```
wiki/                 # the incremental state (templates pre-filled)
output/               # deliverables (Markdown, CSV, HTML)
.francesco/skill/     # SKILL.md + core/ + templates/, read by the agent
.francesco/config.json
```

There is **no required input folder**. Put documents wherever you want, attach
them in chat, or point the agent at a directory. Francesco discovers them and
builds the document map.

Then tell the agent:

> "Use the skill in `.francesco/skill` and read `wiki/INDEX.md`. We need to
> audit the 2025 financial statements."

### 2. Cloud (Claude Projects/Skills, ChatGPT Projects, Gemini Gems)

```bash
npx francesco-audit bundle --out francesco-cloud.md
# smaller context:
npx francesco-audit bundle --compact --out francesco-cloud-compact.md
```

Upload the bundle as project instructions / custom skill / gem knowledge, then
write:

> "Francesco, we need to audit Entity X for 2025. Here are the documents."

The bundle is a single file with the skill, all core modules and all templates.
It requires no filesystem. Keep the wiki in a `WIKI` section of the
conversation; at the end, export it as Markdown.

Ready-made bundles are committed:

- [`bundle/CLOUD-BUNDLE.md`](bundle/CLOUD-BUNDLE.md) — full
- [`bundle/CLOUD-BUNDLE.compact.md`](bundle/CLOUD-BUNDLE.compact.md) — smaller

---

## How it works

Francesco runs a state machine, not a keyword router. Every session resumes
from the wiki and shows a progress banner:

```
[Francesco · Fase 3/8 · Evidenze]
Fatto: read 2025 financial statements (D-003) and BPER statement (D-011)
Ora: updating the document map
Mi serve: notes to the financial statements (a scan is fine)
Prossimo: balance sheet tie-out
```

| Phase | What happens | Output |
|---|---|---|
| 0 | Intake: entity, period, goal, available docs | scope summary |
| 1 | Engagement: profile, mandate, independence, materiality | `contesto-ente`, `piano-revisione` |
| 2 | Risks: cycles, assertions, fraud, controls, responses | `rischi-controlli` |
| 3 | Evidence: read sources, extract facts, map documents | `mappa-documentale` |
| 4 | Working papers: procedures, samples, results, conclusions | `wiki/carte-lavoro/CL-*` |
| 5 | Substance: tie-outs, reconciliations, analytics, Benford | `CL-*` + CSV |
| 6 | Findings: severity, evidence, management response | `anomalie-findings` |
| 7 | Report: opinion, KAM, going concern, signature | Markdown + HTML |
| 8 | Closure: snapshot, index, archive, next action | audit trail |

The full cycle is described in [`SKILL.md`](SKILL.md) and the eleven modules in
[`core/`](core/). The agent loads a module only when the phase requires it.

---

## The incremental wiki

The wiki is the only persistent state. It is plain Markdown: readable by a
human, editable by the model, verifiable without a database.

| Page | Purpose |
|---|---|
| `wiki/INDEX.md` | work map: phase, coverage, gaps, next action |
| `wiki/contesto-ente.md` | entity, jurisdiction, mandate, framework, governance |
| `wiki/rischi-controlli.md` | risks `R-###`, controls `C-###`, matrix |
| `wiki/mappa-documentale.md` | sources `D-###` and extracted facts |
| `wiki/richieste-documenti.md` | document requests and impact of gaps |
| `wiki/piano-revisione.md` | scope, materiality, timeline, samples |
| `wiki/anomalie-findings.md` | findings `F-###` with evidence and response |
| `wiki/carte-lavoro/CL-*.md` | working papers with sign-off |
| `wiki/registro-attivita.md` | append-only audit trail |

Update protocol:

```
Extract → verify against source → synthesize → cross-reference
→ update page → append to activity log → update INDEX
```

Nothing is deleted. Corrections are new dated entries with `supersede`. Every
claim carries a source and a page. Conflicts are opened explicitly, never
silently resolved.

---

## Outputs

| Format | Use |
|---|---|
| **Markdown** | wiki, working papers, report narrative |
| **CSV** | reconciliations, samples, tables (UTF-8, RFC 4180) |
| **HTML** | self-contained, `@media print`, no external assets |

Templates:

- [`templates/output/carta-lavoro.html`](templates/output/carta-lavoro.html)
- [`templates/output/relazione-finale.html`](templates/output/relazione-finale.html)
- [`templates/output/checklist-chiusura.md`](templates/output/checklist-chiusura.md)

Printing: open the HTML in any browser → `Ctrl/Cmd + P` → save as PDF. No
LibreOffice, no Word, no add-ons.

Francesco does not produce DOCX/XLSX as a primary format. If asked, it explains
the trade-off and offers Markdown + printable HTML, or CSV for spreadsheet
import.

---

## Why zero dependencies

| Legacy approach | Francesco 2.0 |
|---|---|
| OCR pipeline / docling MCP | native vision of Claude, Gemini, GPT |
| DOCX/XLSX generation libraries | Markdown, CSV, self-contained HTML |
| Python + uv + MCP setup | none |
| Fixed `Revisione/` folder tree | autonomous document discovery |
| Keyword routing table | intent interpretation + phase state machine |
| Local normative database | cited sources inside the wiki |

This makes the skill usable by non-technical auditors and portable across
cloud and local agents.

---

## CLI reference

```
npx francesco-audit init [dir] [--entity NAME] [--period 2025] [--state wiki] [--force]
npx francesco-audit bundle [--compact] [--out FILE]
npx francesco-audit install [--agent opencode|claude-code|cursor] [--target DIR]
npx francesco-audit doctor
npx francesco-audit info
```

- `init` never overwrites existing wiki pages unless `--force`.
- `bundle` is deterministic: the same sources produce the same file.
- `install` copies `SKILL.md`, `core/`, `templates/` and the manifest.
- `doctor` validates required files, frontmatter, zero dependencies, print CSS,
  absence of external assets and bundle freshness.

---

## Compatibility

| Environment | Mode |
|---|---|
| OpenCode | CLI + filesystem |
| Claude Code | CLI + filesystem |
| Cursor | CLI + filesystem |
| Claude Web / Projects / Skills | cloud bundle |
| ChatGPT Projects | cloud bundle |
| Gemini Gems | cloud bundle |

For cloud use, the model needs vision to read scans. If it does not have
vision, paste the text or provide a text-based PDF.

---

## Registry metadata

- [`SKILL.md`](SKILL.md) uses standard skill frontmatter (`name`,
  `description`, `license`, `version`, `compatibility`, `metadata`).
- [`skill.json`](skill.json) is the machine-readable manifest for skill
  portals: capabilities, outputs, compatibility, distribution and dependency
  declarations.
- Suggested GitHub topics (also listed in `skill.json`): `audit`,
  `revisione-legale`, `accounting`, `commercialista`, `revisore`,
  `agent-skill`, `ai-skill`, `markdown`, `zero-dependency`, `npx`.
- The package is publishable as `francesco-audit` with `npm publish`; no build
  step and no runtime dependencies.

---

## Repository structure

```
SKILL.md                     universal entry point
skill.json                   registry manifest
package.json                 zero-dependency npx package
bin/francesco.mjs            CLI: init | bundle | install | doctor | info
core/                        eleven operational modules
templates/wiki/              incremental wiki templates
templates/output/            printable HTML + checklist
bundle/                      committed cloud bundles
test/                        zero-dependency smoke tests
AUDIT.md                     migration audit (what was removed and why)
characters/francesco.svg     the face
```

---

## Development

```bash
npm test
node bin/francesco.mjs doctor
npm run bundle          # regenerate committed bundles
```

The test suite uses `node:test` only. No dev dependencies.

### Adding a module

1. Add `core/NN-name.md` with a clear scope and gate.
2. Reference it in `SKILL.md` §5 and in the bundle index.
3. Run `npm run bundle` and `npm test`.

### Adding a template

1. Add the file under `templates/wiki/` or `templates/output/`.
2. Keep `{{PLACEHOLDER}}` syntax.
3. HTML must stay self-contained and include `@media print`.
4. Regenerate bundles.

---

## Migration

This repository was refactored from a multi-skill, OCR-dependent, DOCX/XLSX
setup. [`AUDIT.md`](AUDIT.md) lists every removed file and its replacement.
Git history preserves the old version.

---

## License

[MIT](LICENSE)

---

Built for auditors, accountants, and everyone who triple-checks their triple
check.
