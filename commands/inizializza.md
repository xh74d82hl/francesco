# commands/inizializza — Setup struttura revisione per nuova societa

Flusso per creare la struttura di revisione da zero per una nuova societa.

---

## Cosa crea

```
[cartella-societa]/
  AGENTS.md                    — regole per l'agente
  Revisione/
    PROCESSO_REVISIONE.md       — stato iniziale
    LOG_AGENTI/                 — vuoto, pronto
    verifica di cassa/          — vuoto, pronto
    Verbali/                    — vuoto, pronto
    Documenti acquisiti/        — vuoto, pronto
```

## Procedura

1. Chiedi all'utente: nome societa, tipo (ASP/SPA/SRL/coop/sportiva), settore.
2. Se non sa il tipo → ipotesi basata su nome, segna "da verificare".
3. Crea struttura directory.
4. Crea `AGENTS.md` con regole base dal tipo societario.
5. Crea `Revisione/PROCESSO_REVISIONE.md` con il template sottostante.
6. Esegui preflight normativa (vedi `commands/normativa.md#preflight`).
7. Scrivi log di inizializzazione.

## Template PROCESSO_REVISIONE.md

Basato sul lavoro reale sulla società ASP Casa di Riposo Mosca. Ogni società avrà il suo, ma la struttura portante è questa.

```markdown
# PROCESSO REVISIONE [NOME SOCIETA]

Questo file è lo stato incrementale del lavoro di revisione. Va aggiornato a ogni ripresa significativa del lavoro. I dettagli storici delle singole esecuzioni vanno messi in `Revisione/LOG_AGENTI/`.

## Stato al [YYYY-MM-DD]

[Riassunto breve: cosa è stato fatto, cosa manca, stato generale.]

## File log collegati

- [Log N]: `Revisione/LOG_AGENTI/YYYY-MM-DD_log_NNN_descrizione.md`

## Documenti completati

[Per categoria:]

[area documentale]:

- `[percorso/documento]`
- `[percorso/documento]`

## Documenti da non modificare senza motivo

- [file o categorie da non toccare]
- Modelli e documenti di altre società (es. Valfabbrica/Magione) se presenti in cartella.

## Modelli corretti

- [area documentale]: `[percorso/modello]`.

## Mancanze aperte

- [mancanza 1]
- [mancanza 2]

## Prossima ripresa lavoro

Quando arrivano nuovi documenti:

- Inserire i documenti nella cartella corretta sotto `Revisione/Documenti acquisiti/`.
- Aggiornare i documenti interessati senza toccare quelli già validi se non necessario.
- Aggiornare la sezione Stato con data nuova.
- Creare un nuovo file in `Revisione/LOG_AGENTI/` con numero progressivo, data, documenti letti, documenti creati/modificati, dati consolidati e mancanze residue.

## Registro incrementale

### Log NNN — YYYY-MM-DD

Fatto:

- [cosa fatto]

Manca:

- [cosa manca ancora]
```

Compila i campi noti. Segna `N.d.` dove non hai ancora il dato. Mai inventare. Il `Registro incrementale` si allunga a ogni sessione — mai cancellare log precedenti, solo aggiungere.
