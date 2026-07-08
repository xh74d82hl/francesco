# commands/inizializza — Setup struttura revisione per nuova societa

Flusso per creare la struttura di revisione da zero per una nuova societa.

---

## Cosa crea

```
[cartella-societa]/
  AGENTS.md                    — regole per l'agente
  Revisione/
    PROCESSO_REVISIONE.md       — stato iniziale
    LOG_AGENTI/                 — vuoto, pronto
    verifica di cassa/          — vuoto, pronto
    Verbali/                    — vuoto, pronto
    Documenti acquisiti/        — vuoto, pronto
```

## Procedura

1. Chiedi all'utente: nome societa, tipo (ASP/SPA/SRL/coop/sportiva), settore.
2. Se non sa il tipo → ipotesi basata su nome, segna "da verificare".
3. Crea struttura directory.
4. Crea `AGENTS.md` con regole base dal tipo societario.
5. Crea `Revisione/PROCESSO_REVISIONE.md` con il template sottostante.
6. Esegui preflight normativa (vedi `commands/normativa.md#preflight`).
7. Scrivi log di inizializzazione.

## Template PROCESSO_REVISIONE.md

Questo è il file che Francesco crea e mantiene per ogni società. Va aggiornato a ogni sessione sostanziale (revisione, check, triage).

```markdown
# Processo di Revisione — [NOME SOCIETA]

## Dati Identificativi

- **Societá**: [NOME]
- **Tipo**: [ASP / SPA / SRL / cooperativa / sportiva / N.d.]
- **Settore ATECO**: [codice] — [descrizione]
- **Mandato**: [revisore legale / sindaco unico / collegio sindacale]
- **Esercizio in corso**: [AAAA]
- **Data apertura revisione**: [YYYY-MM-DD]

## Stato Documentazione

| Area | Stato | Ultimo aggiornamento |
|------|-------|----------------------|
| Verifiche di cassa | [completo / parziale / da iniziare] | [data] |
| Verbali art. 14 | [completo / parziale / da iniziare] | [data] |
| Verbali insediamento | [completo / parziale / da iniziare] | [data] |
| Documenti acquisiti | [completo / parziale / da iniziare] | [data] |

## Log Sessioni

| Data | Cosa fatto | Chi | Note |
|------|-----------|-----|------|
| [YYYY-MM-DD] | [riassunto] | Francesco | [link log] |

## Mancanze Aperte

- [ ] [descrizione mancanza] — [prioritá: alta/media/bassa]
- [ ] [prossima mancanza]

## Dati Dimensionali (da aggiornare a ogni esercizio)

| Dato | 2022 | 2023 | 2024 |
|------|------|------|------|
| Totale attivo | N.d. | N.d. | N.d. |
| Totale ricavi | N.d. | N.d. | N.d. |
| Dipendenti medi | N.d. | N.d. | N.d. |
| Note | | | |

## Note Generali

- [annotazioni libere]
```

Compila i campi noti. Segna `N.d.` dove non hai ancora il dato. Mai inventare.
