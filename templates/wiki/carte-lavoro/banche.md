---
id: CL-___
entity: "{{ENTE}}"
period: "{{PERIODO}}"
area: Banche
assertions: [esistenza, completezza, cut-off, valutazione]
risk: R-___
status: bozza
prepared_by: agente
prepared_at: "{{DATA}}"
sources: []
---

# CL-___ — Riconciliazione bancaria

## Obiettivo
Verificare che i saldi e i movimenti bancari siano completi, esistenti e
correttamente registrati.

## Fonti
- Estratti conto originali (PDF/CSV) per conto e periodo
- Contabilità banca / mastri / prima nota
- Conferme bancarie (se disponibili)
- Contratti di finanziamento e garanzie

## Procedura
1. Elenca tutti i conti e verifica la copertura del periodo.
2. Confronta saldo contabile e saldo estratto a data di chiusura.
3. Allinea i movimenti: data, descrizione, importo, segno.
4. Classifica: match, solo banca, solo contabilità, discorde.
5. Verifica commissioni, interessi, bolli, valuta estera, duplicati, storni.
6. Riconcilia con la formula:
   `saldo contabile + transitanti − unreconciled = saldo estratto`.
7. Verifica conti di transito e giroconti.
8. Se ci sono finanziamenti: verifica debito residuo, interessi, covenant.

## Riconciliazione
| Conto | Saldo contabile | Transitanti | Unreconciled | Saldo estratto | Differenza |
|---|---|---|---|---|---|
| | | | | | |

## Movimenti unreconciled
| Data | Descrizione | Importo | Tipo | Fonte | Azione |
|---|---|---|---|---|---|
| | | | | | |

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
