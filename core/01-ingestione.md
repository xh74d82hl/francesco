# 01 — Ingestione autonoma dei documenti

Nessuna cartella di input, nessun naming obbligatorio. L'agente scopre ciò che
esiste, lo interpreta e costruisce la mappa documentale.

---

## 1. Fonti ammesse

| Fonte | Come si legge |
|---|---|
| Allegati in chat | vision nativa per PDF/immagini, lettura diretta per testo/CSV |
| File locali | `Read`, `Glob`, `Grep`; ricerca semantica se disponibile |
| Cartelle indicate dall'utente | scansione ricorsiva, senza assumere nomi |
| Link ufficiali | `WebFetch` solo se l'utente fornisce il link o autorizza la ricerca |
| Dati incollati | trattali come fonte `utente` e registra la data |
| Sistemi esterni | solo se l'utente esporta un file; nessuna credenziale richiesta |

Non chiedere di riorganizzare i file prima di iniziare. Adattati.

---

## 2. Discovery

Ordine consigliato:

1. Chiedi: "Dove sono i documenti? Puoi allegarli o indicarmi una cartella."
2. Se l'utente non sa: cerca nel workspace per estensione e contenuto
   (`**/*.pdf`, `**/*.csv`, `**/*.md`, `**/*.txt`) ed elenca i candidati.
3. Per ogni candidato: leggi le prime pagine/metadati, non solo il nome.
4. Classifica per **contenuto**:

| Tipo | Indizi |
|---|---|
| Bilancio / financial statements | stato patrimoniale, conto economico, nota integrativa, firma |
| Visura / registro | denominazione, codice fiscale, codice attività, sede |
| Statuto / atto costitutivo | oggetto sociale, organi, nomine |
| Verbale / minutes | data, ordine del giorno, delibere, firme |
| Estratto conto | banca, IBAN, saldo, movimenti |
| Contabilità | libro giornale, mastro, prima nota, partite aperte |
| Fiscale | dichiarazioni, F24, IVA/VAT, ritenute |
| Personale | buste paga, libro unico, contratti |
| Contratti | parti, durata, corrispettivo, clausole |
| Revisione precedente | relazione, carte, lettera incarico, rilievi |
| Altro | descrivi cosa sembra essere, senza forzare |

5. Se un documento è ambiguo, chiedi conferma una volta e registra la risposta.

---

## 3. Lettura multimodale

- **PDF testuale:** leggi il testo; se le tabelle sono ambigue, usa la resa
  visiva della pagina.
- **Scansione/foto:** usa la vision. Riporta solo ciò che leggi chiaramente.
- **Tabelle:** ricostruisci righe e colonne; indica se un importo è illeggibile.
- **Più pagine:** cita sempre `(D-###, p. N)`.
- **Documento protetto o corrotto:** dichiaralo, chiedi una copia, non tentare
  conversioni con tool esterni.
- **Lingua straniera:** traduci solo per capire; cita la lingua originale.

Non usare OCR, docling, LibreOffice o pipeline esterne. Se il modello non ha
vision, dillo e chiedi il testo o una versione leggibile.

---

## 4. Scheda documento

Per ogni fonte crea una voce in `mappa-documentale.md`:

```markdown
### D-003 — Bilancio d'esercizio 2025
- File/fonte: `bilancio_2025_firmato.pdf` (allegato chat)
- Tipo: bilancio civilistico
- Ente: Casa di Riposo Esempio
- Periodo: 01/01/2025–31/12/2025
- Pagine: 28
- Qualità: buona, tabelle leggibili
- Firme: presidente, revisore (p. 27)
- Fatti chiave: SP € 2.431.000; utile € 41.200; ...
- Collegamenti: [[contesto-ente]], [[R-001]], [[CL-003]]
- Ricevuto: 2026-11-16
- Stato: acquisito
```

Campi minimi: ID, descrizione, tipo, periodo, fonte, qualità, stato.

---

## 5. Estrazione dei fatti

Estrai solo ciò che serve alla revisione:

- identificativi: denominazione, CF/VAT, sede, codice attività;
- periodo e perimetro;
- saldi e totali di bilancio;
- voci significative e variazioni;
- date di approvazione, firme, organi;
- clausole contrattuali rilevanti;
- riferimenti normativi e principi contabili;
- eventi societari e parti correlate;
- anomalie evidenti (firme mancanti, date incoerenti, totali che non tornano).

Per ogni fatto: valore, unità, fonte, pagina, certezza (`certo`, `letto`,
`inferito`, `N.d.`).

**Mai** riportare un importo senza la fonte. **Mai** arrotondare senza dirlo.

---

## 6. Gap e richieste

Aggiorna `richieste-documenti.md`:

| ID | Documento | Perché serve | Impatto se manca | Stato |
|---|---|---|---|---|
| Q-001 | Nota integrativa 2025 | aggancio voci SP/CE | alto | richiesto |
| Q-002 | Estratto conto dicembre | cut-off e saldo | alto | ricevuto |
| Q-003 | Verbale approvazione bilancio | data e competenza | medio | mancante |

Chiedi in linguaggio semplice:

> "Mi manca la nota integrativa del 2025. Senza, posso quadrare lo stato
> patrimoniale ma non verificare immobilizzazioni e fondo svalutazione.
> Va bene anche una scansione."

---

## 7. Aggiornamento incrementale

Quando arriva un nuovo documento:

1. Assegna `D-###` nuovo.
2. Leggi ed estrai i fatti.
3. Confronta con quanto già in Wiki: conferma, corregge o contraddice?
4. Aggiorna le pagine interessate con data e `supersede` se serve.
5. Aggiorna `richieste-documenti.md` (stato).
6. Append al registro attività.
7. Rivaluta i rischi se il nuovo fatto cambia il quadro.

Non ricominciare da zero. La Wiki è incrementale per definizione.

---

## 8. Qualità e limiti

- Un documento illeggibile non si indovina: si dichiara.
- Un estratto conto parziale non copre il periodo: si segnala.
- Un bilancio non firmato è una bozza: si tratta come tale.
- Un PDF con pagine mancanti: si chiede l'integrazione.
- Un dato contraddittorio: si apre un conflitto, non si sceglie a caso.

---

## 9. Checklist di ingestione

- [ ] Fonti elencate e classificate per contenuto.
- [ ] Ogni fonte ha una scheda `D-###`.
- [ ] Fatti chiave estratti con pagina.
- [ ] Gap registrati e comunicati.
- [ ] Wiki aggiornata e cross-referenziata.
- [ ] Registro attività aggiornato.
- [ ] Nessun OCR o tool esterno usato.
