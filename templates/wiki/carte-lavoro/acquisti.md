---
id: CL-___
entity: "{{ENTE}}"
period: "{{PERIODO}}"
area: Acquisti e costi
assertions: [completezza, occorrenza, accuratezza, cut-off, classificazione]
risk: R-___
status: bozza
prepared_by: agente
prepared_at: "{{DATA}}"
sources: []
---

# CL-___ — Acquisti, costi e debiti

## Obiettivo
Verificare completezza, competenza e corretta classificazione di costi e debiti.

## Fonti
- Bilancio e nota integrativa
- Registro fatture passive
- Contratti e ordini
- Estratti conto pagamenti
- Solleciti, estratti conto fornitori, partite aperte
- Fatture ricevute dopo la chiusura

## Procedura
1. Riconcilia costo del bilancio con registro fatture e partite aperte.
2. Testa il cut-off: fatture di competenza non registrate, merce ricevuta.
3. Verifica fatture duplicate, note di credito, sconti.
4. Testa fornitori significativi e parti correlate.
5. Verifica capitalizzazioni improprie (costi patrimonializzati).
6. Verifica debiti non registrati tramite pagamenti successivi e solleciti.
7. Analizza costi per natura e variazioni.
8. Applica Benford/pattern se adatto.

## Risultati
| Test | Popolazione | Campione | Eccezioni | Importo | Esito |
|---|---|---|---|---|---|
| Cut-off | | | | | |
| Completezza debiti | | | | | |
| Duplicati | | | | | |
| Classificazione | | | | | |

## Eccezioni
| # | Descrizione | Importo | Fonte | Finding |
|---|---|---|---|---|
| | | | | |

## Conclusione
- Esito:
- Motivazione:
- Impatto:
- Follow-up:

## Sign-off
- Preparato da: agente, {{DATA}}
- Conferma utente: no
