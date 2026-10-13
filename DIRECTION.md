# DIRECTION — Skill Francesco

Salvato il 2026-07-08 durante sessione di refactoring.
Ultimo aggiornamento: 2026-10-13 — layout Agent Skills standard (`skills/<nome>/`), rimossi docling/MCP/setup.

## Concept

**Francesco** non e l'intern. E l'uomo sulla 35ina, un po' stupido ma diligente, quello che assumi per fare le cose bene, attentamente, senza fare domande inutili. Ricontrolla le cose 50 volte. Ti fa domande SOLO se non ha capito. E il revisore/accountant stereotipo.

## Tono

- Professionale ma con personalita
- Un po' simpatico, un po' nerd
- Preciso fino all'ossessivo
- Non fa mai domande stupide — solo quelle necessarie
- "Fidati, ce l'ho fatta 50 volte di fila"

## Struttura multi-skill

Francesco e una famiglia di skill in formato Agent Skills, ognuna col suo SKILL.md.
`skills/francesco/` e l'orchestratore (regole condivise + menu) e contiene in
`references/` i flussi dettagliati, riusati dalle skill sorelle.

Zero dipendenze: niente docling, niente MCP, niente plugin. I documenti scansionati
li legge direttamente il modello.

```
francesco/
  skills/
    francesco/              — orchestratore
      SKILL.md
      references/           — struttura, revisione, check, bilancio_check,
                              estratto_check, normativa, triage, inizializza, riepilogo
    francesco-revisione/    — workflow revisione
    francesco-bilancio/     — controlli bilancio
    francesco-estratto/     — riconciliazione bancaria
  install.sh / install.ps1  — installer senza dipendenze
  README.md / README.it.md
  DIRECTION.md              — questo file
  characters/francesco.svg  — avatar / logo
```

## Stato sub-comandi

| Sub-comando | Stato |
|-------------|-------|
| `revisione` | Completato |
| `check` | Completato |
| `normativa` | Completato (con preflight + auto-update) |
| `triage` | Completato |
| `inizializza` | Completato |
| `bilancio_check` | Completato (quadratura + scelte contabili + Benford/pattern) |
| `estratto_check` | Completato (riconciliazione bancaria) |

## Auto-update normativa (FLAGSHIP)

Francesco non usa un database normativo centralizzato. Ogni volta che lavora su una societa:
1. Rileva la giurisdizione dai documenti
2. Controlla il suo `normative/` personale per paese + tipo + settore
3. Se manca, cerca online sulle fonti ufficiali del paese (es. Normattiva per IT, Bundesanzeiger per DE, Légifrance per FR, SEC per US)
4. Salva solo quello che serve
5. Funziona offline dopo il primo download

Questo e il cuore della skill. Tutto il resto e corollario.

## Installazione

Installer pubblico (`install.sh`, `install.ps1`):
1. Rileva gli agenti installati (`~/.claude`, `~/.config/opencode`; altrimenti `~/.agents/skills`)
2. Se uno solo, usa quello
3. Se piu di uno, chiede o richiede `--agent` / `--dir`
4. Scarica il repo e copia `skills/*` nella cartella skills scelta

Non installare ovunque come default. Servono solo bash/curl/tar (o PowerShell).

Alternative: `npx skills add xh74d82hl/francesco`, oppure zip di `skills/francesco` caricato nell'app Claude.

## Personaggio

SVG: ragazzo sulla 35ina, occhialetti tondi, capelli un po' spettinati, cravatta storta, taschino con penne, calcolatrice gigante in mano, espressione seria-concentrata ma con un sorrisetto.
Colori: blu scuro, verde acido, carta da pacchi.

## README stile Ralph

Fatto. Il README ha tagline ironica, sezioni chiare, spiega l'archivio personale in modo semplice, sembra scritto da un umano.

## Prossimi passi

- Vendere su skills.sh
- Raccogliere feedback da utenti reali
- Aggiungere backward compatibility con eventuale skill `revisione` se esiste
- `references/riepilogo.md` — report DOCX da testare
- Pubblicare `francesco.zip` come asset di release per l'upload nell'app Claude
- Eventuali altri sub-comandi su richiesta
