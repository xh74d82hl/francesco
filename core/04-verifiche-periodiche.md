# 04 — Verifiche periodiche

Le verifiche ricorrenti dipendono da mandato, giurisdizione, ente e calendario
approvato. Non esiste un calendario universale: registra quello concordato e
aggiorna lo stato dopo ogni verifica.

---

## 1. Calendario

In `piano-revisione.md`:

| Verifica | Frequenza | Prossima data | Responsabile | Stato |
|---|---|---|---|---|
| Cassa | concordata | | | |
| Riconciliazione banche | mensile/trimestrale | | | |
| Inventario fisico | annuale | | | |
| Verifica contributi/personale | periodica | | | |
| Verifica tributi | periodica | | | |
| Revisione bilanci intermedi | se prevista | | | |
| Eventi successivi | chiusura | | | |

Se il mandato prevede verifiche trimestrali, scrivilo. Se non le prevede, non
inventarle.

### Esempi di cadenza (da confermare, non imporre)

| Contesto | Cadenza tipica | Note |
|---|---|---|
| Ente pubblico / ASP con verifica di cassa | trimestrale o secondo regolamento | conteggio e verbale |
| Società con revisione legale annuale | interim + chiusura | verifiche su cicli significativi |
| Società quotata / EIP | semestrale + chiusura | revisione limitata interim |
| Piccola società / revisione volontaria | chiusura | perimetro concordato |
| Incarico limitato (solo cassa o banca) | secondo accordo | rapporto su procedure concordate |

La tabella è un punto di partenza: la fonte è il mandato, non questo file.

---

## 2. Verifica di cassa

1. Chiedi il fondo cassa contabile e la consistenza fisica alla data.
2. Se possibile, chiedi un conteggio a sorpresa o la riconciliazione firmata.
3. Confronta: contabile vs fisico vs giustificativi (ricevute, scontrini,
   anticipi).
4. Verifica:
   - ammanchi/eccedenze e relativa spiegazione;
   - assegni, carte prepagate, fondi spese;
   - movimenti non giustificati;
   - firme e autorizzazioni;
   - arrotondamenti sistematici.
5. Registra in `CL-###` con data, ora, presenti, importi, differenza.
6. Se la differenza supera la soglia → `F-###` e chiedi spiegazione scritta.

Mai "aggiustare" la cassa per far quadrare. La differenza è un dato.

---

## 3. Riconciliazione bancaria

Per ogni conto:

1. Saldo contabile a data X.
2. Saldo estratto conto a data X.
3. Movimenti solo banca (non contabilizzati).
4. Movimenti solo contabilità (transitanti: assegni, bonifici, effetti).
5. Differenze di importo o segno.
6. Commissioni, interessi, bolli, valuta estera.
7. Duplicati e storni.

Formula:

```
saldo contabile
+ movimenti solo contabilità non ancora in banca
− movimenti solo banca non ancora in contabilità
= saldo estratto conto
```

Differenza ≠ 0 → indaga e documenta. Non forzare la quadratura.

Dettaglio operativo in `core/06-controlli-sostanza.md` e nella carta
`templates/wiki/carte-lavoro/banche.md`.

---

## 4. Inventario fisico

- Presenzia o chiedi il verbale di conteggio.
- Verifica: esistenza, condizioni, obsolescenza, ubicazione, titolo.
- Confronta conteggio vs contabilità vs magazzino.
- Testa item a rotazione e item a rischio (alto valore, lento movimento).
- Cut-off: merce in transito, ricevuta non fatturata, spedita non fatturata.
- Documenta metodi, campioni, risultati ed eccezioni.

---

## 5. Personale e contributi

- Riconcilia libro unico / payroll vs costo del personale a bilancio.
- Verifica competenza, ratei, ferie, premi, TFR/fondi.
- Controlla contributi e ritenute: pagamenti, F24, scadenze.
- Testa dipendenti "fantasma", pagamenti a familiari, benefit, parti correlate.
- Verifica contratti e coerenza con il settore.

---

## 6. Tributi

- Imposte correnti: calcolo su risultato fiscale, riprese, aliquote.
- Imposte differite: differenze temporanee, recuperabilità.
- IVA/VAT: liquidazioni, versamenti, credito, rimborsi.
- Ritenute e contributi.
- Contestazioni, avvisi, contenzioso: fondi e disclosure.
- Scadenze e sanzioni potenziali.

Non sostituirti al consulente fiscale: verifica coerenza e documenta i limiti.

---

## 7. Parti correlate e operazioni societarie

- Identifica le parti correlate (soci, amministratori, gruppo, familiari).
- Cerca operazioni: acquisti/vendite, finanziamenti, garanzie, locazioni.
- Verifica condizioni di mercato, autorizzazioni, disclosure.
- Verifica aumenti di capitale, dividendi, fusioni, cessioni.
- Testa la completezza con visure, verbali, contabilità, estratti.

---

## 8. Continuità aziendale ed eventi successivi

- Leggi il piano industriale e i flussi di cassa previsti.
- Verifica covenant, linee di credito, scadenze, garanzie.
- Analizza perdite, patrimonio netto, liquidità.
- Eventi successivi alla chiusura: contratti, cause, danni, ristrutturazioni.
- Se ci sono dubbi significativi, chiedi rappresentazioni scritte e valuta
  l'impatto sulla relazione.

---

## 9. Documentazione della verifica

Ogni verifica produce:

1. Una carta di lavoro `CL-###` (template in `templates/wiki/carte-lavoro/`).
2. Un aggiornamento a `INDEX.md` (data, esito, prossima verifica).
3. Eventuali `F-###` per eccezioni.
4. Una riga nel registro attività.
5. Aggiornamento del calendario in `piano-revisione.md`.

---

## 10. Gate

Prima di chiudere una verifica:

- [ ] Data e ora della verifica registrate.
- [ ] Fonti citate.
- [ ] Importi ricalcolati.
- [ ] Differenze spiegate o a finding.
- [ ] Documento prodotto e leggibile.
- [ ] Utente informato e conferma ricevuta (se richiesta dal mandato).
- [ ] Prossima scadenza aggiornata.
