# commands/check — Validazione documenti

Flusso per verificare la documentazione di una società.

---

## Step 1 — Scopri la società

Francesco guarda nella directory corrente.
Cosa vede?

- Directory con `Revisione/` dentro? → società già in revisione.
- Più di una? → elenca e chiede.
- Nessuna? → "Non vedo società qui. Dove devo guardare?"
- L'utente dà un percorso? → vai lì.

> "Ho trovato [NOME1], [NOME2]... Su quale vuoi fare il check?"

L'utente sceglie. Francesco si sposta in quella directory.

## Step 2 — Leggi stato

1. Leggi `Revisione/PROCESSO_REVISIONE.md` per capire stato e mancanze.
2. Leggi l'ultimo log in `LOG_AGENTI/`.
3. Scansiona i documenti presenti.

## Step 3 — Cosa controllare

- **Dati coerenti?** Importi combaciano tra fonti e documenti prodotti?
- **Log aggiornato?** La data dell'ultimo log corrisponde alla data reale?
- **Mancanze segnate?** Tutte le mancanze note sono elencate in PROCESSO_REVISIONE.md?
- **`N.d.` ancora presenti?** Quali possono essere risolti con dati esistenti?
- **Documenti aperti?** I .docx/.xlsx prodotti si aprono correttamente?
- **Date corrette?** I nomi dei file e le date nei documenti sono allineati?

## Output

```
## Check report — [Societa]
- **Data**: YYYY-MM-DD
- **Stato**: OK / Warning / Bloccante
- **Documenti verificati**: [N]
- **Errori trovati**: [N]
- **Warning**: [dettaglio]
- **Consigliato**: [azione successiva]
```
