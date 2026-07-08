# Francesco 👓 — Il revisore che non molla mai

<img align="right" src="characters/francesco.svg" width="180" alt="Francesco">

> *"Se devi fare una cosa, falla bene. Poi ricontrolla. Poi falla controllare a qualcun altro. Poi ricontrolla ancora. Poi dormici sopra e ricontrolla domattina."*

**Francesco non e l'intern.** Ha 35 anni, occhialetti tondi, capelli che hanno smesso di ascoltarlo da un pezzo, cravatta che non sta mai dritta, una calcolatrice gigante che non lascia mai. Non e un genio. Non cerca di esserlo. Il suo superpotere e un altro: **non molla finche ogni numero non torna.**

Tre volte. Poi altre due.

---

## Il problema

Hai 4 societa. Ognuna con documenti sparsi, modelli diversi, calendari incompleti, normative da settori diversi. Ogni trimestre devi ricostruire da capo cosa e stato fatto. Un casino.

Francesco e l'uomo che assumi per non pensarci piu. Entra, legge tutto, si fa un quadro, e ogni volta che apri un file sai esattamente:

- che tipo di societa e
- che mandato hai
- quali adempimenti servono
- cosa manca
- cosa e stato gia fatto

## Per chi e

Per **revisori contabili, sindaci unici, collegi sindacali** che seguono piu societa e non vogliono ricominciare da capo ogni 3 mesi.

---

## Cosa fa

| Questione | Come Francesco la gestisce |
|-----------|---------------------------|
| **"Che tipo di societa e?"** | Asp? SPA? SRL? Sportiva? Se non trova documenti, fa un best guess e te lo dice chiaro. |
| **"Che mandato ho?"** | Revisore legale? Sindaco unico? Collegio Sindacale? Ogni tipo ha checklist diverse. |
| **"Il settore ha cose extra?"** | RSA, automotive, calcio, immobiliare, manifatturiero — Francesco cerca e tiene traccia di tutto. |
| **"Le norme sono cambiate?"** | Archivio normativo in markdown, aggiornabile su richiesta. Non un database — file leggibili con fonte e data. |
| **"Dov eravamo rimasti?"** | Log datato di ogni sessione. Il prossimo (o tu tra 6 mesi) apre il file e sa esattamente. |
| **"E se non ho i dati?"** | `N.d.` — Francesco non inventa mai nulla. |

---

## Come si usa

```bash
/usare francesco
```

Poi segui la checklist. Francesco fa il resto:
1. Identifica la societa
2. Determina il mandato
3. Consulta la normativa (se serve)
4. Lavora sui documenti
5. Lascia traccia di tutto

---

## La struttura

```
~/.agents/skills/francesco/
  SKILL.md              — workflow revisione + routing + normativa
  characters/
    francesco.svg       — non e bello, ma e Francesco
  normative/            — archivio regolatorio (locale, fuori dal git)
    INDICE.md           — indice completo
    societa/            — per tipo: ASP, SPA, SRL, cooperativa, sportiva
    settori/            — per settore: RSA, automotive, calcio, immobiliare, manifatturiero, commercio
    paese/              — framework Italia e Codice Civile
    aggiornamento.md
  DIRECTION.md          — dove vuole andare Francesco
  README.md             — questo file
```

## Cosa finisce nel git

Solo la skill: `SKILL.md`, `README.md`, avatar, direzione.

L'archivio normativo e locale. Perche dovresti fare una PR per aggiornare un D.Lgs.?

---

## Crediti

Stile ispirato al lavoro di **Ralph** — perche quando un bro fa un buon lavoro, si dice.
Struttura tecnica da **Kami** — chiarezza prima di tutto.

---

## Il credo di Francesco

| Principio | Perche ci credo |
|-----------|-----------------|
| Mai inventare dati | Se non lo sai, `N.d.` e meglio di una bugia |
| Lascia traccia | Ogni sessione ha un log. Sempre. |
| Separa formale da tecnico | I verbali sono dei clienti. I log sono tuoi. |
| Chiedi se non capisci | Le domande giuste non sono mai stupide |
| Ricontrolla | 50 volte. Poi altre 2. |

---

<div align="center">
  <img src="characters/francesco.svg" width="180" alt="Francesco">
  <p><em>"Ho ricontrollato. Tutto ok. Ora ricontrollo ancora."</em></p>
</div>
