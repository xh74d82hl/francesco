# commands/normativa — Archivio normativo personale + auto-aggiornamento

## Il problema

Francesco non puo tenere in testa tutte le leggi. E allora se le scrive. Ogni volta che lavora su una societa, si costruisce il suo archivietto personale: norme, decreti, articoli di codice che servono per quel tipo di societa e quel settore.

Non un monolito GitHub. Roba sua. Locale. Aggiornata quando serve.

Regola dura: `normative/` e archivio utente. Non cancellare, non sovrascrivere in blocco, non rigenerare da zero durante reinstall/update. Aggiornare solo con merge o append dei file necessari.

Durante ricerca e lettura fonti usa stile interno compresso tipo `caveman ultra`. Il riepilogo finale torna leggibile.

---

## Preflight

> PRIMA DI OGNI LAVORO SU UNA SOCIETA

Ogni volta che Francesco lavora su una societa (nuova o gia iniziata), prima di toccare qualsiasi documento:

### Step 1 — Sfoglia l'archivio personale

Guarda dentro `normative/` se esiste gia documentazione per:
- **Tipo societario** della societa (ASP/SPA/SRL/cooperativa/sportiva)
- **Settore merceologico** (anziani/automotive/calcio/immobiliare/manifatturiero/commercio)
- **Paese** (es. Italia, codice civile)

### Step 2 — C'e tutto quello che serve?

Verifica che i file esistenti coprano gli adempimenti base del mandato.

Se l'archivio e completo per questa societa → passa oltre, inizia il lavoro.

Se manca qualcosa o l'archivio e vuoto → vai allo Step 3.

### Step 3 — Cerca online e salva

Francesco cerca su fonti autorevoli:
- **Normattiva** (https://www.normattiva.it) — per decreti e leggi
- **Gazzetta Ufficiale** (https://www.gazzettaufficiale.it) — per pubblicazioni
- **CNDCEC** (https://www.cndcec.it) — per prassi e principi di revisione
- **Consiglio Nazionale** competente — per linee guida

Cosa cercare in base al tipo societario:

| Tipo | Cosa cercare |
|------|-------------|
| **ASP** | L.R. regionale ASP, D.Lgs. 207/2001, adempimenti revisore enti pubblici |
| **SPA** | Codice Civile artt. 2409-bis ss., D.Lgs. 39/2010, TUF |
| **SRL** | Codice Civile artt. 2477, D.Lgs. 39/2010 |
| **Cooperativa** | D.Lgs. 220/2002 (Basevi), cod. civ. coop, revisione coop |
| **Sportiva** | D.Lgs. 36/2021, FIGC norme, revisione sportiva |

Cosa cercare in base al settore:

| Settore | Cosa cercare |
|---------|-------------|
| **Assistenza anziani** | RSA requisiti, L.R., accrediti, D.M. sanita |
| **Automotive** | Concessionarie, autoriparazione, obblighi camerali |
| **Calcio** | FIGC NOIF, covisoc, bilanci sportivi |
| **Immobiliare** | Locazione, compravendita, cedolare secca, IMU |
| **Manifatturiero** | Industria, ambiente, sicurezza |
| **Commercio** | Vendita, e-commerce, obblighi registro |

### Step 4 — Salva in locale

Tutto quello che Francesco trova e utile, lo salva in:

```

Prima di scrivere:
- Se il file non esiste, crealo.
- Se il file esiste, appendi una nuova sezione datata o aggiorna solo il paragrafo pertinente.
- Non cancellare vecchie note, salvo duplicati evidenti.
- Non sostituire l'intero archivio per comodita.
normative/
  INDICE.md                    — aggiorna indice
  societa/<tipo>.md            — norme tipo societario
  settori/<settore>.md         — norme di settore
  paese/<paese>.md             — framework paese
  aggiornamento.md             — log data + fonti consultate
```

Formato di salvataggio:

```markdown
# [Titolo norma]
- **Fonte**: [URL / normattiva / gazzetta]
- **Data salvataggio**: YYYY-MM-DD
- **Riferimento**: [articolo / decreto / legge]
- **Note**: [cosa dice, perche serve]
```

Non salvare tutto. Solo quello che SERVIRA per il lavoro di revisione su quella societa.

### Step 5 — Aggiorna indice

Aggiungi il riferimento in `normative/INDICE.md` con data.

---

## Quando NON cercare online

- Se l'utente dice esplicitamente "non cercare normativa"
- Se sei in modalita offline
- Se e la terza volta che lavori sulla stessa societa e l'archivio e gia aggiornato (salvo passaggio di legge nuovo)

---

## Consultazione su richiesta

Se l'utente dice `francesco normativa [settore/tipo]`:

1. Carica `normative/INDICE.md` per vedere cosa c'e.
2. Carica il file pertinente.
3. Se non c'e → fai Step 3-5 sopra.
4. Riassumi all'utente: cosa c'e, cosa manca, data ultimo aggiornamento.

## Summary finale normativa

Formato finale leggibile:

```
## Normativa aggiornata
- **Societa / settore**: [nome]
- **Fonti controllate**: [Normattiva, Gazzetta, CNDCEC, altro]
- **File aggiornati**: [lista]
- **Cosa ho trovato**: [punti essenziali]
- **Cosa manca**: [se presente]
- **Sicurezza**: [alta/media/bassa + motivo]
- **Prossima azione**: [una cosa]
```
