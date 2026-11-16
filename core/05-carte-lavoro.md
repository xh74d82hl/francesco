# 05 — Carte di lavoro

La carta di lavoro è la prova che una procedura è stata pianificata, eseguita e
conclusa. Deve bastare a un revisore indipendente per capire cosa hai fatto e
perché.

Formato: Markdown per il lavoro, HTML self-contained per la stampa.

---

## 1. Struttura obbligatoria

```markdown
---
id: CL-004
entity: Casa di Riposo Esempio
period: 2025
area: Ricavi
assertions: [occorrenza, cut-off]
risk: R-001
status: bozza            # bozza | in revisione | conclusa | bloccata
prepared_by: agente
prepared_at: 2026-11-16
reviewed_by:
reviewed_at:
sources: [D-003, D-007]
---

# CL-004 — Test cut-off ricavi

## 1. Obiettivo
Verificare che i ricavi 2025 siano registrati nel periodo di competenza.

## 2. Perimetro e assertioni
- Periodo: 01/01/2025–31/12/2025
- Assertioni: occorrenza, cut-off
- Rischio collegato: R-001
- Controllo collegato: C-001

## 3. Fonti
| ID | Documento | Pagina/sezione |
|---|---|---|
| D-003 | Bilancio 2025 | p. 12, 18 |
| D-007 | Registro fatture dicembre | righe 1–420 |

## 4. Procedura
1. ...
2. ...
3. ...

## 5. Campione
- Popolazione:
- Metodo:
- Dimensione:
- Criteri:
- Elenco:

## 6. Risultati
| Test | Atteso | Rilevato | Esito |
|---|---|---|---|
| ... | ... | ... | OK / eccezione |

## 7. Eccezioni
| # | Descrizione | Importo | Fonte | Impatto | Finding |
|---|---|---|---|---|---|
| 1 | ... | ... | ... | ... | F-002 |

## 8. Conclusione
- Esito: soddisfacente / con eccezioni / non soddisfacente
- Motivazione:
- Impatto sulla relazione:
- Follow-up:

## 9. Sign-off
- Preparato da: agente, 2026-11-16
- Revisionato da:
- Conferma utente: sì/no, data
```

Campi minimi: ID, ente, periodo, area, assertioni, rischio, fonti, procedura,
risultati, eccezioni, conclusione, stato, firme.

---

## 2. Ciclo di vita

| Stato | Significato | Transizione |
|---|---|---|
| `bozza` | impostata, non eseguita | dopo pianificazione |
| `in revisione` | eseguita, da verificare | dopo risultati |
| `conclusa` | verificata e confermata | dopo gate utente/reviewer |
| `bloccata` | manca una fonte o una decisione | quando il gap è critico |

Regole:

- Non passare a `conclusa` senza aver letto i risultati e le eccezioni.
- Una carta `conclusa` non si modifica: si aggiunge una nota datata.
- Se cambia la conclusione, crea una nuova versione e registra `supersede`.

---

## 3. Evidenze

Tipi ammessi:

- documento con pagina/sezione;
- tabella o CSV prodotto;
- calcolo ricalcolato (mostra formula e input);
- conferma esterna (data, mittente, contenuto);
- osservazione fisica (data, luogo, presenti);
- dichiarazione della direzione (data, firmatario);
- analitica (periodo, dati, spiegazione).

Per ogni evidenza: ID fonte, cosa prova, limiti. "Ho visto il file" non è
un'evidenza sufficiente: serve cosa contiene e perché è rilevante.

---

## 4. Campionamento

Zero dipendenze: il campione si documenta, non si genera con librerie.

Metodi:

- **Casuale semplice:** elenca la popolazione, assegna numeri, estrai con un
  metodo dichiarato (anche sorteggio manuale registrato).
- **Sistematico:** intervallo = popolazione / dimensione, punto di partenza
  dichiarato.
- **Mirato:** seleziona items per rischio, importo, anomalia, related party.
- **Tutti:** per popolazioni piccole o aree critiche.

Documenta sempre: popolazione, dimensione, metodo, criteri, risultato,
proiezione (se applicabile). Non dichiarare un campione statistico se non lo è.

---

## 5. Revisione interna

Prima di chiudere:

1. **Aderenza:** la procedura risponde al rischio e all'assertion?
2. **Calcolo:** i totali sono ricalcolati? Le formule sono visibili?
3. **Fonti:** ogni numero ha una fonte? Le pagine sono corrette?
4. **Eccezioni:** tutte valutate? Hanno un finding o una spiegazione?
5. **Conclusione:** coerente con i risultati? Non più ampia delle evidenze?
6. **Coerenza:** la Wiki e la relazione dicono la stessa cosa?

Se un punto fallisce, torna in `bozza`/`in revisione` e correggi.

---

## 6. Conferma utente

Messaggio standard:

> "Ho chiuso la carta CL-004 (cut-off ricavi). Risultato: 3 eccezioni per
> € 12.400, tutte spiegate tranne una da € 4.100. Ho aperto il finding F-002.
> Confermi la conclusione 'con eccezioni' o vuoi che approfondisca?"

Solo dopo `sì` la carta passa a `conclusa`.

---

## 7. Export HTML

Per la stampa usa `templates/output/carta-lavoro.html`:

- sostituisci i segnaposto `{{...}}`;
- mantieni il CSS `@media print` incorporato;
- verifica che le tabelle non si spezzino male e che l'header si ripeta;
- salva in `output/CL-004.html` (nome libero, ID dentro il documento).

Non serve Word. Il browser stampa in PDF con "Stampa → Salva come PDF".

---

## 8. Errori tipici

- Carta senza obiettivo o senza assertion.
- Procedura copiata da un'altra area.
- Risultati senza importi o senza fonte.
- Eccezioni non quantificate.
- Conclusione "OK" con eccezioni aperte.
- Sign-off mancante.
- Carta chiusa senza conferma.
