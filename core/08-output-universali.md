# 08 — Output universali (Markdown, CSV, HTML)

Regola: il deliverable deve funzionare su qualsiasi browser, senza installare
nulla, senza servizi esterni, senza Word o Excel.

---

## 1. Matrice dei formati

| Bisogno | Formato | Perché |
|---|---|---|
| Testo, carte, relazione, Wiki | Markdown | leggibile, versionabile, portabile |
| Dati, tabelle, riconciliazioni | CSV | importabile ovunque, ispezionabile |
| Stampa / PDF | HTML self-contained | CSS `@media print`, zero dipendenze |
| Presentazione rapida | Markdown o HTML | nessun tool |

Non produrre DOCX/XLSX come formato primario. Se l'utente li chiede:

> "Posso darti il file in Markdown e una versione HTML pronta da stampare in
> PDF, oppure il CSV da importare in Excel. Non uso librerie Office per
> mantenere la skill portabile. Quale preferisci?"

---

## 2. Markdown

- Un file per carta/relazione, titolo H1, sezioni H2/H3.
- Tabelle per i dati; niente immagini obbligatorie.
- Frontmatter per gli ID e lo stato.
- Numeri: formato locale coerente (es. `1.234,56 €`) e unità dichiarata.
- Date: ISO `YYYY-MM-DD` nei metadati, formato locale nel testo.
- Riferimenti: `(D-003, p. 12)`, `[[R-001]]`.

---

## 3. CSV

Standard:

- UTF-8, RFC 4180.
- Prima riga = header.
- Delimitatore: virgola. Se l'utente lavora in Excel italiano, offri anche la
  variante con punto e virgola (`--locale it` non necessario: produci entrambi
  solo se richiesto).
- Numeri: punto decimale, nessun separatore delle migliaia.
- Date: `YYYY-MM-DD`.
- Testi con virgole/virgolette: racchiusi tra doppi apici, apici interni
  raddoppiati.
- Nessuna riga di commento: metadati in un file `.md` affiancato.

Esempio riconciliazione:

```csv
data,descrizione,importo,valuta,lato,stato,fonte
2025-12-31,Commissione bancaria,-12.50,EUR,banca,unreconciled,D-011
2025-12-30,Bonifico cliente,41000.00,EUR,match,D-011
```

---

## 4. HTML self-contained

Requisiti:

- CSS incorporato nel `<style>`.
- Nessun font, script, immagine o CDN esterno.
- Nessun JavaScript necessario per leggere o stampare.
- `@page { size: A4; margin: 18mm 16mm; }`
- Header/footer di stampa con ente, periodo, versione, pagina.
- `page-break-before: always` per le sezioni major.
- `thead { display: table-header-group; }` per ripetere le intestazioni.
- `tr { break-inside: avoid; }` per non spezzare le righe.
- Contrasto e dimensione leggibili anche in bianco e nero.

Template:

| File | Uso |
|---|---|
| `templates/output/carta-lavoro.html` | carta di lavoro |
| `templates/output/relazione-finale.html` | relazione |
| `templates/output/checklist-chiusura.md` | checklist operativa |

Sostituisci i segnaposto `{{...}}`, non aggiungere asset esterni.

---

## 5. Denominazione file

Non imporre una convenzione rigida. Suggerisci:

```
output/
  CL-004-cut-off-ricavi.md
  CL-004-cut-off-ricavi.html
  riconciliazione-banca-2025.csv
  relazione-ente-2025.md
  relazione-ente-2025.html
```

L'ID dentro il documento è la chiave, non il nome del file. Se l'utente ha una
sua convenzione, usala.

---

## 6. Stampa in PDF

Istruzioni per l'utente:

1. Apri l'HTML nel browser.
2. `Ctrl/Cmd + P`.
3. Margini: predefiniti o "nessuno" se il CSS li gestisce.
4. Attiva "Grafica di sfondo" solo se serve.
5. Salva come PDF.

Non serve alcun software aggiuntivo.

---

## 7. Accessibilità e chiarezza

- Titoli gerarchici corretti.
- Tabelle con header espliciti.
- Importi allineati a destra, testi a sinistra.
- Colori non unici portatori di informazione (usa etichette).
- Ogni prospetto ha titolo, periodo, unità e fonte.
- Le conclusioni sono in un box visibile, non sepolte.

---

## 8. Controllo prima della consegna

- [ ] Il Markdown si legge senza renderer.
- [ ] Il CSV apre in un editor e le colonne sono coerenti.
- [ ] L'HTML non chiama risorse esterne.
- [ ] La stampa non taglia tabelle o firme.
- [ ] I numeri sono formattati in modo uniforme.
- [ ] Le fonti sono citate.
- [ ] Il file è nella cartella output concordata.
