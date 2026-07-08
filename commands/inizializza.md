# commands/inizializza — Commissionamento revisione: analisi + proposta

Francesco non impone un template fisso. Scopre la società, la capisce,
propone un processo di revisione su misura, lo fa approvare dall'utente,
poi lo segue.

---

## Flusso

```
Scopri  →  Scan  →  Identifica  →  Propone  →  Utente approva  →  Salva e inizia
```

---

## Step 0 — Scopri la società

Francesco guarda nella directory corrente.
Cosa vede?

- Directory con `Bilanci/` ma senza `Revisione/`? → possibile nuova società.
- Directory con `Revisione/` già? → "Questa è già inizializzata. Vuoi farci una revisione?"
- Più di una candidata? → elenca e chiede.
- Nessuna? → "Non vedo società qui. Dove devo guardare?"
- L'utente dà un percorso? → vai lì.

> "Ho trovato [NOME1], [NOME2]... Quale vuoi inizializzare?"

L'utente sceglie. Francesco si sposta in quella directory.

Poi fa un primo scan veloce:

> "Vedo che [NOME] ha [Bilanci, statuto, visura...].
> Sembra una [TIPO IPOTESI]. Confermi?"

---

## Fase 1 — Scan approfondito

Scansiona la directory della società per capire cosa c'è già.

Cosa cercare:
- Nome della cartella (indizio su tipo e paese: "ASP", "GmbH", "SAS", "LLC", "Ltd"?)
- `Statuto/`, `Statuten/`, `Statuts/`, `Bylaws/` o file equivalente (PDF/DOCX) → tipo societario
- `Visura/`, `Handelsregister/`, `Registre du Commerce/`, `Certificate of Incorporation/` → tipo, codice attività, dati registro
- `Bilanci/`, `Financial Statements/`, `Jahresabschluss/` → esercizi già depositati
- `Verbali soci/`, `Meeting Minutes/`, `Protokolle/` → governance
- `Revisione/` già esistente? Se sì → carica stato, non ri-inizializzare
- `Documenti statutari/`, `Legal Documents/`, `Corporate/` → statuto, atto costitutivo, nomine
- File `.xlsx` con nome "Date*" o "Schedule*" → calendario verifiche già esistente?
- Sede legale / registered address → indizio giurisdizione (se nei documenti)

Output della scansione:

| Indizio | Possibile giurisdizione | Cosa rivela |
|---------|------------------------|-------------|
| "ASP" / "Casa di Riposo" / "Comune" | Italia | Ente pubblico, D.Lgs. 118/2011 art. 14 |
| "SPA" / "SRL" / "Società" | Italia | Codice Civile Italiano |
| "GmbH" / "AG" / "e.V." | Germania / Austria | GmbHG, AktG, HGB, BGB |
| "UG" (haftungsbeschränkt) | Germania | GmbHG semplificata, HGB |
| "SAS" / "SARL" / "SA" / "EURL" | Francia | Code de Commerce |
| "Sàrl" / "SA" / "SAS" | Svizzera | Code des Obligations (CO/OR) |
| "Ltd" / "Limited" / "PLC" | UK / Irlanda | Companies Act 2006 |
| "LLC" / "Inc" / "Corp" / "PLLC" | USA | State corporation law |
| "SL" / "SA" / "SRL" / "Sociedad" | Spagna | Ley de Sociedades de Capital |
| "sportiva" / "calcio" / "FIGC" | Italia | D.Lgs. 36/2021, NOIF |
| "cooperativa" / "coop" / "eG" | Italia / Germania | Legge coop / GenG |
| Bilanci / Financial Statements depositati | — | Esercizi chiusi, dati dimensionali |

---

## Fase 2 — Identifica

### Giurisdizione e tipo societario

Determina prima la giurisdizione, poi il tipo specifico.

Usa gli indizi della scansione. Se non certo:

```
Giurisdizione non documentata. Ipotesi: [PAESE] per [motivo].
Da verificare su visura/statuto/certificate of incorporation.
Chiedi: "Che paese e che tipo di società è? (IT-ASP / IT-SPA / DE-GmbH / FR-SAS / US-LLC / UK-Ltd / altro)"
```

### Mandato

Cerca in:
- `AGENTS.md` esistente
- `Documenti statutari/`, `Corporate/`, `Legal Documents/` → nomine, delibere
- `Revisione/Documenti da tenere/` → lettera incarico, engagement letter, attestazioni
- Nome cartella revisione, log esistenti

Opzioni per paese:

| Giurisdizione | Mandato | Indizi |
|--------------|---------|--------|
| **Italia** | Revisore unico / Organo di revisione | Ente pubblico (ASP, comune), D.Lgs. 118/2011 |
| | Sindaco unico | SRL, nomina singola, statuto |
| | Collegio sindacale | SPA, obbligo collegiale per legge |
| | Revisore legale + Collegio | SPA con revisione legale affidata al collegio o esterna |
| **Germania** | Abschlussprüfer (revisore legale) | GmbH/AG, nomina assembleare, HGB |
| | Aufsichtsrat (consiglio di sorveglianza) | AG mitbestimmt, AktG |
| | Prüfungsausschuss (comitato audit) | Quotate, bilanci consolidati |
| **Francia** | Commissaire aux Comptes (revisore) | SAS/SARL/SA, obbligo per dimensione, Code de Commerce |
| | Comité d'Audit | SA quotate, AMF |
| **USA** | External Auditor (CPA firm) | Inc/LLC, engagement letter, PCAOB se quotata |
| | Audit Committee | Public companies, SOX, SEC |
| | Internal Auditor | Non obbligatorio ma best practice |
| **UK** | Statutory Auditor | Ltd/PLC, Companies Act 2006, FRC |
| | Audit Committee | PLC, UK Corporate Governance Code |
| **Svizzera** | Organo di revisione (Ordentliche Prüfung) | SA/Sàrl, obbligo per dimensione, CO/OR |
| | Organo di revisione (Eingeschränkte Prüfung) | Piccole-medie, CO/OR |

### Settore

Dedurre da codice attività (ATECO / NACE / NAICS / SIC / WZ) o da nome attività.

Esempi:
- "Casa di Riposo", "Pflegeheim", "Nursing Home", "Maison de Retraite" → assistenza anziani, healthcare
- "Gubbio" + calcio, "FC Bayern", "Manchester United" → sportivo, calcio
- "Autohaus", "Car Dealer", "Concessionaria" → automotive
- Senza indizi → chiedi all'utente

---

## Fase 3 — Propone processo di revisione

Francesco compila una bozza di `PROCESSO_REVISIONE.md` basata su:

### Per ogni giurisdizione + tipo + mandato, la checklist base

| Giurisdizione | Tipo | Mandato | Documenti da produrre | Frequenza |
|--------------|------|---------|----------------------|-----------|
| **Italia** | ASP | Revisore unico | Verifiche di cassa trimestrali + Verbale art. 14 annuale | Trimestrale |
| | SRL | Sindaco unico | Verbali periodici verifica contabile + Relazione al bilancio | Trimestrale |
| | SPA | Collegio sindacale | Verbali periodici + Relazione al bilancio (unitaria se anche rev. legale) | Trimestrale |
| | SPA | Collegio + Rev. legale separata | Verbali collegio + Relazione rev. legale + Relazione unitaria | Trimestrale |
| | Sportiva | Sindaco unico | Verbali periodici + FIGC/COVISOC + relazione sportiva | Trimestrale + FIGC |
| | Cooperativa | Revisore/Sindaco | Verbali periodici + Revisione coop (D.Lgs. 220/2002) | Trimestrale |
| **Germania** | GmbH | Abschlussprüfer | Prüfungsbericht + Jahresabschluss test + Lagebericht | Annuale |
| | AG | Abschlussprüfer | Prüfungsbericht + Konzernabschluss + Prüfungsausschuss report | Annuale / trimestrale se quotata |
| | GmbH/AG | Aufsichtsrat | Sitzungsprotokolle + Berichte an HV | Trimestrale / semestrale |
| **Francia** | SAS/SARL/SA | CAC (Commissaire aux Comptes) | Rapport général + Rapport spécial + vérification périodique | Annuale / trimestrale |
| | SA | Comité d'Audit | Rapport comité + revue semestrale | Semestrale |
| **USA** | Inc/LLC | External Auditor | Audit report + Financial statements + Management letter | Annuale (trimestrale se quotata SEC) |
| | Public Inc | Auditor + Audit Committee | 10-K / 10-Q audit + SOX controls + PCAOB report | Annuale + trimestrale |
| **UK** | Ltd | Statutory Auditor | Audit report + Financial statements + Directors' report | Annuale |
| | PLC | Auditor + Audit Committee | Audit report + Corporate Governance statement + FRC compliance | Annuale + semestrale |
| **Svizzera** | SA/Sàrl | Organo di revisione | Rapporto di revisione + revisione limitata/ordinaria | Annuale |

### Aggiunte per settore specifico (cross-country)

| Settore | Documenti extra |
|---------|----------------|
| **Healthcare / anziani** | Accrediti, licenze, requisiti strutture, normativa sanitaria locale |
| **Calcio / sport** | Federation rules, licensing, covisoc / DFL / salary cap, parti correlate |
| **Automotive** | Concessioni, autoriparazione, F24 / VAT, inventario, riconciliazioni |
| **Immobiliare** | Contratti locazione, imposte locali, register |
| **Commercio / e-commerce** | Registri IVA / VAT, privacy (GDPR / CCPA), obblighi registro |
| **Finanziario** | Vigilanza, Basilea / Solvency, AML/KYC, reporting regolamentare |
| **Non-profit** | Status fiscale, trasparenza, rendicontazione, donazioni |

### Struttura cartelle da creare

Francesco segue la struttura canonica definita in `commands/struttura.md`.
Qui il riepilogo:

Base comune (sempre):

```
<NOME_SOCIETA>/
  AGENTS.md
  Bilanci/
  Documenti statutari/
  Documenti appunti/
  Pratiche varie/
  normative/
  Revisione/
    PROCESSO_REVISIONE.md
    Date <NOME>.xlsx
    LOG_AGENTI/
    Verbali/
      insediamento e accettazione/
    Documenti acquisiti/
    Documenti da tenere/
```

Extra per giurisdizione/tipo (vedi `commands/struttura.md` per dettagli):

| Giurisdizione | Se... | Aggiungi |
|--------------|-------|----------|
| Italia | ASP / ente pubblico | `verifica di cassa/` con sottocartelle anno + Modelli/ |
| Italia | Qualsiasi con libri sociali | `utilizzo pagine libro.xlsx` |
| Germania | AG / GmbH | `Prüfungsberichte/` per anno |
| Francia | SA / SAS | `Rapports CAC/` per anno |
| USA | Public company | `SEC Filings/`, `SOX Controls/` |
| UK | PLC | `Corporate Governance/`, `FRC Reports/` |
| Qualsiasi | Con libro soci / share register | `share register.xlsx` in Revisione |

### Bozza iniziale del PROCESSO_REVISIONE.md

```markdown
# PROCESSO REVISIONE [NOME SOCIETA]

Questo file è lo stato incrementale del lavoro di revisione.
Va aggiornato a ogni ripresa significativa del lavoro.
I dettagli storici delle singole esecuzioni vanno messi in
`Revisione/LOG_AGENTI/`.

## Identificazione

- **Società**: [NOME]
- **Giurisdizione**: [IT / DE / FR / US / UK / CH / ...]
- **Tipo**: [TIPO] (sicurezza: alta/media/bassa)
- **Mandato**: [MANDATO]
- **Settore**: [SETTORE]
- **Esercizio corrente**: [AAAA]
- **Fonti normative preferite**: [standard / fonti specifiche fornite dall'utente]

## Calendario verifiche

[Descrizione: ogni quanto si fanno le verifiche, cosa produrre,
in base a giurisdizione e mandato.]

| Periodo | Documento | Scadenza prevista | Stato |
|---------|-----------|-------------------|-------|
| Q1 | [tipo documento] | [data] | da fare |
| Q2 | [tipo documento] | [data] | da fare |
| Q3 | [tipo documento] | [data] | da fare |
| Q4/chiusura | [documento annuale] | [data] | da fare |

## Stato al [YYYY-MM-DD]

[Nuova società. Struttura creata, nessun documento ancora prodotto.]

## File log collegati

(nesuno)

## Documenti completati

(nesuno)

## Modelli corretti

[Se trovati durante scan, elencarli.]

## Documenti da non modificare senza motivo

- [Da compilare dopo prima sessione.]

## Mancanze aperte

- Documenti non ancora acquisiti.
- Calendario verifiche da definire con precisione.
- [Altre mancanze specifiche.]

## Prossima ripresa lavoro

Quando arrivano nuovi documenti:
- Inserire nella cartella corretta sotto `Documenti acquisiti/`.
- Aggiornare i documenti interessati senza toccare quelli già validi.
- Aggiornare la sezione Stato con data nuova.
- Creare un nuovo file in `LOG_AGENTI/` con numero progressivo.

## Registro incrementale

### Log 001 — YYYY-MM-DD

Fatto:
- Struttura revisione creata.
- Processo di revisione definito e approvato.
- Prima scansione documentale completata.

Manca:
- (tutto, è l'inizio)
```

---

## Fase 4 — Presenta all'utente

Francesco mostra la bozza e dice:

> Ho analizzato [NOME SOCIETA].
> Secondo me è una [TIPO] con mandato [MANDATO] nel settore [SETTORE].
> Il processo di revisione che propongo prevede:
> - [N] verifiche all'anno
> - Documenti da produrre: [lista]
> - Struttura cartelle: [lista]
>
> Il file PROCESSO_REVISIONE.md bozza è questo:
> [mostra contenuto]
>
> Cosa vuoi cambiare? (Tipo? Mandato? Frequenza? Documenti? Altro?)

Aspetta risposta. Applica le modifiche richieste.

Poi Francesco chiede preferenze fonti:

> Per la normativa di [GIURISDIZIONE] uso le fonti standard
> [elenco]. Hai fonti particolari che preferisci?
> (Es. portale regionale, rivista settoriale, banca dati specifica)
>
> Se non sai o non ti interessa, dico "standard" e vado avanti.

Se l'utente da fonti → le salva in PROCESSO_REVISIONE.md
sotto `Fonti normative preferite`. Se dice "standard" → non scrive nulla.

Poi:

> PROCESSO_REVISIONE.md è corretto così? Confermi e salvo?

Se sì → salva. Se no → ripeti.

---

## Fase 5 — Salva e inizia

Dopo approvazione:

1. Crea la struttura directory (se non esiste già)
2. Crea `AGENTS.md` con regole base (se non esiste)
3. Salva `PROCESSO_REVISIONE.md` approvato
4. Crea `Date [NOME].xlsx` vuoto o con calendario base (se non esiste)
5. Esegui preflight normativa (`commands/normativa.md#preflight`)
6. Scrivi `LOG_AGENTI/` log 001 di inizializzazione
7. Conferma all'utente: "Pronto. Prossimo passo: partire con la prima revisione."

---

## Note

- Non sovrascrivere `PROCESSO_REVISIONE.md` se esiste già (sessione in corso).
- Non inventare tipo società o mandato. Se non certo, chiedi.
- Se l'utente dice "tipo X" ma i documenti dicono Y → fai notare la discrepanza.
