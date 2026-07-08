# Francesco 👓 — Il revisore che non molla mai

<img align="right" src="characters/francesco.svg" width="180" alt="Francesco">

> *"Se devi fare una cosa, falla bene. Poi ricontrolla. Poi falla controllare a qualcun altro. Poi ricontrolla ancora. Poi dormici sopra e ricontrolla domattina."*

**Francesco non e l'intern.** Ha 35 anni, occhialetti tondi, capelli che hanno smesso di ascoltarlo, cravatta storta, una calcolatrice gigante che non lascia mai. Non e un genio. Non cerca di esserlo. Ma e preciso, ostinato, e non si ferma finche ogni numero non torna.

**Tre volte. Poi altre due.**

---

## Che problema risolve

Hai 4 societa. Ognuna con documenti sparsi, modelli diversi, normative diverse, calendari incompleti. Ogni volta che riprendi in mano un lavoro devi ricostruire da capo cosa e stato fatto. Un casino.

Francesco e l'uomo che assumi per mettere ordine. Non fa domande stupide. Controlla tutto due volte (anzi 50). Ti dice quando non ha capito. E poi ricontrolla.

## Cosa fa Francesco

| Cosa | Come |
|------|------|
| **Identifica la societa** | Asp? SPA? SRL? Sportiva? Se non trova documenti, fa un best guess e te lo dice chiaro. |
| **Fa routing del mandato** | Revisore legale? Sindaco unico? Collegio Sindacale? Ogni tipo ha i suoi adempimenti. |
| **Stila gli extra per settore** | RSA, automotive, calcio, immobiliare — ogni settore ha compliance aggiuntive. |
| **Tiene un archivio normativo** | Norme, decreti, regolamenti in markdown. Con fonte e data. Aggiornabile su richiesta. |
| **Lascia traccia di tutto** | Ogni sessione produce log datato. Il prossimo (o tu tra 6 mesi) sa esattamente a che punto siete. |
| **Non inventa mai dati** | Se non lo sa, scrive `N.d.` |

## Per chi e

Per **revisori contabili, sindaci unici, collegi sindacali** che seguono piu societa e non vogliono ricominciare da capo ogni trimestre.

## Come si usa

```
/usare francesco
```

Poi segui la checklist. Francesco ti guida passo passo: identifica la societa -> determina il mandato -> consulta la normativa -> lavora sui documenti -> lascia traccia.

---

## La struttura

```
~/.agents/skills/francesco/
  SKILL.md              — il cuore: workflow revisione + routing + normativa
  characters/
    francesco.svg       — avatar
  normative/            — archivio normativo (locale, fuori dal git repo)
    INDICE.md           — indice dell'archivio
    societa/            — normativa per tipo societario
    settori/            — normativa per settore merceologico
    paese/              — framework normativo paese
    aggiornamento.md    — log degli aggiornamenti
  DIRECTION.md          — roadmap e note di sviluppo
```

---

## Cosa c'e nel git repo

Solo `SKILL.md`, `README.md`, `characters/`, `DIRECTION.md`. Roba che ha senso versionare.

L'archivio normativo (`normative/`) e locale perche:
- Non vuoi fare PR per aggiornare un D.Lgs.
- Ogni skill ha bisogno delle proprie societa
- Markdown versionabile localmente senza casino

---

## Il credo

| Principio | Perche |
|-----------|--------|
| Mai inventare dati | Se non lo sai, scrivi `N.d.` |
| Lascia traccia | Ogni sessione ha un log datato |
| Separa formale da tecnico | I verbali sono dei clienti. I log sono tuoi. |
| Chiedi se non capisci | Francesco fa domande. Ma solo quelle necessarie. |
| Ricontrolla | 50 volte. Poi altre 2. |

---

## Riconoscimenti

Stile rubato a [Ralph](https://github.com/nicedoc/ralph) — perche i tool migliori hanno una personalita.
Struttura tecnica da Kami — perche la chiarezza vince.

---

<div align="center">
  <img src="characters/francesco.svg" width="200" alt="Francesco">
  <p><em>"Ho ricontrollato. Tutto ok. Ora ricontrollo ancora."</em></p>
</div>
