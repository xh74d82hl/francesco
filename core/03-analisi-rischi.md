# 03 — Analisi dei rischi e piano di risposta

Scopo: identificare dove il bilancio può essere materialmente errato — per
errore o frode — e decidere come rispondere. Il risultato vive in
`rischi-controlli.md`.

---

## 1. Modello

```
Rischio = probabilità × impatto
Rischio di revisione = rischio inerente × rischio di controllo × rischio di individuazione
```

Non serve un numero preciso: serve una graduatoria motivata e una risposta.

Per ogni rischio registra:

- ciclo/area e assertioni coinvolte;
- fattori di rischio inerente;
- controlli esistenti e loro affidabilità;
- rischio significativo sì/no;
- risposta prevista (test di controllo, sostanza, entrambi);
- carta di lavoro collegata;
- stato.

---

## 2. Aree da coprire

| Ciclo | Esempi di rischio |
|---|---|
| Ricavi | riconoscimento, cut-off, resi, parti correlate, contratti complessi |
| Acquisti e costi | competenza, fatture non registrate, capitalizzazioni improprie |
| Personale | competenza, contributi, fondi, benefit, parti correlate |
| Magazzino | esistenza, valutazione, obsolescenza, inventario fisico |
| Immobilizzazioni | esistenza, ammortamenti, impairment, titolo |
| Crediti | recuperabilità, svalutazione, cessione, conferme |
| Debiti e finanziamenti | completezza, covenant, interessi, garanzie |
| Cassa e banche | esistenza, riconciliazione, cut-off, firme |
| Tributi | imposte correnti/differite, accantonamenti, contestazioni |
| Patrimonio netto | movimenti, riserve, dividendi, aumenti |
| Continuità aziendale | liquidità, covenant, piani, eventi successivi |
| Frode | ricavi fittizi, override della direzione, collusione, appropriazione |
| IT e controlli generali | accessi, cambi, backup, segregazione |

Aggiungi rischi specifici del settore (sanità, sport, finanza, immobiliare,
manifatturiero, non-profit).

---

## 3. Assertioni

Per le voci di bilancio:

- **esistenza / occorrenza**
- **completezza**
- **accuratezza / valutazione**
- **diritti e obblighi**
- **cut-off**
- **classificazione e presentazione**
- **comprensibilità**

Per le disclosure: completezza, accuratezza, presentazione.

Ogni rischio deve indicare almeno un'assertion. Una carta di lavoro senza
assertion è un controllo generico, non una risposta di revisione.

---

## 4. Rischi di frode presunti

Considera sempre, salvo motivata esclusione:

1. **Riconoscimento ricavi** — contratti, resi, fatture a fine periodo,
   operazioni con parti correlate.
2. **Override della direzione** — scritture manuali, stime, aggiustamenti di
   chiusura, related party.
3. **Appropriazione di beni** — cassa, magazzino, incassi, pagamenti.

Documenta:

- perché il rischio è presente o escluso;
- procedure imprevedibili (test a sorpresa, campioni casuali, verifica fisica);
- journal entry testing: scritture fuori orario, importi tondi, utenti anomali,
  descrizioni generiche, reverse e repost.

---

## 5. Comprensione dei controlli

Per i controlli chiave:

- chi li esegue, con quale frequenza, con quale evidenza;
- segregazione dei compiti;
- controllo IT (accessi, cambi, elaborazioni);
- se sono stati testati e con quale esito.

Se non ti affidi ai controlli, dichiara "approccio sostanziale" e aumenta i
campioni. Non simulare un reliance che non hai testato.

---

## 6. Matrice rischio-controllo-risposta

In `rischi-controlli.md`:

| ID | Ciclo | Assertion | Rischio | Inerente | Controllo | Affidabile | Significativo | Risposta | Carta | Stato |
|---|---|---|---|---|---|---|---|---|---|---|
| R-001 | Ricavi | occorrenza | Fatture a fine periodo | alto | C-001 | no | sì | sostanza su cut-off | CL-004 | aperto |
| R-002 | Cassa | esistenza | Cassa fisica non quadra | medio | C-002 | parziale | no | conteggio a sorpresa | CL-002 | aperto |

La matrice deve stare in una sola tabella, leggibile. I dettagli vanno sotto,
per ID, con fonte e motivazione.

---

## 7. Risposta al rischio

| Rischio | Risposta minima |
|---|---|
| Significativo | procedure sostanziali mirate, campione più ampio, revisione senior |
| Frode ricavi | test su cut-off, contratti, resi, conferme, analitiche |
| Override direzione | journal entry testing, stime, related party, aggiustamenti |
| Continuità | piani, flussi, covenant, eventi successivi, management representation |
| Stima contabile | ricalcolo, confronto con anni precedenti, sensitività, esperto |
| Parte correlata | completezza, condizioni, disclosure, autorizzazioni |

Ogni risposta deve avere una carta di lavoro o un test identificabile.

---

## 8. Analitiche preliminari

Prima del fieldwork, calcola e commenta:

- variazioni anno/anno significative (> soglia definita);
- margini e indici chiave;
- rapporti insoliti (costi vs ricavi, personale vs fatturato, magazzino vs vendite);
- stagionalità e cut-off;
- cassa vs ricavi.

Le spiegazioni vanno chieste al management e registrate. Un'analitica non
spiegata diventa un rischio o un test.

---

## 9. Documentazione e gate

Aggiorna:

- `rischi-controlli.md` (registro + matrice);
- `piano-revisione.md` (risposte e tempi);
- `INDEX.md` (fase, rischi significativi, prossima azione);
- `registro-attivita.md`.

Gate:

```
[Francesco · Fase 2/8 · Rischi]
Rischi identificati: N | Significativi: N | Frode: N
Aree critiche: ...
Prossimo: verifiche e carte di lavoro
Confermi i rischi significativi e le risposte? (sì / aggiungi X)
```

Se l'utente aggiunge un rischio, registralo con un nuovo ID e aggiorna la
risposta. Non cancellare i rischi già valutati.
