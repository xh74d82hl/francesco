# 06 — Controlli di sostanza e procedure analitiche

Qui si verifica se i numeri sono veri, completi e coerenti. Nessuna libreria:
formule esplicite, dati tracciabili, risultati ricalcolabili.

---

## 1. Quadratura del bilancio

| Controllo | Formula | Tolleranza |
|---|---|---|
| SP attivo = passivo | `Σ attivo − Σ passivo` | 0,00 |
| Subtotale SP | somma righe figlie = subtotale | 0,00 |
| CE | `valore produzione − costi produzione = risultato operativo` | 0,00 |
| CE subtotali | RO ± proventi/oneri = EBT; EBT − imposte = utile | 0,00 |
| Nota → SP | voce nota = voce SP | 0,00 |
| Nota → CE | voce nota = voce CE | 0,00 |
| Utile CE = utile SP | `utile CE − utile patrimonio netto` | 0,00 |
| Rendiconto / CF | saldo finale = saldo iniziale + flussi | 0,00 |

Per ogni scarto: importo esatto, voci coinvolte, fonte, possibile causa.
Non arrotondare per far quadrare.

---

## 2. Riconciliazione bancaria

Per ogni conto e periodo:

```
saldo contabile
+ movimenti contabili non ancora in banca (transitanti)
− movimenti bancari non ancora in contabilità (unreconciled)
= saldo estratto conto
```

Classificazione movimenti:

- **match** — data/descrizione/importo compatibili;
- **solo banca** — commissioni, interessi, addebiti, accrediti non registrati;
- **solo contabilità** — assegni emessi, bonifici in transito, effetti;
- **discorde** — importo o segno diverso.

Differenza ≠ 0: quantifica, elenca le voci sospette, chiedi conferma.
Attenzione a: duplicati, storni, valuta estera, giroconti, conti di transito.

---

## 3. Analitiche sostanziali

Costruisci tabelle comparative:

| Voce | 2025 | 2024 | Δ assoluto | Δ % | Spiegazione | Fonte |
|---|---|---|---|---|---|---|

Soglie di indagine (da concordare in `piano-revisione.md`):

- variazione assoluta > materialità di performance;
- variazione % > 10–15% su voci significative;
- margini fuori range storico;
- rapporto anomalo con driver (ricavi, ore, test, posti letto, contratti).

Un'analitica è conclusa solo quando la spiegazione è documentata o diventa un
test/finding.

---

## 4. Test di sostanza

### 4.1 Esistenza e diritti
- conferme esterne (banche, clienti, fornitori, legali);
- ispezione fisica;
- visure e certificati;
- documenti di titolarità.

### 4.2 Completezza
- ricerca di passività non registrate (fatture successive, solleciti, avvisi);
- cut-off acquisti e ricavi;
- riconciliazioni di sottoconti;
- test su conti sospesi e transitori.

### 4.3 Valutazione
- crediti: aging, incassi successivi, solvibilità, fondo svalutazione;
- magazzino: rotazione, obsolescenza, valore netto realizzo;
- immobilizzazioni: impairment, ammortamenti, vita utile;
- partecipazioni: patrimonio, risultati, impairment;
- fondi: congruità, eventi successivi, stime.

### 4.4 Presentazione
- classificazioni corrette;
- compensazioni vietate;
- disclosure complete e coerenti;
- comparativi allineati.

---

## 5. Stime contabili

Per ogni stima significativa:

1. comprendi il metodo della direzione;
2. verifica input e assunzioni;
3. ricalcola o confronta con metodo indipendente;
4. confronta con anni precedenti e risultati consuntivi;
5. valuta sensitività e bias;
6. documenta range e conclusione.

Esempi: svalutazione crediti, fondo rischi, TFR, imposte differite, fair value,
ammortamenti, fondo manutenzione, contenzioso.

---

## 6. Journal entry testing

Obiettivi: frode, override, errori di chiusura.

Seleziona scritture per:

- importo tondo o appena sotto soglia;
- data fuori orario/festivi;
- utenti con privilegi elevati;
- descrizioni generiche ("giroconto", "rettifica", "altro");
- reverse e repost;
- conti insoliti;
- parti correlate.

Per ogni scrittura: documento, autorizzazione, giustificazione, impatto.
Non è una prova di frode: è un test di anomalia.

---

## 7. Benford e pattern

Usa quando la popolazione è numerosa e adatta (importi eterogenei, più ordini
di grandezza). Non applicarlo a totali, percentuali, codici o dati con range
stretto.

### 7.1 Prima cifra

Attesi:

| d | P(d) |
|---|---|
| 1 | 30,1% |
| 2 | 17,6% |
| 3 | 12,5% |
| 4 | 9,7% |
| 5 | 7,9% |
| 6 | 6,7% |
| 7 | 5,8% |
| 8 | 5,1% |
| 9 | 4,6% |

Calcoli:

```
f_att(d) = P(d) × n
χ² = Σ (f_obs(d) − f_att(d))² / f_att(d)
Z(d) = (f_obs(d) − f_att(d)) / sqrt(n × P(d) × (1 − P(d)))
```

Soglie indicative:

- χ²(8) ≈ 20,09 a p = 0,01; ≈ 15,51 a p = 0,05.
- |Z| > 2,5 → cifra anomala.
- Popolazione minima consigliata: 100–300 importi; sotto, conclusioni prudenti.

### 7.2 Pattern complementari

| Pattern | Come si rileva | Cosa suggerisce |
|---|---|---|
| Round-number bias | % importi con finale `000`/`,00` | arrotondamenti fittizi, soglie |
| Duplicati | importi+data+descrizione identici | copia/incolla, doppio pagamento |
| Terminal digit | distribuzione ultima cifra | prezzi manipolati, arrotondamenti |
| Threshold clustering | picchi appena sotto soglie | aggiramento autorizzazioni |
| Weekend/festivi | date di registrazione | scritture di comodo |
| Numerazione | gap o duplicati | fatture mancanti |

Ogni anomalia: popolazione, numerosità, valore, fonte, spiegazione richiesta.
**Non accusare.** Scrivi "pattern anomalo, raccomandata verifica manuale".

### 7.3 Output CSV

```csv
test,popolazione,n,valore,soglia,esito,fonte
benford_prima_cifra,importi_mastri,420,chi2=18.4,20.09,ok,D-012
round_number,importi_mastri,420,0.63,0.60,flag,D-012
```

---

## 8. Cut-off

- ricavi: fatture emesse dopo la chiusura, merce spedita non fatturata, resi;
- acquisti: fatture ricevute dopo, merce ricevuta non fatturata;
- cassa/banche: valuta e data di registrazione;
- personale: competenze, premi, ferie;
- imposte: competenza dell'esercizio.

Documenta il test e l'eventuale aggiustamento proposto.

---

## 9. Report dei controlli

Salva in `wiki/carte-lavoro/CL-###.md` e, se serve, CSV in `output/`:

```
## Esito controlli — [ente] — [periodo]
- Quadratura SP/CE: OK / scarto ...
- Riconciliazioni: N conti, differenza ...
- Analitiche: N test, N spiegazioni mancanti
- Campioni: N, eccezioni N
- Benford: χ² ..., esito ...
- Pattern: ...
- Findings aperti: F-...
- Conclusione: soddisfacente / con eccezioni / non soddisfacente
```

---

## 10. Gate

- [ ] Tutti i totali ricalcolati.
- [ ] Ogni scarto quantificato e spiegato.
- [ ] Campioni documentati.
- [ ] Anomalie collegate a finding.
- [ ] Conclusione proporzionata alle evidenze.
- [ ] Conferma utente prima della chiusura.
