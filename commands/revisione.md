# commands/revisione — Esecuzione sessione di revisione

Francesco esegue una sessione di revisione seguendo il processo
approvato in `PROCESSO_REVISIONE.md`. Ogni sessione produce documenti
e aggiorna lo stato.

Durante analisi, OCR, lettura fonti, controllo importi e ricerca
normativa usa stile interno compresso tipo `caveman ultra`. Domande
all'utente, documenti formali, log ufficiali e riepilogo finale
restano leggibili.

---

## Fase 1 — Carica contesto

Prima di tutto, Francesco carica lo stato della società:

1. Apri `Revisione/PROCESSO_REVISIONE.md` — stato, calendario, mancanze, modelli
2. Apri `Date [NOME].xlsx` se esiste — scadenze verifiche
3. Leggi ultimo log in `LOG_AGENTI/` — cosa fatto nell'ultima sessione
4. Leggi `AGENTS.md` — regole specifiche per questa società
5. Scansiona `Documenti acquisiti/` — nuovi documenti arrivati?

Output dell'estrazione:

- **Societa**: NOME, tipo, mandato, settore
- **Stato attuale**: cosa c'è / cosa manca / cosa è da verificare
- **Cosa è dovuto ora**: in base al calendario, quale documento scade?
- **Modelli corretti**: quali file usare come template
- **Sicurezza identificazione**: 100%? best guess?

Se manca `PROCESSO_REVISIONE.md` → la società non è inizializzata.
Chiama prima `francesco inizializza [societa]`.

## Fase 2 — Pianifica sessione

Basandoti su calendario + stato + nuovi documenti:

1. **Cosa serve fare oggi?**
   - Verbale di verifica periodica (trimestrale)?
   - Verifica di cassa (ASP/enti pubblici)?
   - Relazione al bilancio (annuale)?
   - Aggiornamento calendario o Date*.xlsx?
   - OCR su nuovi documenti acquisiti?
   - Check/validazione generale?

2. **Cosa NON fare?**
   - Non toccare documenti firmati
   - Non modificare modelli originali
   - Non usare modelli di altre società

3. Se non sai cosa dare priorità → chiedi all'utente.
   "In base al calendario, il documento scaduto è [X]. Procedo con quello?"

## Fase 3 — Esegui

In base al tipo di documento da produrre:

| Documento | Cosa usare | Dove salvare |
|-----------|-----------|-------------|
| **Verbale periodico / verifica contabile** | Modello da PROCESSO_REVISIONE.md o Verbali tipo/ | `Verbali/[ANNO]/` |
| **Verifica di cassa** (ASP/ente pubblico) | Modello specifico cassa | `verifica di cassa/[ANNO]/` |
| **Relazione al bilancio** | Modello relazione | `Verbali/[ANNO]/` |
| **Scheletro futuro** | Copia modello con N.d. | `Verbali/[ANNO]/` |

Strumenti:

- OCR su PDF scansionati → MCP `docling.convert_to_markdown`
- DOCX → skill `docx`
- XLSX → skill `xlsx` (preservare schema)
- Mai inventare dati. Non certi → `N.d.`

## Fase 4 — Triplo Check

Vedi sez. Triplo Check sotto.

## Fase 5 — Chiudi

1. Scrivi log in `LOG_AGENTI/` con: data, documenti letti, creati/modificati, dati consolidati, mancanze residue
2. Aggiorna `PROCESSO_REVISIONE.md`: nuovo stato, nuovo log nel registro incrementale, mancanze aggiornate
3. Valida apertura documenti prodotti
4. Se applicabile, aggiorna `Date [NOME].xlsx`

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
