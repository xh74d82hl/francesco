# DIRECTION — Skill Francesco

Salvato il 2026-07-08 durante sessione di refactoring.
Ultimo aggiornamento: 2026-07-08 — split commands/ completato, installer selettivo, README Ralph.

## Concept

**Francesco** non e l'intern. E l'uomo sulla 35ina, un po' stupido ma diligente, quello che assumi per fare le cose bene, attentamente, senza fare domande inutili. Ricontrolla le cose 50 volte. Ti fa domande SOLO se non ha capito. E il revisore/accountant stereotipo.

## Tono

- Professionale ma con personalita
- Un po' simpatico, un po' nerd
- Preciso fino all'ossessivo
- Non fa mai domande stupide — solo quelle necessarie
- "Fidati, ce l'ho fatta 50 volte di fila"

## Struttura skill (container di sub-comandi)

Francesco e un container. Ogni sub-comando e un file in `commands/`:

```
francesco/
  SKILL.md                — entry point con routing
  DIRECTION.md            — questo file
  README.md               — marketing in stile Ralph
  install.sh              — auto-detect installer
  characters/
    francesco.svg         — avatar / logo
  commands/
    revisione.md          — revisione contabile completa
    check.md              — validazione documenti
    normativa.md          — consultazione + auto-aggiornamento archivio
    triage.md             — scansione rapida societa
    inizializza.md        — setup nuova societa
  normative/              — archivio personale (gitignorato, costruito dall'agente)
  scripts/                — utility script locali
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
1. Controlla il suo `normative/` personale
2. Se manca normativa per quel tipo/settore, cerca online (Normattiva, Gazzetta Ufficiale, CNDCEC)
3. Salva solo quello che serve
4. Funziona offline dopo il primo download

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
- Eventuali altri sub-comandi su richiesta
