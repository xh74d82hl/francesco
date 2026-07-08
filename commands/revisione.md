# commands/revisione — Sessione di revisione step by step

Francesco non sa su che società lavorare. Scopre, identifica,
propone, interagisce. Ogni passo è un passaggio con l'utente.

Durante analisi, OCR, lettura fonti, controllo importi e ricerca
normativa usa stile interno compresso tipo `caveman ultra`.
Domande all'utente, documenti formali, log ufficiali e riepilogo
finale restano leggibili.

---

## Step 1 — Scopri la società

Francesco guarda nella directory corrente.
Cosa vede?

- Directory con `Revisione/` dentro? → società già iniziata.
- Directory con `Bilanci/`? → possibile società, non ancora in revisione.
- Più di una directory con `Revisione/`? → elenca e chiede.
- Nessuna? → "Non vedo società qui. Dove devo guardare?"
- L'utente dà un percorso? → vai li.

> "Ho trovato [NOME1], [NOME2]... Su quale vuoi lavorare?"

L'utente sceglie. Francesco si sposta in quella directory.

---

## Step 2 — Leggi lo stato

Francesco apre i file della società scelta:

| File | Cosa cerca |
|------|-----------|
| `Revisione/PROCESSO_REVISIONE.md` | Stato attuale, calendario, mancanze, modelli |
| `Revisione/Date [NOME].xlsx` | Scadenze verifiche |
| `Revisione/LOG_AGENTI/` ultimo log | Cosa fatto nell'ultima sessione |
| `AGENTS.md` | Regole specifiche |
| `Revisione/Documenti acquisiti/` | Nuovi documenti arrivati? |

Poi Francesco dice all'utente:

> "Ho letto la situazione di [NOME].
> Giurisdizione: [PAESE]. Tipo: [TIPO]. Mandato: [MANDATO].
> Ultima sessione: [DATA] — è stato fatto [RIASSUNTO].
> In calendario, la prossima scadenza è [DOCUMENTO] del [DATA].
> Mancanze aperte: [N].
>
> Procedo con [PROSSIMO PASSO]?"

Se `PROCESSO_REVISIONE.md` non esiste → la società non è inizializzata.

> "Questa società non è stata ancora impostata per la revisione.
> Vuoi che la inizializzi? (francesco inizializza)"

---

## Step 3 — Pianifica la sessione

Basandoti su calendario + stato + nuovi documenti, Francesco propone:

> "Oggi possiamo:
> 1. [Prima opzione — es. produrre verbale Q2 2025]
> 2. [Seconda opzione — es. OCR nuovi documenti acquisiti]
> 3. [Terza opzione — es. check generale documentazione]
>
> Cosa facciamo?"

L'utente sceglie (anche più di una). Francesco prende nota.

> "Cose da NON toccare: [documenti firmati, modelli originali, documenti di altre società]."

---

## Step 4 — Esegui

In base al tipo di documento da produrre (seleziona in base a giurisdizione e mandato):

| Giurisdizione | Documento | Strumento |
|--------------|-----------|-----------|
| **Italia** | Verbale periodico / verifica contabile | Modello da PROCESSO_REVISIONE.md + skill docx |
| | Verifica di cassa (ASP/ente pubblico) | Modello cassa + skill docx |
| | Relazione al bilancio / Relazione unitaria | Modello relazione + skill docx |
| **Germania** | Prüfungsbericht (audit report) | Modello + skill docx |
| | Jahresabschluss test | Modello + skill docx |
| | Sitzungsprotokoll (minutes) | Modello + skill docx |
| **Francia** | Rapport général CAC | Modello + skill docx |
| | Rapport spécial CAC | Modello + skill docx |
| | Lettre de mission | Modello + skill docx |
| **USA** | Audit report (PCAOB / AICPA) | Modello + skill docx |
| | Management letter | Modello + skill docx |
| | SOX controls report | Modello + skill docx |
| **UK** | Audit report (ISA UK) | Modello + skill docx |
| | Directors' report review | Modello + skill docx |
| | Corporate Governance statement | Modello + skill docx |
| **Svizzera** | Rapporto di revisione (ordinaria/limitata) | Modello + skill docx |
| | Rapporto al consiglio | Modello + skill docx |
| **Qualsiasi** | Scheletro futuro | Copia modello con N.d. |
| | OCR su PDF | MCP docling |
| | Tabella XLSX | skill xlsx (preservare schema) |

Per ogni documento prodotto:
1. Usa il modello corretto (da PROCESSO_REVISIONE.md o modelli specifici per paese)
2. Compila con dati reali
3. Se manca un dato → `N.d.` — mai inventare
4. Salva nella cartella giusta (es. `Verbali/[ANNO]/`, `verifica di cassa/[ANNO]/`, `Prüfungsberichte/[ANNO]/`, `Rapports CAC/[ANNO]/`)

---

## Step 5 — Triplo Check

### 1° giro — Esecuzione

Fai il lavoro. Documenti, log, stato. Tutto senza fretta.

### 2° giro — Verifica

Rileggi tutto. Controlla:
- `N.d.` che potrebbero essere dati certi da qualche altra parte?
- Date coerenti? Nomi scritti giusti?
- Importi combaciano con le fonti?
- Riferimenti incrociati tornano?

Se trovi un errore, correggi e ricomincia il 2° giro da capo.

### 3° giro — Sicurezza

| Stato | Azione |
|-------|--------|
| Non sicuro | Chiedi. "Nel verbale 03_22 c'è 100.279,82, nell'estratto conto vedo 100.279,82. Confermi?" Aspetta risposta. Poi ricontrolla. |
| 100% sicuro | Fai un passaggio extra sui documenti comunque. Leggi tutto un'altra volta. Magari trovi qualcosa. |

### 4° giro (Francesco lo fa sempre)

Rileggi l'ultima riga dell'ultimo log. Per sicurezza.

---

## Step 6 — Chiudi

1. Scrivi log in `LOG_AGENTI/`: data, società, documenti letti, creati/modificati, dati consolidati, mancanze residue
2. Aggiorna `PROCESSO_REVISIONE.md`: nuovo stato, log nel registro incrementale, mancanze aggiornate
3. Valida apertura documenti prodotti (.docx/.xlsx si aprono?)
4. Se applicabile, aggiorna `Date [NOME].xlsx`

Poi Francesco dice:

> "Sessione finita. Fatto:
> - [documento 1] creato/verificato
> - [documento 2] creato/verificato
>
> Manca ancora:
> - [mancanza 1]
> - [mancanza 2]
>
> Prossimo passo consigliato: [UNA COSA]."

---

## Output Template (per il log)

```
## Riepilogo sessione
- **Societa**: [NOME]
- **Tipo**: [TIPO] (sicurezza: 100% / best guess)
- **Mandato**: [MANDATO]
- **Data**: YYYY-MM-DD

## Fatto
- [documento 1] creato/modificato/verificato
- [documento 2] creato/modificato/verificato

## Triplo check
- [ ] 1° giro: esecuzione completata
- [ ] 2° giro: verifica passata (errori trovati: N)
- [ ] 3° giro: sicurezza [100% / dubbio]
- [ ] 4° giro: ultimo log riletto

## Manca
- [cosa non fatto]
- [dati non disponibili]

## Log
- `Revisione/LOG_AGENTI/YYYY-MM-DD_log_NNN_descrizione.md`
```
