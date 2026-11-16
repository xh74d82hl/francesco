# 00 — Motore Wiki incrementale

La Wiki è la memoria di lavoro della revisione. Vive in Markdown, si legge a
occhi nudi, si aggiorna per aggiunta e non richiede database, server o schema
rigido.

Obiettivo: ogni fatto contabile o legale deve essere **rintracciabile** dalla
conclusione fino alla fonte, passando per risk, controllo e carta di lavoro.

---

## 1. Struttura logica

```
wiki/
  INDEX.md                 mappa del lavoro e stato
  contesto-ente.md         profilo e perimetro
  piano-revisione.md       strategia, materialità, tempi
  rischi-controlli.md      registro rischi e controlli
  mappa-documentale.md     inventario fonti e fatti
  richieste-documenti.md   PBC list e gap
  anomalie-findings.md     rilievi
  registro-attivita.md     audit trail append-only
  carte-lavoro/
    CL-001-....md
```

Questa è una **raccomandazione**. Se l'ente o l'utente ha già una struttura,
mappala in `INDEX.md` e continua lì. Non creare doppioni.

Se il filesystem non è disponibile, la stessa struttura vive in una sezione
`WIKI` della conversazione, con un titolo per pagina.

---

## 2. Metadati di pagina

Ogni pagina inizia con un blocco leggibile (non serve YAML formale, ma è
consigliato):

```markdown
---
page: rischi-controlli
entity: Casa di Riposo Esempio
period: 2025
status: attivo
updated: 2026-11-16
owner: agente
sources: [D-001, D-004]
---
```

Campi:

| Campo | Significato |
|---|---|
| `page` | nome logico stabile |
| `entity` | ente |
| `period` | esercizio o periodo |
| `status` | `attivo`, `chiuso`, `sospeso`, `superseded` |
| `updated` | data ultimo aggiornamento |
| `owner` | `agente` o nome utente |
| `sources` | ID documenti/fonti |

---

## 3. Identificatori

| Prefisso | Oggetto | Esempio |
|---|---|---|
| `D-###` | documento/fonte | `D-012` |
| `R-###` | rischio | `R-003` |
| `C-###` | controllo | `C-007` |
| `CL-###` | carta di lavoro | `CL-004` |
| `F-###` | finding/anomalia | `F-002` |
| `Q-###` | domanda aperta | `Q-005` |
| `A-###` | assertion/test | `A-011` |

Regole:

- ID progressivo a tre cifre, mai riusato.
- Un ID vive per sempre. Se un rischio non è più valido: `status: chiuso`
  con motivo, non cancellazione.
- I riferimenti incrociati usano `[[R-003]]` o il testo `R-003`; entrambi
  devono risolvere a una voce esistente.

---

## 4. Ciclo di aggiornamento

```
1. ESTRAI     fatto puntuale dalla fonte (numero, data, clausola, firma)
2. VERIFICA   controlla sulla fonte; se incerto → N.d. + Q-###
3. SINTETIZZA una frase chiara, senza copiare interi paragrafi
4. AGGANCIA   collega a rischio, controllo, carta, finding
5. SCRIVI     aggiorna la pagina (append o sezione datata)
6. REGISTRA   appendi al registro attività
7. INDICE     aggiorna stato, copertura, prossima azione
```

### Esempio

Fonte: bilancio 2025, pagina 12, voce "Crediti verso clienti € 412.300".

```markdown
### Crediti verso clienti — 2025
- Importo: € 412.300 (D-003, p. 12)
- Anno precedente: € 388.100 (D-002, p. 11)
- Variazione: +6,2%
- Rischio collegato: [[R-004]] (valutazione crediti)
- Carta di lavoro: [[CL-006]]
- Nota: fondo svalutazione € 18.000, invariato
- Fonte: bilancio 2025
```

Nel registro:

```
2026-11-16T10:42 | agente | estratto crediti | mappa-documentale, rischi-controlli | D-003 p.12 | ok
```

---

## 5. Corrections & supersession

Non riscrivere il passato. Se un dato era sbagliato:

```markdown
### Crediti verso clienti — 2025 (correzione 2026-11-17)
- Importo corretto: € 421.300 (D-009, p. 12)
- Precedente: € 412.300 (D-003, p. 12) — superseded da D-009
- Motivo: refuso nel PDF provvisorio
```

Nel registro si annota `correzione` e si cita la voce precedente.
L'audit trail mostra cosa sapevi e quando.

---

## 6. Conflitti tra fonti

Due fonti dicono cose diverse:

1. Non scegliere in silenzio.
2. Apri `F-###` (o `Q-###` se non è un rilievo) con:
   - valore A + fonte A;
   - valore B + fonte B;
   - impatto potenziale;
   - chi può risolvere.
3. Chiedi all'utente quale prevale, oppure usa la fonte più autorevole
   (firmata, definitiva, depositata) e **dichiaralo**.

---

## 7. Compattazione

Quando la Wiki cresce:

- `INDEX.md` resta corto: solo mappa, stato, gap, prossima azione.
- Le pagine di dettaglio possono diventare lunghe: vanno bene, sono la prova.
- Non spostare i fatti in un "riassunto" cancellando il dettaglio: aggiungi
  una sintesi in cima e lascia il dettaglio sotto.
- A fine incarico produci uno snapshot: `wiki/_snapshot/YYYY-MM-DD/` con le
  pagine correnti. Non è obbligatorio se il version control è disponibile.

---

## 8. Portabilità

- Solo testo UTF-8. Niente immagini incorporate obbligatorie: se serve una
  scansione, cita il documento e la pagina.
- Link relativi, nessun path assoluto.
- Nessun dato sensibile in chiaro se l'utente chiede di escluderlo: usa
  `[omesso su richiesta]` e registra la scelta.
- La Wiki è esportabile come singolo Markdown per il cloud.

---

## 9. Controllo di integrità

Prima di chiudere una sessione verifica:

- [ ] `INDEX.md` riflette la fase reale.
- [ ] Ogni `F-###` cita almeno una carta di lavoro e una fonte.
- [ ] Ogni `CL-###` ha stato, conclusione e firma.
- [ ] Ogni `R-###` significativo ha una risposta (controllo o test).
- [ ] Il registro attività ha una riga per ogni modifica.
- [ ] Nessun ID citato è inesistente.
