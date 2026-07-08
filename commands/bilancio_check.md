# commands/bilancio_check — Controlli di bilancio (il comando "check")

**Chiamato da:** `skills/francesco-bilancio/SKILL.md` (Step 5), dall'orchestratore `SKILL.md`
quando l'utente dice "check bilancio" / "benford" / "quadratura", o da `francesco-revisione`
per validare i numeri dei verbali/relazioni.
**Standalone:** se chiamato diretto, fa preflight rapido all'inizio.

Controlla che lo stato patrimoniale quadri, la CE torni, la nota integrativa si agganci,
le scelte contabili siano coerenti e applica i test anti-manipolazione (Benford + pattern).

Token: stile compresso durante estrazione/OCR/controlli. Leggibile per warning, report, log.

---

## Preflight rapido (solo se standalone)

1. `Revisione/` esiste? → no: "Società non inizializzata."
2. `Bilanci/` o fonti disponibili? → no: "Nessun bilancio. Acquisisci prima (vedi francesco-bilancio Step 2)."
3. Carica stato: PROCESSO_REVISIONE.md + ultimo log.

---

## Step 1 — Estrai i numeri

Da `Bilanci/` / `Documenti acquisiti/` (XLSX via skill xlsx, PDF via docling):

- Stato patrimoniale: voci attivo (A) e passivo (P) con totali.
- Conto economico: voci e subtotali (VP, costi, ro, ebit, ebt, utile).
- Nota integrativa: tabelle di dettaglio (immobilizzazioni, crediti, debiti, tfr, imposte).

Salva tutto in `Revisione/bilancio_check_[ANNO].xlsx` (uno sheet per schema) preservando
importi e formato. **Mai sovrascrivere il bilancio originale.**

---

## Step 2 — Quadratura (i numeri tornano?)

| Controllo | Formula | Soglia |
|-----------|---------|--------|
| SP attivo = passivo | `ΣA − ΣP` | 0,00 |
| SP subtotali | ogni subtotale = somma righe figlie | 0,00 |
| CE risultato | `VP − Costi` = Risultato | 0,00 |
| CE subtotali | ro = vp − costi produzione; ebit = ro ± proventi/oneri; ebt = ebit ± imposte | 0,00 |
| Nota → SP | immobilizzazioni nette nota = voce SP; tfr nota = tfr SP | 0,00 |
| Nota → CE | imposte nota = imposte CE; ammortamenti nota = ammortamenti CE | 0,00 |
| Totale fonti = impieghi (riclass.) | solo se fai CEF | 0,00 |

Per ogni scarto ≠ 0 → segna importo esatto e voci coinvolte.

---

## Step 3 — Scelte contabili (cosa è stato deciso?)

Per ogni voce sotto, verifica **dichiarazione + coerenza anno/anno + applicazione**:

- Principi (OIC / IFRS / PCG / HGB / US GAAP / UK GAAP) e perimetro consolidamento.
- Criteri valutazione: costo vs recuperabile, fair value, LIFO/FIFO/costo medio, cambio (IAS 21 / OIC 26).
- Ammortamenti: aliquote e fondi coerenti col piano; confronto esercizio precedente.
- Accantonamenti (tfrr, rischi, sospesi) e imposte differite (IAS 12 / OIC 25).
- Ricavi: riconoscimento (IFRS 15 / OIC 15), contributi.
- Eventi successivi / continuità aziendale.

Output per voce: `OK` / `CAMBIATA: [effetto]` / `NON DOCUMENTATA`.

---

## Step 4 — Test anti-manipolazione {#benford}

> "Numeri fatti su?" — qui Francesco corre come un revisore paranoico.

### 4.1 — Legge di Benford (prima cifra)
1. Prendi tutti gli importi "significativi" (es. ≥ soglia, es. 1.000€; escludi totali/percentuali).
2. Prima cifra `d ∈ {1..9}` di ogni importo.
3. Frequenza osservata `f_obs(d)` vs attesa `P(d) = log₁₀(1 + 1/d)`:
   - P(1)=30,1% · P(2)=17,6% · P(3)=12,5% · P(4)=9,7% · P(5)=7,9%
   - P(6)=6,7% · P(7)=5,8% · P(8)=5,1% · P(9)=4,6%
4. **χ²** = `Σ (f_obs−f_att)² / f_att` su n campioni. Soglia critica χ²(8) ≈ 20,09 a p=0,01.
   Oppure **Z per digit** = `(f_obs−f_att)/√(n·f_att)`. |Z|>2,5 → digit anomalo.
5. Se χ² supera soglia (o ≥2 digit con |Z|>2,5) → **FLAG: possibile manipolazione**.
   Non è prova: segnala "pattern anomalo, consiglio verifica manuale su [voci]".

### 4.2 — Pattern sospetti complementari
- **Round-number bias**: % importi terminanti con `000`/`,00` eccessiva → possibile arrotondamento fittizio.
- **Duplicated amounts**: importi identici ripetuti in voci non collegate → copia/incolla.
- **Terminal-digit preference**: cluster anomalo su certe ultime cifre.
- **Threshold clustering**: picchi appena sotto soglie (es. 4.990 vs 5.000) → aggiramento autorizzazioni.

Ogni anomalia riporta: voce, importo, fonte, tipo di pattern. Nessuna accusa, solo flag.

---

## Step 5 — Output report

Salva in `Revisione/Documenti acquisiti/bilancio_check_[ANNO].md`:

```
## Bilancio check — [Società] — esercizio [ANNO]
- Data: YYYY-MM-DD
- Fonti: [N] file
- Principi: [OIC/IFRS/...]

### Quadratura
- SP attivo=passivo: OK / SCARTO [importo]
- CE risultato: OK / SCARTO [importo]
- Nota→SP/CE: OK / [voci scollegate]

### Scelte contabili
- [voce]: OK / CAMBIATA [effetto] / NON DOCUMENTATA

### Anti-manipolazione (Benford + pattern)
- Campioni: [N]
- χ²: [valore] (soglia 20,09) → OK / FLAG
- Digit anomali: [lista]
- Pattern sospetti: [lista]

### Verdetto
- OK / WARNING / BLOCCANTE
- Consigliato: [azione]
```

---

## Step 6 — Triplo check (ricorsivo)

Dopo il report, Francesco applica il triplo check orchestratore:
1. Esecuzione completata? 2. Verifica (numeri, fonti, Benford)? 3. Sicurezza (dubbio→chiedi)? 4. Rileggi ultimo log.

Poi torna al chiamante (bilancio o revisione) per chiusura sessione.
