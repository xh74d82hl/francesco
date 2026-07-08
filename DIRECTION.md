# DIRECTION — Skill Francesco

Salvato il 2026-07-08 durante sessione di refactoring.

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
  characters/
    francesco.svg         — avatar / logo
  commands/
    revisione.md          — gestione documenti revisione (ex skill revisione)
    check.md              — validazione, controllo documenti
    normativa.md          — consultazione archivio normativo
  normative/              — database normativo di riferimento
  scripts/                — utility script
```

Ogni sub-comando ha:
- `name`: nome del comando
- `description`: cosa fa
- `when_to_call`: quando usarlo
- `outcome_contract`: cosa produce

## Origine dei sub-comandi

| Sub-comando | Ereditato da | Stato |
|-------------|--------------|-------|
| `revisione` | skill `revisione` (precedente) | Da migrare |
| `check` | nuovo | Da creare |
| `normativa` | nuovo (parte dall'archivio normativo) | Da creare |

## Personaggio

SVG: ragazzo sulla 35ina, occhialetti tondi, capelli un po' spettinati, cravatta storta, taschino con penne, calcolatrice gigante in mano, espressione seria-concentrata ma con un sorrisetto.
Colori: blu scuro, verde acido, carta da pacchi.

## README stile Ralph

Il README del git repo deve copiare lo stile di Ralph:
- Divertente ma professionale
- Tagline ironica
- Sezioni chiare con emoji
- "Outcome Contract"
- Esempi d'uso
- Sembra scritto da un umano, non da un template

## Prossimi passi

- Completare migrazione da `revisione` a `francesco`
- Creare sub-comando `check`
- Creare sub-comando `normativa`
- Aggiungere `/francesco` command
- Mantenere backward compatibility con `/revisione`
