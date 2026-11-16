# 07 — Findings e relazione finale

Scopo: trasformare le evidenze in rilievi chiari e in un giudizio motivato,
senza eccedere ciò che le carte di lavoro supportano.

---

## 1. Findings

Ogni rilievo ha un ID `F-###` e vive in `wiki/anomalie-findings.md`.

```markdown
### F-002 — Ricavi di competenza 2026 registrati nel 2025
- Severità: alto
- Area: ricavi / cut-off
- Condizione: 3 fatture emesse il 02/01/2026 per € 41.000 registrate al 30/12/2025
- Criterio: competenza economica; principio contabile applicabile
- Causa: chiusura anticipata fatturazione
- Effetto: ricavi 2025 sovrastimati di € 41.000; imposte anticipate non rilevate
- Evidenza: D-007 righe 388–390; CL-004
- Rischio: R-001
- Raccomandazione: storno e ripresentazione; controllo cut-off mensile
- Risposta management: [data / testo / allegato]
- Stato: aperto            # aperto | in riscontro | chiuso | accettato
- Follow-up: verifica nel 2026
```

Severità:

| Livello | Criterio |
|---|---|
| critico | giudizio negativo o impossibilità di esprimere un giudizio |
| alto | errore materiale o debolezza significativa |
| medio | errore sotto materialità ma ricorrente |
| basso | debolezza minore |
| osservazione | miglioramento, nessun impatto sul giudizio |

Regole:

- Un finding senza evidenza non esiste.
- Un finding senza effetto quantificato (o dichiarato non quantificabile) è incompleto.
- La risposta del management va registrata testualmente e datata.
- Un finding chiuso resta nello storico con la data di chiusura.

---

## 2. Struttura della relazione

Adatta al framework e alla giurisdizione. Struttura base:

```markdown
# Relazione del revisore — [Ente] — esercizio [anno]

## Destinatari
[Assemblea / organo / soci]

## Giudizio
[Giudizio positivo / con rilievi / negativo / impossibilità]

## Base del giudizio
- Bilancio: [framework]
- Revisione: [ISA / ISA Italia / ...]
- Evidenze: [sintesi]
- Indipendenza: [dichiarazione]

## Richiami d'informativa
[Se applicabili]

## Aspetti chiave della revisione (KAM)
[Se applicabili: descrizione, perché significativo, come trattato]

## Continuità aziendale
[Conclusione e disclosure]

## Altri aspetti
[Se applicabili]

## Responsabilità della direzione
[Testo previsto dal framework]

## Responsabilità del revisore
[Testo previsto dal framework]

## Firma
[Revisore / società di revisione, data, luogo]
```

Non copiare testi di legge senza verificarli. Cita il framework e la versione
in `contesto-ente.md`.

### Adattamenti per tipo di incarico

| Incarico | Adattamento |
|---|---|
| Revisore unico / società di revisione | relazione standard del revisore |
| Collegio sindacale con revisione legale | relazione unitaria: funzione di vigilanza + giudizio sul bilancio |
| Ente pubblico / ASP | riferimenti alla normativa locale e agli organi di controllo; verifiche periodiche richiamate |
| Società quotata / EIP | KAM obbligatori, informazioni aggiuntive, regolamento UE applicabile |
| Revisione volontaria | perimetro e destinatari concordati; chiarezza sui limiti |
| Incarico limitato (es. solo cassa) | rapporto su procedure concordate, non giudizio sul bilancio |

Se il mandato non è chiaro, torna alla Fase 1. Non emettere una relazione
standard per un incarico che standard non è.

---

## 3. Giudizio

| Tipo | Quando |
|---|---|
| Positivo | bilancio conforme, evidenze sufficienti |
| Con rilievi | errore materiale ma non pervasivo |
| Negativo | errore materiale e pervasivo |
| Impossibilità | limitazioni alle evidenze materiali e pervasive |

Prima di proporre il giudizio:

- [ ] tutte le aree significative hanno una carta conclusa;
- [ ] i findings critici/alti sono valutati;
- [ ] le stime sono verificate;
- [ ] la continuità è valutata;
- [ ] gli eventi successivi sono considerati;
- [ ] le rappresentazioni scritte sono richieste;
- [ ] la documentazione è completa.

Se manca un elemento, il giudizio non è pronto.

---

## 4. Management letter

Separata dalla relazione. Contiene:

- debolezze di controllo interno;
- raccomandazioni operative;
- priorità e impatto;
- risposta del management e tempi;
- follow-up.

Non ripetere i rilievi di bilancio già nella relazione: distingui impatto sul
giudizio e raccomandazione gestionale.

---

## 5. Checklist di chiusura

- [ ] `INDEX.md` aggiornato all'ultima fase.
- [ ] Ogni `CL-###` è `conclusa` o `bloccata` con motivo.
- [ ] Ogni `F-###` ha evidenza, effetto, risposta.
- [ ] La relazione cita i finding rilevanti.
- [ ] Le rappresentazioni scritte sono archiviate.
- [ ] Le fonti e le pagine sono corrette.
- [ ] I comparativi sono allineati.
- [ ] Data e firma presenti.
- [ ] Versione e archivio registrati.
- [ ] Utente ha approvato il testo finale.

---

## 6. Output

- Markdown: `output/relazione-[ente]-[anno].md`
- HTML stampabile: `output/relazione-[ente]-[anno].html`
  (template `templates/output/relazione-finale.html`)
- CSV solo per tabelle di supporto, non per il testo della relazione.

Prima di consegnare: apri l'HTML nel browser, controlla impaginazione, tabelle,
numeri di pagina e stampa in PDF. Se qualcosa non torna, correggi il Markdown e
rigenera.

---

## 7. Dopo la consegna

1. Snapshot della Wiki (se non c'è version control).
2. Registra data di consegna e versione.
3. Archivia fonti e output.
4. Aggiorna il registro attività.
5. Proponi il follow-up (verifiche successive, scadenze, finding aperti).
6. Non modificare la relazione consegnata: una nuova versione è un nuovo file.
