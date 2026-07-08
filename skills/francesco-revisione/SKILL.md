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

Esecuzione della revisione contabile su una societa. Scopre la societa
da solo, analizza, propone, esegue con triplo check, chiude.

> Per le regole condivise (safety preflight, token discipline, MUST/MUST NOT)
> vedi la skill principale `francesco`.

## Flusso completo

```
Scopri societa → Leggi stato → Pianifica → Esegui → Triplo check → Chiudi
```

### Step 1 — Scopri la societa

Guarda nella directory corrente.

Cosa vede?
- Directory con `Revisione/` dentro? → societa gia iniziata.
- Directory con `Bilanci/`? → possibile societa, non ancora in revisione.
- Piu di una candidata? → elenca e chiedi.
- Nessuna? → "Non vedo societa qui. Dove devo guardare?"
- Utente da un percorso? → vai li.

> "Ho trovato [NOME1], [NOME2]... Su quale vuoi lavorare?"

### Step 2 — Leggi stato

Apri i file della societa scelta:

| File | Cosa cercare |
|------|-------------|
| `Revisione/PROCESSO_REVISIONE.md` | Stato, calendario, mancanze, modelli |
| `Revisione/Date [NOME].xlsx` | Scadenze |
| `Revisione/LOG_AGENTI/` ultimo log | Ultima sessione |
| `AGENTS.md` | Regole specifiche |
| `Revisione/Documenti acquisiti/` | Nuovi documenti? |

Poi mostra all'utente:

> "Ho letto [NOME]. Tipo: [TIPO]. Mandato: [MANDATO].
> Ultima sessione: [DATA] — [RIASSUNTO].
> Prossima scadenza: [DOCUMENTO] del [DATA].
> Manncanze aperte: [N]. Procedo con [PROSSIMO PASSO]?"

Se `PROCESSO_REVISIONE.md` non esiste:

> "Societa non inizializzata. Vuoi che la inizializzi?
> Chiama \`francesco inizializza\` o apri la skill \`francesco\`."

### Step 3 — Pianifica sessione

Basandoti su calendario + stato + nuovi documenti, proponi:

> "Oggi possiamo:
> 1. [es. produrre verbale Q2 2025]
> 2. [es. OCR nuovi documenti]
> 3. [es. check generale]
>
> Cosa facciamo?"

Utente sceglie. Prendi nota.

> "Da NON toccare: [documenti firmati, modelli originali, modelli di altre societa]."

### Step 4 — Esegui

| Documento | Strumento |
|-----------|-----------|
| Verbale periodico / verifica contabile | Modello da PROCESSO_REVISIONE.md + skill docx |
| Verifica di cassa (ASP/ente pubblico) | Modello cassa + skill docx |
| Relazione al bilancio | Modello relazione + skill docx |
| Scheletro futuro | Copia modello con N.d. |
| OCR su PDF | MCP docling |
| Tabella XLSX | skill xlsx (preservare schema) |

Per ogni documento:
- Usa il modello corretto (da PROCESSO_REVISIONE.md o Verbali tipo/)
- Compila con dati reali
- Se manca un dato → N.d. — mai inventare
- Salva nella cartella giusta (Verbali/[ANNO]/, verifica di cassa/[ANNO]/)

### Step 5 — Triplo Check

1° giro — Esecuzione: fai il lavoro. Senza fretta.

2° giro — Verifica: rileggi tutto. Controlla:
- N.d. che potrebbero essere dati certi altrove?
- Date coerenti? Nomi giusti? Importi combaciano?
- Riferimenti incrociati tornano?
Se trovi errore → correggi e ricomincia 2° giro.

3° giro — Sicurezza:
- Non sicuro? Chiedi all'utente. "Ho [IMPORTO] qui, [IMPORTO] la. Confermi?"
- 100% sicuro? Fai un passaggio extra sui documenti comunque.

4° giro: rileggi ultima riga ultimo log. Per sicurezza.

### Step 6 — Chiudi

1. Scrivi log in `LOG_AGENTI/`: data, societa, documenti letti/creati/modificati, dati consolidati, mancanze residue
2. Aggiorna PROCESSO_REVISIONE.md: nuovo stato, log nel registro incrementale, mancanze aggiornate
3. Valida apertura documenti prodotti (.docx/.xlsx si aprono?)
4. Se applicabile, aggiorna Date [NOME].xlsx

> "Sessione finita. Fatto: [lista]. Manca: [lista]. Prossimo passo: [UNA COSA]."

## Carica comandi condivisi

Quando servi tool specifici (check, normativa, triage), carica i file
da `commands/` nella skill principale `francesco`.

Ad esempio:
- `francesco/commands/check.md` — validazione documenti
- `francesco/commands/normativa.md` — preflight + archivio normativo
- `francesco/commands/triage.md` — scansione rapida
- `francesco/commands/inizializza.md` — setup nuova societa
