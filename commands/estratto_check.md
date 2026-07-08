# commands/estratto_check — Riconciliazione estratti conto

**Chiamato da:** `skills/francesco-estratto/SKILL.md` (Step 5), dall'orchestratore `SKILL.md`
quando l'utente dice "estratto conto" / "riconciliazione" / "check banca", o da
`francesco-bilancio` per agganciare la liquidità del bilancio agli estratti.
**Standalone:** se chiamato diretto, fa preflight rapido all'inizio.

Confronta movimenti banca vs contabilità, segnala incongruenze, riconcilia i saldi.

Token: stile compresso durante lettura/OCR/controlli. Leggibile per warning, report, log.

---

## Preflight rapido (solo se standalone)

1. `Revisione/` esiste? → no: "Società non inizializzata."
2. Estratto + contabilità disponibili? → no: "Acquisisci prima (vedi francesco-estratto Step 2)."
3. Carica stato: PROCESSO_REVISIONE.md + ultimo log.

---

## Step 1 — Carica le fonti

Da `Documenti acquisiti/` (XLSX/CSV via skill xlsx, PDF via docling):
- Estralti conto (per conto e per periodo).
- Contabilità banca: libro giornale / mastro / prima nota (colonne: data, descrizione, dare, avere).

Normalizza in `Revisione/estratto_check_[CONTO]_[ANNO].xlsx` (2 sheet: Esterno / Contabilità).
**Mai sovrascrivere le fonti originali.**

---

## Step 2 — Allinea i movimenti

Per ogni conto:
1. Ordina per data entrambi i lati.
2. Match su (data ≈, descrizione simile, importo + segno identico).
3. Classifica:
   - **Match**: presente in entrambi.
   - **Solo estratto** (unreconciled banca): in banca, non in contabilità.
   - **Solo contabilità** (transitanti): in contabilità, non ancora in banca.
   - **Discordi**: stessa-data/descrizione ma importo o segno diverso.

---

## Step 3 — Caccia incongruenze

Per ogni "solo estratto" / "discordi", classifica:
- Commissioni / bolli / interessi passivi non contabilizzati.
- Accrediti / interessi attivi non contabilizzati.
- Duplicati (stessa scrittura passata due volte).
- Errore di segno (incasso come uscita / viceversa).
- Valuta estera non riconvertita / arrotondamenti.

Ogni incongruenza riporta: data, descrizione, importo, lato, fonte.

---

## Step 4 — Riconciliazione saldo

```
Saldo contabilità
+ Solo contabilità (transitanti non ancora in banca)
− Solo estratto (in banca, non in contabilità)
= Saldo estratto
```

- Differenza = 0 → **OK**.
- Differenza ≠ 0 → segna importo esatto e voci unreconciled sospette.
- Ripeti per ogni conto; poi perimetro complessivo (somma conti).

---

## Step 5 — Incrocio cassa (opzionale)

Se `verifica di cassa/` esiste (ASP/enti pubblici):
- Liquidità contabile = cassa fisica + banca. Verifica coerenza.
- Segnala eventuali buchi tra contabile, fisico, bancario.

---

## Step 6 — Output report

Salva in `Revisione/Documenti acquisiti/estratto_check_[CONTO]_[ANNO].md`:

```
## Estratto check — [Società] — conto [BANCA] — [ANNO]
- Data: YYYY-MM-DD
- Fonti: estratto [file], contabilità [file]

### Riconciliazione
- Saldo contabilità: [importo]
- Solo contabilità (transitanti): [N] [importo]
- Solo estratto (unreconciled): [N] [importo]
- Saldo estratto: [importo]
- DIFFERENZA: 0,00 / [importo]

### Incongruenze
- [data] [descrizione] [importo] — [tipo]

### Verdetto
- OK / WARNING / BLOCCANTE
- Consigliato: [azione]
```

---

## Step 7 — Triplo check (ricorsivo)

1. Esecuzione completata? 2. Verifica (tutti i conti, fonti, differenze) ? 3. Sicurezza (dubbio→chiedi)? 4. Rileggi ultimo log.
Poi torna al chiamante per chiusura sessione.
