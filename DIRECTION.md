# DIRECTION — Skill Francesco

Salvato il 2026-07-08 durante sessione di refactoring.
Ultimo aggiornamento: 2026-07-08 — struttura multi-skill, root orchestratore, commands/ condivisi.

## Concept

**Francesco** non e l'intern. E l'uomo sulla 35ina, un po' stupido ma diligente, quello che assumi per fare le cose bene, attentamente, senza fare domande inutili. Ricontrolla le cose 50 volte. Ti fa domande SOLO se non ha capito. E il revisore/accountant stereotipo.

## Tono

- Professionale ma con personalita
- Un po' simpatico, un po' nerd
- Preciso fino all'ossessivo
- Non fa mai domande stupide — solo quelle necessarie
- "Fidati, ce l'ho fatta 50 volte di fila"

## Struttura multi-skill

Francesco e una famiglia di skill, ognuna col suo SKILL.md.
La root SKILL.md e l'orchestratore (regole condivise + menu).
commands/ e una libreria riutilizzabile da tutte le skill.

```
francesco/
  SKILL.md                — orchestratore (regole condivise + menu)
  DIRECTION.md            — questo file
  README.md               — inglese
  README.it.md            — italiano
  install.sh              — auto-detect installer
  install.ps1             — Windows installer
  characters/
    francesco.svg         — avatar / logo
  commands/               — istruzioni condivise
    revisione.md          — esecuzione sessione revisione
    check.md              — validazione documenti
    normativa.md          — preflight + archivio normativo
    triage.md             — scansione rapida
    inizializza.md        — commissionamento nuova societa
  skills/                 — skill specializzate
    francesco-revisione/   — workflow revisione (attivo)
    francesco-bilancio/    — controlli bilancio (scheletro)
    francesco-estratto/    — check estratti conto (scheletro)
  normative/              — archivio personale (gitignorato)
  scripts/                — utility locali
```

## Stato sub-comandi

| Sub-comando | Stato |
|-------------|-------|
| `revisione` | Completato |
| `check` | Completato |
| `normativa` | Completato (con preflight + auto-update) |
| `triage` | Completato |
| `inizializza` | Completato |

## Auto-update normativa (FLAGSHIP)

Francesco non usa un database normativo centralizzato. Ogni volta che lavora su una societa:
1. Rileva la giurisdizione dai documenti
2. Controlla il suo `normative/` personale per paese + tipo + settore
3. Se manca, cerca online sulle fonti ufficiali del paese (es. Normattiva per IT, Bundesanzeiger per DE, Légifrance per FR, SEC per US)
4. Salva solo quello che serve
5. Funziona offline dopo il primo download

Questo e il cuore della skill. Tutto il resto e corollario.

## Installazione

Installer pubblico:
1. Rileva harness installati
2. Se uno solo, usa quello
3. Se piu di uno, chiede o richiede `--agent`
4. Chiama `npx skills add <source> --global --skill francesco --agent <agent>`

Non usare installazione globale bare come default, perche puo creare cartelle/symlink per troppi agenti.

`--dev-copy` resta solo per test locale e non deve cancellare `normative/` o `scripts/`.

## Personaggio

SVG: ragazzo sulla 35ina, occhialetti tondi, capelli un po' spettinati, cravatta storta, taschino con penne, calcolatrice gigante in mano, espressione seria-concentrata ma con un sorrisetto.
Colori: blu scuro, verde acido, carta da pacchi.

## README stile Ralph

Fatto. Il README ha tagline ironica, sezioni chiare, spiega l'archivio personale in modo semplice, sembra scritto da un umano.

## Prossimi passi

- Vendere su skills.sh
- Raccogliere feedback da utenti reali
- Aggiungere backward compatibility con eventuale skill `revisione` se esiste
- `commands/setup.md` — setup dipendenze da testare su macchina pulita
- `commands/riepilogo.md` — report DOCX da testare
- `scripts/docling-server.py` — MCP server embedded
- Eventuali altri sub-comandi su richiesta
