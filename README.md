# Francesco

**35 anni. Occhialetti tondi. Sguardo assente. Precisione maniacale.**

Francesco fa task ripetitivi, li fa bene, e li ricontrolla 3 volte. Se non e sicuro al 100%, chiede. Se e sicuro al 100%, fa un passaggio in piu sui documenti comunque. Per sicurezza.

Non e un genio. Non cerca di esserlo. E la versione ideale del robot umano: esegue, controlla, esegue ancora, non si ferma finche ogni numero non torna.

> *"N.d. e meglio di una bugia. Il dubbio e meglio di una certezza frettolosa."*

---

## Il problema

Hai 4 societa, ognuna con documenti sparsi, modelli diversi, calendari incompleti, normative da settori diversi. Ogni trimestre devi ricostruire da capo cosa e stato fatto. Francesco fa schifo a ricordare le cose. Allora le scrive. Tutte. Ogni volta.

Entra, legge tutto, si fa un quadro, e quando apri un file sai esattamente:

- che tipo di societa e
- che mandato hai
- cosa serve
- cosa manca
- cosa e stato controllato
- quante volte e stato ricontrollato

## Per chi e

Per revisori, sindaci, collegi sindacali che non vogliono ricominciare da capo ogni 3 mesi.

---

## Cosa fa

| "Francesco..." | Lui risponde |
|----------------|--------------|
| "Che tipo di societa e?" | Asp? SPA? SRL? Sportiva? Se non trova documenti, fa un'ipotesi e te la scrive chiara. |
| "Che mandato ho?" | Revisore legale? Sindaco unico? Collegio? Ogni mandato ha la sua checklist. |
| "Il settore ha extra?" | RSA, automotive, calcio, immobiliare — Francesco cerca, salva, e non dimentica. |
| "Le norme?" | Archivio in markdown. Fonte, data, note. Aggiornabile. Leggibile. Senza database. |
| "Dove eravamo?" | Log datato di ogni sessione. Apri e sai. Anche tra 6 mesi. Anche tra 2 anni. |
| "E se mancano dati?" | `N.d.` — punto. Francesco non inventa. |

---

## Il triplo check

Il workflow di Francesco e semplice: fa, verifica, e se non e sicuro chiede. Se e sicuro, rifa un giro comunque.

**1° giro**: esegue.
**2° giro**: rilegge, controlla date nomi importi riferimenti.
**3° giro**: valuta. Se ha dubbi -> chiede. Se e sicuro -> rilegge tutto un'altra volta.

Poi salva e rilegge l'ultima riga dell'ultimo log. Per sicurezza.

---

## Come si usa

```
/usare francesco
```

Poi Francesco segue la sua scaletta: identifica -> determina -> consulta -> esegue -> controlla 3 volte -> lascia traccia.

---

## La struttura

```
~/.agents/skills/francesco/
  SKILL.md              — tutto quello che Francesco sa fare
  characters/
    francesco.svg       — non e bello, ma e lui
  normative/            — norme e regolamenti (locale, fuori dal git)
  DIRECTION.md          — dove sta andando
```

## Cosa finisce nel git

Solo la skill e il README. Le norme no, perche Francesco non vuole fare PR per aggiornare un D.Lgs.

---

## Crediti

Stile ispirato a **Ralph** — perche quando un bro fa un buon lavoro, si dice.
Struttura tecnica da **Kami** — chiarezza prima di tutto.

Il resto e roba di Francesco.

---

<div align="center">
  <img src="characters/francesco.svg" width="180" alt="Francesco">
  <p><em>"Ho controllato. Tutto ok. Controllo ancora."</em></p>
</div>
