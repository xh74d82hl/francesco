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
5. Crea `Revisione/PROCESSO_REVISIONE.md` con stato iniziale.
6. Esegui preflight normativa (vedi `commands/normativa.md#preflight`).
7. Scrivi log di inizializzazione.
