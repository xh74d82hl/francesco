# commands/inizializza — Commissionamento revisione: analisi + proposta

Francesco non impone un template fisso. Scansiona la società, la capisce,
propone un processo di revisione su misura, lo fa approvare dall'utente,
poi lo segue.

---

## Flusso

```
Scan  →  Identifica  →  Propone  →  Utente approva  →  Salva e inizia
```

---

## Fase 1 — Scan

Scansiona la directory della società per capire cosa c'è già.

Cosa cercare:
- Nome della cartella (indizio sul tipo: "ASP", "SPA", "SRL", "sportiva"?)
- `Statuto/` o file statuto (PDF/DOCX) → tipo societario
- `Visura/` o file visura → tipo, ATECO, dati camerali
- `Bilanci/` → esercizi già depositati
- `Verbali soci/` o `Verbali cda/` → governance
- `Revisione/` già esistente? Se sì → carica stato, non ri-inizializzare
- `Documenti statutari/` → statuto, atto costitutivo, nomine
- File `.xlsx` con nome "Date*" → calendario verifiche già esistente?

Output della scansione:

| Indizio | Cosa rivela |
|---------|-------------|
| "ASP" nel nome | Ente pubblico, D.Lgs. 118/2011 art. 14 |
| "SPA" / "S.P.A." nel nome | Società per azioni, Codice Civile |
| "SRL" / "S.R.L." nel nome | Responsabilità limitata, Codice Civile |
| "sportiva" / calcio / FIGC | Settore sportivo, D.Lgs. 36/2021, NOIF |
| "cooperativa" / "coop" | D.Lgs. 220/2002 (Basevi) |
| Bilanci depositati | Esercizi chiusi, dati dimensionali |

---

## Fase 2 — Identifica

### Tipo societario

Usa gli indizi della scansione. Se non certo:

```
Tipo non documentato. Ipotesi: [TIPO] per [motivo].
Da verificare su visura/statuto.
Chiedi: "Che tipo di società è? (ASP/SPA/SRL/cooperativa/sportiva/altro)"
```

### Mandato

Cerca in:
- `AGENTS.md` esistente
- `Documenti statutari/` → nomine, delibere
- `Revisione/Documenti da tenere/` → lettera incarico, attestazioni
- Nome cartella revisione, log esistenti

Opzioni:

| Mandato | Indizi |
|---------|--------|
| **Revisore unico / Organo di revisione** | Ente pubblico (ASP, comune), D.Lgs. 118/2011 |
| **Sindaco unico** | SRL, nomina singola, statuto |
| **Collegio sindacale** | SPA, obbligo collegiale per legge |
| **Revisore legale + Collegio** | SPA con revisione legale affidata al collegio o esterna |

### Settore

Dedurre da ATECO (visura) o da nome attività.

Esempi:
- "Casa di Riposo" → assistenza anziani, RSA
- "Gubbio" + calcio → sportivo, FIGC
- "Romeoauto" → automotive, concessionaria
- Senza indizi → chiedi all'utente

---

## Fase 3 — Propone processo di revisione

Francesco compila una bozza di `PROCESSO_REVISIONE.md` basata su:

### Per ogni tipo società + mandato, la checklist base

| Tipo | Mandato | Documenti da produrre | Frequenza |
|------|---------|----------------------|-----------|
| **ASP** | Revisore unico | Verifiche di cassa trimestrali + Verbale art. 14 annuale | Trimestrale |
| **SRL** | Sindaco unico | Verbali periodici di verifica contabile + Relazione al bilancio | Trimestrale |
| **SPA** | Collegio sindacale | Verbali periodici collegio + Relazione al bilancio (unitaria se anche rev. legale) | Trimestrale |
| **SPA** | Collegio + Rev. legale separata | Verbali collegio + Relazione rev. legale + Relazione unitaria | Trimestrale |
| **Sportiva** | Sindaco unico | Verbali periodici + FIGC/COVISOC + relazione sportiva | Trimestrale + FIGC |
| **Cooperativa** | Revisore/Sindaco | Verbali periodici + Revisione coop (D.Lgs. 220/2002) | Trimestrale |

### Aggiunte per settore specifico

| Settore | Documenti extra |
|---------|----------------|
| **Assistenza anziani / RSA** | Accrediti, L.R. sanità, requisiti strutture |
| **Calcio** | NOIF FIGC, covisoc, calciatori, campionato, parti correlate |
| **Automotive** | Concessioni, autoriparazione, F24, inventario, riconciliazioni |
| **Immobiliare** | Cedolare secca, IMU, contratti locazione |
| **Commercio** | Registri IVA, e-commerce, obblighi camerali |

### Struttura cartelle da creare

Base comune (sempre):

```
Revisione/
  PROCESSO_REVISIONE.md
  LOG_AGENTI/
  Verbali/
  Documenti acquisiti/
  Documenti da tenere/
```

Extra per tipo:

| Se... | Aggiungi |
|-------|----------|
| ASP / ente pubblico | `verifica di cassa/` con sottocartelle anno |
| Sportiva | Niente extra (usa Verbali/) |
| Qualsiasi con libri sociali | `utilizzo pagine libro.xlsx` |

### Bozza iniziale del PROCESSO_REVISIONE.md

```markdown
# PROCESSO REVISIONE [NOME SOCIETA]

Questo file è lo stato incrementale del lavoro di revisione.
Va aggiornato a ogni ripresa significativa del lavoro.
I dettagli storici delle singole esecuzioni vanno messi in
`Revisione/LOG_AGENTI/`.

## Identificazione

- **Società**: [NOME]
- **Tipo**: [TIPO] (sicurezza: alta/media/bassa)
- **Mandato**: [MANDATO]
- **Settore**: [SETTORE]
- **Esercizio corrente**: [AAAA]

## Calendario verifiche

[Descrizione: ogni quanto si fanno le verifiche, cosa produrre.]

| Periodo | Documento | Scadenza prevista | Stato |
|---------|-----------|-------------------|-------|
| Q1 | [tipo verbale] | [data] | da fare |
| Q2 | [tipo verbale] | [data] | da fare |
| Q3 | [tipo verbale] | [data] | da fare |
| Q4/chiusura | [verbale annuale] | [data] | da fare |

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
