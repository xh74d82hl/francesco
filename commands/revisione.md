# commands/revisione — Revisione contabile completa

Flusso standard per revisione contabile su una societa.

Durante analisi, OCR, lettura fonti, controllo importi e ricerca normativa usa stile interno compresso tipo `caveman ultra`. Domande all'utente, documenti formali, log ufficiali e riepilogo finale restano leggibili.

---

## Fase 1 — Identificazione

1. Identificare societa target.
2. Estrarre contesto (vedi sez. Context Extraction sotto).
3. Determinare tipo societario (ASP/SPA/SRL/sportiva/cooperativa).
4. Determinare tipo di mandato (revisore legale / sindaco unico / collegio sindacale).
5. Determinare settore e adempimenti extra.

## Fase 2 — Pianificazione

6. Cosa serve fare oggi? (creare verbali? aggiornare calendario? OCR? check?)
7. Cosa NON fare? (non toccare documenti firmati, non modificare modelli originali)
8. Quanto tempo / quante iterazioni servono?

## Fase 3 — Esecuzione

9. OCR su PDF scansionati -> MCP `docling.convert_to_markdown`.
10. DOCX -> skill `docx`.
11. XLSX -> skill `xlsx` (preservare schema).
12. Mai inventare dati. Non certi -> `N.d.`.

## Fase 4 — Triplo Check

Vedi sez. Triplo Check sotto.

## Fase 5 — Chiusura

13. Scrivere log in `LOG_AGENTI/`.
14. Aggiornare `Revisione/PROCESSO_REVISIONE.md`.
15. Validare apertura documenti prodotti.

---

## Context Extraction

### Cosa cercare nei documenti

| Documento | Cosa ricavare |
|-----------|---------------|
| `AGENTS.md` | Regole specifiche per questa societa |
| `Revisione/PROCESSO_REVISIONE.md` | Stato attuale, mancanze, log collegati |
| Ultimo log in `LOG_AGENTI/` | Cosa e stato fatto nell'ultima sessione |
| Verbali esistenti (.doc/.docx) | Tipo documento, composizione collegio, pattern |
| `Date *.xlsx` | Calendario verifiche |
| Bilanci / Visure | Tipo societario, dati dimensionali, ATECO |

### Output dell'estrazione

- **Societa**: NOME, tipo (ASP/SPA/SRL/etc.), settore ATECO
- **Mandato**: revisore legale / sindaco unico / collegio sindacale
- **Stato**: cosa c'e / cosa manca / cosa e da verificare
- **Modelli**: quali file usare come template
- **Sicurezza**: quanto e sicuro dell'identificazione (100%? best guess?)

Se non e sicuro al 100%: "Tipo non documentato. Ipotesi: [TIPO] per [motivo]. Da verificare su visura/statuto."

---

## Triplo Check

### 1° giro — Esecuzione

Fai il lavoro. Documenti, log, stato. Tutto senza fretta.

### 2° giro — Verifica

Rileggi tutto. Controlla:
- `N.d.` che potrebbero essere dati certi da qualche altra parte?
- Date coerenti?
- Nomi scritti giusti?
- Importi combaciano con le fonti?
- Riferimenti incrociati tornano?

Se trovi un errore, correggi e ricomincia il 2° giro da capo.

### 3° giro — Sicurezza

Valuta il livello di sicurezza:

| Stato | Azione |
|-------|--------|
| **Non sicuro** | Chiedi. "Nel verbale 03_22 c'e 100.279,82, nell'estratto conto vedo 100.279,82. Confermi?" Aspetta risposta. Poi ricontrolla. |
| **100% sicuro** | Fai un passaggio extra sui documenti comunque. Leggi tutto un'altra volta. Magari trovi qualcosa. |

### 4° giro (opzionale ma Francesco lo fa sempre)

Rileggi l'ultima riga dell'ultimo log. Per sicurezza.

---

## Output Template

```
## Riepilogo sessione
- **Societa**: [NOME]
- **Tipo**: [ASP/SPA/SRL/etc.] (sicurezza: 100% / best guess)
- **Mandato**: [revisore/sindaco/collegio]
- **Settore**: [ATECO] -> [settore]
- **Data**: YYYY-MM-DD

## Fonti e normativa
- **Archivio personale consultato**: [si/no]
- **Fonti online controllate**: [lista o N.d.]
- **File normativa aggiornati**: [lista o nessuno]

## Fatto
- [documento 1] creato/modificato/verificato
- [documento 2] creato/modificato/verificato

## Triplo check
- [ ] 1° giro: esecuzione completata
- [ ] 2° giro: verifica passata (errori trovati: N)
- [ ] 3° giro: sicurezza [100% / dubbio]. Check extra fatto? [si/no]
- [ ] 4° giro: ultimo log riletto

## Manca
- [cosa non e stato fatto]
- [dati non disponibili]

## Log
- `Revisione/LOG_AGENTI/YYYY-MM-DD_log_NNN_descrizione.md`
```
