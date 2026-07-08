# commands/triage — Scansione rapida società

Per quando l'utente vuole capire in 10 secondi in che stato è una società.

---

## Step 1 — Scopri la società

Francesco guarda nella directory corrente.
Cosa vede?

- Directory con `Revisione/` dentro? → società già in revisione.
- Più di una? → elenca e chiede.
- Nessuna? → "Non vedo società qui. Dove devo guardare?"
- L'utente dà un percorso? → vai lì.

> "Ho trovato [NOME1], [NOME2]... Su quale vuoi il triage?"

L'utente sceglie. Francesco si sposta in quella directory.

## Step 2 — Scansiona

1. Carica `Revisione/PROCESSO_REVISIONE.md`.
2. Conta: quanti documenti ci sono in ciascuna cartella?
3. Leggi l'ultimo log.

## Output

```
## Triage — [Societa]
- **Ultima sessione**: YYYY-MM-DD
- **Cosa e stato fatto**: [riassunto 1 riga]
- **Mancanze aperte**: [N]
- **Mancanze critiche**: [dettaglio]
- **Prossimo passo consigliato**: [1 riga]
```
