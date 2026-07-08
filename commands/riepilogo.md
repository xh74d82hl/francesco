# commands/riepilogo — Report DOCX riassuntivo stato revisione

**Chiamato da:** orchestratore `SKILL.md` (chiusura sessione).
**Standalone:** se l'utente dice "riepilogo" / "report" / "stato".

Produce un file `.docx` nella root `Revisione/` con lo stato attuale
della revisione. Formato leggibile, pronto per stampa o condivisione.

---

## Preflight rapido (solo se standalone)

Skip se chiamato da orchestratore. Altrimenti:
1. `Revisione/PROCESSO_REVISIONE.md` esiste? → no: fermati.
2. Carica PROCESSO_REVISIONE.md + ultimo log.

---

## Esegui

### 1. Leggi stato

Carica da `PROCESSO_REVISIONE.md`:
- Giurisdizione, tipo, mandato, settore
- Esercizio corrente
- Fonti normative preferite
- Calendario verifiche
- Stato attuale
- Mancanze aperte

Carica ultimo log da `LOG_AGENTI/`:
- Data ultima sessione
- Cosa fatto
- Cosa manca

### 2. Genera DOCX

Usa skill `docx` per produrre il file. Struttura del documento:

```
Pagina 1 — Intestazione
  "STATO REVISIONE — [NOME SOCIETA]"
  Data report: YYYY-MM-DD
  Prossimo passo: [UNA COSA]

Sezione 1 — Identificazione
  Giurisdizione: [PAESE]
  Tipo: [TIPO]
  Mandato: [MANDATO]
  Settore: [SETTORE]
  Esercizio corrente: [AAAA]

Sezione 2 — Stato attuale
  [Paragrafo dall'ultimo log: cosa fatto, cosa trovato]

Sezione 3 — Calendario verifiche
  [Tabella: Periodo | Documento | Scadenza | Stato]

Sezione 4 — Mancanze aperte
  [Elenco puntato: mancanze da PROCESSO_REVISIONE.md]

Sezione 5 — Prossimo passo
  [Una azione consigliata]
```

### 3. Nome file

Salva come: `Revisione/Riepilogo_YYYY-MM-DD_[NOME].docx`

Esempio: `Revisione/Riepilogo_2026-07-08_ASP MOSCA.docx`

Se il file esiste gia per la stessa data → appendi `_v2`, `_v3`...

---

## Output

```
## Riepilogo prodotto
- **File**: Revisione/Riepilogo_YYYY-MM-DD_[NOME].docx
- **Data**: YYYY-MM-DD
- **Stato**: OK
```

Francesco torna al ciclo orchestratore per triplo check e chiusura.
