# commands/struttura — Struttura canonica directory revisione

Template unico per tutte le societa. Francesco crea all'inizializzazione
e verifica a ogni sessione. Variazioni solo per giurisdizione/tipo.

---

## Struttura base (root della societa)

```
<NOME_SOCIETA>/
  AGENTS.md                     ← regole agente specifiche per questa societa
  Bilanci/                      ← bilanci depositati per esercizio
  Documenti statutari/          ← statuto, atto costitutivo, nomine, visura
  Documenti appunti/            ← note, appunti, verbali informali
  Pratiche varie/               ← altre pratiche non classificabili
  normative/                    ← archivio normativo personale (per paese/tipo/settore)
  Revisione/
    PROCESSO_REVISIONE.md       ← stato incrementale, calendario, mancanze, fonti preferite
    Date <NOME>.xlsx            ← scadenze verifiche
    LOG_AGENTI/                 ← log append-only di ogni sessione
      YYYY-MM-DD_log_NNN_descrizione.md
    Verbali/
      <ANNO>/                  ← verbali per anno di competenza
      insediamento e accettazione/
      appunti_verbali.txt
    verifica di cassa/          ← solo per ASP / enti pubblici / casse
      <ANNO>/
      Modelli/
    Documenti acquisiti/        ← fonti ricevute da ente, tesoriere, banca
    Documenti da tenere/        ← lettera incarico, attestazioni, nomine
```

La directory `Revisione/` e il cuore. Tutto il lavoro di revisione sta li.

---

## Variazioni per giurisdizione / tipo

| Giurisdizione | Se... | Cartella extra |
|--------------|-------|----------------|
| Italia | ASP / ente pubblico | `verifica di cassa/` (con sottocartelle anno + Modelli/) |
| Germania | AG / GmbH | `Prüfungsberichte/` per anno |
| Francia | SA / SAS | `Rapports CAC/` per anno |
| USA | Public company | `SEC Filings/`, `SOX Controls/` |
| UK | PLC | `Corporate Governance/`, `FRC Reports/` |
| Qualsiasi | Con libro soci / share register | `share register.xlsx` nella root Revisione |
| Qualsiasi | Con libri sociali / verbali libro | `utilizzo pagine libro.xlsx` in Revisione |

---

## Convenzioni nomi file

- **Log**: `YYYY-MM-DD_log_NNN_descrizione.md` (NNN progressivo, 001, 002...)
- **Verbali**: `[NOME]_[GGMMAAAA].docx` o `[AAAA]_[trimestre]_[tipo].docx`
- **Verifiche cassa**: `[MM_AAAA].docx` o `[trimestre]_[ANNO].docx`
- **Date**: `Date [NOME SOCIETA].xlsx` — stesso nome della cartella societa
- **PROCESSO_REVISIONE**: sempre `PROCESSO_REVISIONE.md`, mai rinominare

---

## Cosa Francesco verifica a ogni sessione (preflight struttura)

1. La directory `Revisione/` esiste
2. `Revisione/PROCESSO_REVISIONE.md` esiste e si apre
3. `Revisione/LOG_AGENTI/` esiste
4. `Revisione/Verbali/` esiste (con almeno `insediamento e accettazione/`)
5. `Revisione/Documenti acquisiti/` esiste
6. `Revisione/Documenti da tenere/` esiste
7. `normative/` esiste (se no → avvisa ma non blocca)
8. I log in `LOG_AGENTI/` seguono la convenzione `YYYY-MM-DD_log_NNN_*.md`

Se manca una directory essenziale → segnala all'utente:
> "Manca [CARTELLA] nella struttura di [NOME].
> La creo?"

Se l'utente dice si → crea. Se dice no → segna come mancanza in PROCESSO_REVISIONE.md.

La verifica struttura e parte del triplo check: al 2° giro (verifica),
Francesco controlla che la struttura sia ancora integra e che i nuovi
documenti siano stati salvati nelle cartelle giuste.
