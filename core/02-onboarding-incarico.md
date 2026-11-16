# 02 — Onboarding e accettazione dell'incarico

Scopo: capire chi è l'ente, quale mandato hai, con quali regole e entro quando.
Senza questo, ogni numero è decontestualizzato.

Questa fase produce tre pagine Wiki: `contesto-ente.md`, `piano-revisione.md`,
`richieste-documenti.md`.

---

## 1. Domande di intake (una alla volta)

1. "Per quale ente lavoriamo e quale periodo devo coprire?"
2. "Che tipo di incarico è: revisione legale del bilancio, revisione
   volontaria, verifica periodica, controllo di cassa, altro?"
3. "In quale paese e con quale forma giuridica opera l'ente?"
4. "Quali documenti hai già a disposizione? Puoi allegarli o indicarmi dove
   sono?"
5. "C'è una scadenza o una data di approvazione del bilancio?"
6. "Hai un incarico scritto o una lettera di incarico precedente?"

Se l'utente non sa rispondere, proponi un'ipotesi motivata e chiedi conferma.

---

## 2. Profilo dell'ente

Compila `contesto-ente.md`:

```markdown
# Contesto ente

## Identificazione
- Denominazione:
- Forma giuridica:
- Paese / giurisdizione:
- Sede legale:
- Codice fiscale / VAT / registro:
- Codice attività:

## Mandato
- Tipo incarico:
- Organo che conferisce:
- Durata:
- Norma / statuto di riferimento:
- Revisione precedente:

## Bilancio
- Framework contabile:
- Esercizio:
- Data approvazione:
- Data deposito:
- Consolidato: sì/no

## Governance e parti correlate
- Organi:
- Amministratori / sindaci:
- Parti correlate note:
- Gruppo / controllo:

## Contatti e fonti
- Referente:
- Fonti disponibili:
- Fonti mancanti:

## Affidabilità
- Livello: alta / media / bassa
- Motivo:
- Da verificare:
```

Ogni campo incerto resta `N.d.` con una domanda `Q-###`.

---

## 3. Accettazione e indipendenza

Prima di lavorare, verifica e registra:

- [ ] Competenza e risorse per il tipo di ente e settore.
- [ ] Indipendenza: rapporti economici, incarichi extra-audit, conflitti.
- [ ] Assenza di incompatibilità previste dal framework etico applicabile.
- [ ] Disponibilità di informazioni e accesso ai documenti.
- [ ] Chiarezza su responsabilità della direzione vs revisore.
- [ ] Accordo su perimetro, tempistiche, deliverable.
- [ ] Lettera di incarico (o dichiarazione esplicita che manca).

Se un requisito manca, **fermati e chiedi**. Non accettare implicitamente.

---

## 4. Perimetro e framework

Determina:

| Elemento | Come |
|---|---|
| Giurisdizione | sede, registro, valuta, lingua dei documenti, norme citate |
| Forma giuridica | statuto, visura, denominazione |
| Framework contabile | note al bilancio, principi dichiarati, prassi del paese |
| Framework di revisione | ISA / ISA Italia / PCAOB / IDW / NEP / altro |
| Obbligo di revisione | legge locale, statuto, dimensione, ente pubblico |
| Periodo | esercizio o intervallo della verifica |
| Perimetro | ente singolo, gruppo, rami, conti specifici |

Dettaglio per paese: `core/10-principi-e-normativa.md`.

Se il framework non è documentato, chiedi. Non dedurlo solo dal nome del file.

---

## 5. Materialità

Definisci in `piano-revisione.md`:

- **Materialità complessiva:** base (utile, ricavi, attivo, patrimonio) e
  percentuale, con motivazione.
- **Materialità di performance:** 50–75% della complessiva, in base al rischio.
- **Soglia di rilevazione:** importo sotto il quale non si indaga, salvo pattern.
- **Soglia di comunicazione:** importo sopra il quale si informa il management.
- **Rivalutazione:** se cambiano i dati o il rischio.

Non applicare percentuali automatiche senza spiegare la scelta. Se l'utente ha
una policy, usala e registrala.

---

## 6. Piano di revisione

`piano-revisione.md` contiene:

```markdown
# Piano di revisione

## Perimetro
- Ente / periodo / framework:
- Bilanci e periodi coperti:
- Esclusioni:

## Strategia
- Approccio: sostanza, controlli, misto
- Aree significative:
- Rischi preliminari: [[R-001]] ...
- Affidamento su controlli: sì/no + motivo

## Materialità
- Complessiva:
- Performance:
- Soglie:

## Tempi
| Milestone | Data | Stato |
|---|---|---|
| Pianificazione | | |
| Fieldwork | | |
| Revisione conclusioni | | |
| Relazione | | |

## Evidenze previste
- Documenti:
- Conferme esterne:
- Riconciliazioni:
- Analitiche:
- Campioni:

## Deliverable
- Carte di lavoro
- Relazione
- Management letter
- Altro:

## Dipendenze e rischi di progetto
- ...
```

---

## 7. Richieste documenti

Crea `richieste-documenti.md` con la PBC list (prepared by client), ordinata per
priorità. Per ogni voce: cosa, perché, impatto, stato, riferimento.

Invia all'utente un messaggio breve:

> "Per partire mi servono: bilancio firmato, nota integrativa, visura, statuto,
> estratti conto dell'anno. Ho preparato la lista completa nella Wiki; puoi
> mandarmi anche solo i primi tre e iniziare."

---

## 8. Gate di approvazione

Prima di passare ai rischi, mostra all'utente:

```
[Francesco · Fase 1/8 · Incarico]
Ente: ... | Paese: ... | Forma: ...
Mandato: ... | Framework: ...
Materialità: ... (base: ...)
Prossimo: analisi rischi
Confermi profilo e perimetro? (sì / correggi X)
```

Solo dopo conferma aggiorna `INDEX.md` e passa alla Fase 2.

---

## 9. Errori da evitare

- Assumere il paese dal nome della cartella.
- Usare il framework sbagliato perché "di solito è così".
- Accettare un incarico senza verificare indipendenza.
- Definire materialità senza base dati.
- Iniziare il fieldwork senza perimetro approvato.
- Ignorare una revisione precedente e i suoi rilievi.
