---
name: francesco-revisione
description: "Francesco — revisione contabile completa. Scopre la societa, identifica tipo/mandato/settore, propone piano di lavoro, esegue con triplo check, chiude con log. Usa docling MCP per OCR. Use when users ask for: revisione, verbali, verifiche cassa, art.14, collegio sindacale, sindaco unico, documenti revisore, audit, check documenti."
license: MIT
compatibility: opencode, claude-code, cursor
metadata:
  domain: accounting
  role: specialist
  scope: document-management
  output-format: markdown
  related-skills: francesco, docx, xlsx
---

# francesco-revisione

Esegue revisione contabile. Usato dall'orchestratore `SKILL.md`.
Se chiamato diretto, carica preflight da `SKILL.md` prima.

> Regole condivise in SKILL.md padre (preflight, token discipline, MUST/MUST NOT).
> Dopo esecuzione, torna al ciclo orchestratore per verifica + triplo check + chiusura.

---

## Flusso

```
Scopri → Leggi stato → Pianifica → Esegui → Triplo check → Chiudi
```

---

## Step 1 — Scopri

1. Guarda directory corrente.
2. Cosa vedi?
   - `Revisione/` dentro? → societa gia iniziata.
   - `Bilanci/` ma no `Revisione/`? → possibile nuova societa.
   - Piu di una candidata? → elenca e chiedi.
   - Nessuna? → "Non vedo societa. Dove guardo?"
   - Utente da percorso? → vai li.
3. "Ho trovato [NOME1], [NOME2]... Su quale lavoriamo?"
4. Utente sceglie. Spostati in quella directory.

---

## Step 2 — Leggi stato

1. Carica `commands/check.md` e fai un check rapido.
2. Leggi `Revisione/PROCESSO_REVISIONE.md` → stato, calendario, mancanze.
3. Leggi `Revisione/Date [NOME].xlsx` → scadenze.
4. Leggi ultimo log in `LOG_AGENTI/` → ultima sessione.
5. Scansiona `Documenti acquisiti/` → nuovi documenti?

Poi mostra:

> "Ho letto [NOME]. Giurisdizione: [PAESE]. Tipo: [TIPO]. Mandato: [MANDATO].
> Ultima sessione: [DATA] — [RIASSUNTO].
> Prossima scadenza: [DOCUMENTO] del [DATA].
> Mancanze: [N]. Procedo?"

Se PROCESSO_REVISIONE.md non esiste → fermati.
> "Societa non inizializzata. Chiama \`francesco inizializza\` prima."

---

## Step 3 — Pianifica

Basato su calendario + stato + nuovi documenti:

> "Oggi possiamo:
> 1. [es. verbale Q2]
> 2. [es. OCR nuovi documenti]
> 3. [es. check generale]
>
> Cosa facciamo?"

Utente sceglie. Prendi nota.
> "Da NON toccare: [documenti firmati, modelli originali]."

---

## Step 4 — Esegui

Carica `commands/revisione.md#Step4` per la tabella documenti per paese.
Usa il modello corretto da PROCESSO_REVISIONE.md.

Per ogni documento:
- Modello giusto → compila con dati reali → dato mancante = N.d. → salva in cartella anno.

Salva in:
- Verbali: `Verbali/[ANNO]/*.docx`
- Verifiche cassa: `verifica di cassa/[ANNO]/*.docx`
- Altri paesi: vedi `commands/struttura.md`

---

## Step 5 — Triplo check

**1° giro**: Esegui. Senza fretta.

**2° giro**: Verifica tutto.
- N.d. risolvibili altrove?
- Date coerenti? Nomi giusti? Importi combaciano?
- Struttura cartelle integra? (riferimento: `commands/struttura.md`)
- Documenti salvati nella cartella giusta?
- Convenzione nomi log rispettata?
- Errore? → correggi e rifai 2° giro.

**3° giro**: Sicurezza.
- Insicuro? → Chiedi all'utente. "Ho X qui, Y la. Confermi?"
- 100% sicuro? → Fai un giro extra sui documenti comunque.

**4° giro**: Rileggi ultima riga dell'ultimo log.

---

## Step 6 — Chiudi

1. Scrivi log in `LOG_AGENTI/`: `YYYY-MM-DD_log_NNN_descrizione.md`
2. Aggiorna `PROCESSO_REVISIONE.md`: nuovo stato, mancanze, riferimento log
3. Valida apertura documenti prodotti (.docx/.xlsx)
4. Se applicabile, aggiorna `Date [NOME].xlsx`

Poi:

> "Fatto:
> - [documento 1] creato/verificato
> - [documento 2] creato/verificato
>
> Manca:
> - [mancanza 1]
>
> Prossimo passo: [UNA COSA]."

---

## Carica comandi condivisi

| Quando | Carica |
|--------|--------|
| Preflight + validazione struttura | `francesco/commands/struttura.md` |
| Esecuzione documenti per paese | `francesco/commands/revisione.md#Step4` |
| Check documenti | `francesco/commands/check.md` |
| Normativa + ricerca fonti | `francesco/commands/normativa.md` |
| Setup nuova societa | `francesco/commands/inizializza.md` |
| Setup dipendenze | `francesco/commands/setup.md` |
| Report DOCX riepilogo | `francesco/commands/riepilogo.md` |

Tutti i comandi stanno in `francesco/commands/`.
Script MCP server in `francesco/scripts/docling-server.py`.
