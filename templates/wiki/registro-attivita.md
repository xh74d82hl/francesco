---
page: registro-attivita
entity: "{{ENTE}}"
period: "{{PERIODO}}"
status: attivo
updated: "{{DATA}}"
owner: agente
---

# Registro attività — {{ENTE}}

Append-only. Non cancellare righe. Una riga per ogni modifica rilevante.

Formato:

```
YYYY-MM-DDTHH:MM | attore | azione | pagine | fonti | esito
```

## Log

```
{{DATA}}T00:00 | agente | inizializzazione Wiki | tutte | — | ok
```

## Legenda

| Campo | Valori |
|---|---|
| attore | `agente`, `utente`, nome revisore |
| azione | `ingestione`, `estrazione`, `rischio`, `carta`, `finding`, `relazione`, `correzione`, `chiusura` |
| pagine | pagine Wiki toccate |
| fonti | ID `D-###` o `utente` |
| esito | `ok`, `dubbio`, `bloccato`, `corretto` |

## Controllo integrità

- [ ] Ogni modifica ha una riga.
- [ ] Le correzioni citano la voce precedente.
- [ ] Nessuna riga cancellata.
