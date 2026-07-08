# commands/normativa — Archivio normativo + ricerca per giurisdizione

**Chiamato da:** orchestratore `SKILL.md` (preflight), `commands/inizializza.md`.
**Standalone:** preflight rapido se chiamato diretto.

Costruisce e aggiorna l'archivio normativo locale per paese/tipo/settore.
Usa fonti ufficiali del paese di competenza.
Salva in `normative/` dentro la directory societa.

## Il problema

Francesco non puo tenere in testa tutte le leggi. E allora se le scrive. Ogni volta che lavora su una societa, si costruisce il suo archivietto personale: norme, decreti, articoli di codice che servono per quel tipo di societa e quel settore.

Non un monolito GitHub. Roba sua. Locale. Aggiornata quando serve.

Regola dura: `normative/` e archivio utente. Non cancellare, non sovrascrivere in blocco, non rigenerare da zero durante reinstall/update. Aggiornare solo con merge o append dei file necessari.

Durante ricerca e lettura fonti usa stile interno compresso tipo `caveman ultra`. Il riepilogo finale torna leggibile.

---

## Preflight

> PRIMA DI OGNI LAVORO SU UNA SOCIETA

Ogni volta che Francesco lavora su una societa (nuova o gia iniziata), prima di toccare qualsiasi documento:

### Step 1 — Rileva giurisdizione e sfoglia archivio

Prima di tutto, Francesco determina la giurisdizione dalla documentazione
della societa (statuto, visura/certificate of incorporation, sede legale).

Poi guarda dentro `normative/` se esiste gia documentazione per:
- **Paese / giurisdizione** (es. Italia, Germania, Francia, USA-Delaware)
- **Tipo societario** (ASP/SPA/SRL/GmbH/SAS/AG/LLC/Inc/SA/SARL/...)
- **Settore merceologico** (anziani/automotive/calcio/immobiliare/manifatturiero/commercio)

### Step 2 — C'e tutto quello che serve?

Verifica che i file esistenti coprano gli adempimenti base del mandato.

Se l'archivio e completo per questa societa → passa oltre, inizia il lavoro.

Se manca qualcosa o l'archivio e vuoto → vai allo Step 3.

### Step 3 — Chiedi preferenze fonti all'utente

Prima di cercare, Francesco chiede:

> "Per [GIURISDIZIONE] ho queste fonti di default:
> [elenco fonti standard per il paese].
>
> Hai fonti particolari che preferisci?
> (Es. sito regionale specifico, banca dati settoriale, rivista specializzata,
> oppure 'no, usa quelle standard')"

Se l'utente da fonti specifiche → salva in `Revisione/PROCESSO_REVISIONE.md`
sotto una sezione `Fonti normative preferite`.

Se l'utente dice "standard" o non risponde → usa quelle di default.

> Le preferenze fonti restano salvate in PROCESSO_REVISIONE.md.
> Francesco non chiede piu ogni volta, a meno che non cambi giurisdizione.

### Step 4 — Cerca online per giurisdizione e salva

Francesco cerca sulle fonti ufficiali del paese di competenza:

#### Italia
- **Normattiva** (https://www.normattiva.it) — leggi e decreti
- **Gazzetta Ufficiale** (https://www.gazzettaufficiale.it) — pubblicazioni
- **CNDCEC** (https://www.cndcec.it) — principi di revisione italiani
- **Consiglio Nazionale** competente — linee guida

#### Germania
- **Bundesgesetzblatt** (https://www.bgbl.de) — leggi federali
- **Bundesanzeiger** (https://www.bundesanzeiger.de) — pubblicazioni societarie
- **Handelsregister** (https://www.handelsregister.de) — registro imprese
- **IDW** (https://www.idw.de) — principi di revisione tedeschi
- **DtA / WpHG** — normativa mercati

#### Francia
- **Légifrance** (https://www.legifrance.gouv.fr) — leggi e codici
- **Journal Officiel** (https://www.journal-officiel.gouv.fr) — pubblicazioni
- **Autorité des Marchés Financiers** (https://www.amf-france.org) — mercati
- **CNCC** (https://www.cncc.fr) — principi di revisione francesi
- **INPI** (https://www.inpi.fr) — registro imprese

#### USA
- **SEC.gov** (https://www.sec.gov) — mercati, bilanci pubblici, EDGAR
- **FASB** (https://www.fasb.org) — principi contabili US GAAP
- **AICPA** (https://www.aicpa.org) — principi di revisione USA
- **State corporation registries** — registro imprese per stato (Delaware, NY, CA...)
- **PCAOB** (https://pcaobus.org) — standard di audit per societa quotate

#### UK
- **legislation.gov.uk** (https://www.legislation.gov.uk) — leggi
- **Companies House** (https://www.gov.uk/government/organisations/companies-house) — registro imprese
- **FRC** (https://www.frc.org.uk) — principi di revisione UK
- **IASB** (https://www.ifrs.org) — IFRS globali

#### Svizzera
- **Fedlex** (https://www.fedlex.admin.ch) — leggi federali
- **ZEFIX / Swiss Central Business Index** — registro imprese
- **EXPERTsuisse** (https://www.expertsuisse.ch) — principi di revisione

#### Altri paesi
Se la giurisdizione non e coperta sopra, cerca:
1. Gazzetta ufficiale / bollettino ufficiale del paese
2. Registro imprese nazionale
3. Consiglio / ordine dei revisori locali
4. Principi contabili locali (GAAP locali o IFRS adottati)

---

#### Per tipo societario

| Giurisdizione | Tipo | Riferimenti principali |
|--------------|------|----------------------|
| **Italia** | ASP | L.R. regionale, D.Lgs. 118/2011 art. 14, D.Lgs. 207/2001 |
| | SPA | Codice Civile artt. 2409-bis ss., D.Lgs. 39/2010, TUF |
| | SRL | Codice Civile artt. 2477, D.Lgs. 39/2010 |
| | Cooperativa | D.Lgs. 220/2002 (Basevi), revisione coop |
| | Sportiva | D.Lgs. 36/2021, FIGC, NOIF |
| **Germania** | GmbH | GmbHG, HGB, AktG se applicabile |
| | AG | AktG, HGB, DPR UG |
| | UG | GmbHG (semplificata), HGB |
| | e.V. | BGB, Gemeinnützigkeit |
| **Francia** | SAS | Code de Commerce, Loi PACTE |
| | SARL | Code de Commerce, Loi PACTE |
| | SA | Code de Commerce, AMF se quotata |
| | Association Loi 1901 | Loi 1901, Code Civil |
| **USA** | Inc / Corp | State corporation law (Delaware GCL, NY BCL...), SEC se quotata |
| | LLC | State LLC act, IRS classification |
| | Non-profit | State non-profit act, IRC 501(c) |
| **UK** | Ltd | Companies Act 2006, FRC standards |
| | PLC | Companies Act 2006, UK Corporate Governance Code, FCA |
| | CIC | Companies Act 2006 + community interest test |
| **Svizzera** | SA / AG | Code des Obligations (CO/OR) |
| | Sàrl / GmbH | Code des Obligations (CO/OR) |

#### Per settore (cross-country)

| Settore | Cosa cercare |
|---------|-------------|
| **Healthcare / anziani** | Licenze, accreditamenti, requisiti strutture, normativa regionale/federale |
| **Automotive** | Concessioni, autoriparazione, obblighi registro, omologazioni |
| **Sport / calcio** | Federation rules, licensing, salary caps, Fair Play |
| **Immobiliare** | Locazione, compravendita, imposte, registri |
| **Manifatturiero** | Industria, ambiente, sicurezza, emissioni |
| **Commercio / e-commerce** | Vendita, IVA, obblighi registro, privacy, GDPR |
| **Finanziario / assicurativo** | Vigilanza, Basilea, Solvency, AML, KYC |
| **Non-profit** | Status, fiscalità, trasparenza, rendicontazione |
| **Energia / utilities** | Concessioni, regolazione, ambiente |

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
- **Societa**: [nome]
- **Giurisdizione**: [IT/DE/FR/US/UK/CH/...]
- **Fonti controllate**: [Normattiva, Bundesanzeiger, Légifrance, SEC, ...]
- **File aggiornati**: [lista]
- **Cosa ho trovato**: [punti essenziali per paese/tipo]
- **Cosa manca**: [se presente]
- **Sicurezza**: [alta/media/bassa + motivo]
- **Prossima azione**: [una cosa]
```
