#!/usr/bin/env node
/**
 * Francesco 2.0 — zero-dependency CLI.
 *
 * Commands:
 *   init      initialize a working wiki in the current/selected directory
 *   bundle    export the single-file cloud bundle
 *   install   copy the skill into an agent skills directory
 *   doctor    validate package integrity and zero-dependency guarantees
 *   info      print capabilities and resolved paths
 */

import fs from "node:fs";
import path from "node:path";
import os from "node:os";
import { fileURLToPath } from "node:url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const ROOT = path.resolve(__dirname, "..");

const pkg = JSON.parse(fs.readFileSync(path.join(ROOT, "package.json"), "utf8"));
const VERSION = pkg.version;
const SKILL_NAME = "francesco";

const C = process.stdout.isTTY
  ? {
      reset: "\x1b[0m",
      bold: "\x1b[1m",
      dim: "\x1b[2m",
      green: "\x1b[32m",
      red: "\x1b[31m",
      yellow: "\x1b[33m",
      blue: "\x1b[34m",
    }
  : { reset: "", bold: "", dim: "", green: "", red: "", yellow: "", blue: "" };

function out(line = "") {
  process.stdout.write(line + "\n");
}

function fail(message) {
  process.stderr.write(`${C.red}error${C.reset} ${message}\n`);
  process.exitCode = 1;
}

function parseArgs(argv) {
  const args = { _: [] };
  for (let i = 0; i < argv.length; i++) {
    const token = argv[i];
    if (token.startsWith("--")) {
      const key = token.slice(2);
      if (key === "help" || key === "version" || key === "force" || key === "compact") {
        args[key] = true;
      } else if (i + 1 < argv.length && !argv[i + 1].startsWith("--")) {
        args[key] = argv[++i];
      } else {
        args[key] = true;
      }
    } else {
      args._.push(token);
    }
  }
  return args;
}

function ensureDir(dir) {
  fs.mkdirSync(dir, { recursive: true });
}

function walk(dir) {
  if (!fs.existsSync(dir)) return [];
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  const files = [];
  for (const entry of entries.sort((a, b) => a.name.localeCompare(b.name))) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) files.push(...walk(full));
    else files.push(full);
  }
  return files;
}

function rel(file) {
  return path.relative(ROOT, file).split(path.sep).join("/");
}

function read(file) {
  return fs.readFileSync(file, "utf8").replace(/\r\n/g, "\n");
}

function copyFile(from, to, force) {
  if (fs.existsSync(to) && !force) return false;
  ensureDir(path.dirname(to));
  fs.copyFileSync(from, to);
  return true;
}

function copyDir(from, to, force) {
  let copied = 0;
  for (const file of walk(from)) {
    const target = path.join(to, path.relative(from, file));
    if (copyFile(file, target, force)) copied++;
  }
  return copied;
}

function today() {
  return new Date().toISOString().slice(0, 10);
}

function renderTemplate(text, vars) {
  return text
    .replaceAll("{{ENTE}}", vars.entity)
    .replaceAll("{{PERIODO}}", vars.period)
    .replaceAll("{{DATA}}", vars.date);
}

/* ------------------------------------------------------------------ init */

function cmdInit(args) {
  const target = path.resolve(args._[0] || process.cwd());
  const force = Boolean(args.force);
  const entity = String(args.entity || path.basename(target) || "Ente");
  const period = String(args.period || new Date().getFullYear());
  const date = today();
  const stateName = String(args.state || "wiki");
  const stateDir = path.isAbsolute(stateName) ? stateName : path.join(target, stateName);

  ensureDir(target);
  ensureDir(stateDir);

  const templateWiki = path.join(ROOT, "templates", "wiki");
  let created = 0;
  let skipped = 0;

  for (const file of walk(templateWiki)) {
    const dest = path.join(stateDir, path.relative(templateWiki, file));
    if (fs.existsSync(dest) && !force) {
      skipped++;
      continue;
    }
    ensureDir(path.dirname(dest));
    fs.writeFileSync(dest, renderTemplate(read(file), { entity, period, date }), "utf8");
    created++;
  }

  const kitDir = path.join(target, ".francesco", "skill");
  if (fs.existsSync(kitDir) && force) fs.rmSync(kitDir, { recursive: true, force: true });
  ensureDir(kitDir);
  let kit = 0;
  for (const entry of ["SKILL.md", "skill.json", "README.md", "README.it.md", "LICENSE", "core", "templates"]) {
    const src = path.join(ROOT, entry);
    if (!fs.existsSync(src)) continue;
    if (fs.statSync(src).isDirectory()) kit += copyDir(src, path.join(kitDir, entry), true);
    else if (copyFile(src, path.join(kitDir, entry), true)) kit++;
  }

  const outputDir = path.join(target, "output");
  ensureDir(outputDir);

  const config = {
    skill: SKILL_NAME,
    version: VERSION,
    entity,
    period,
    state: path.relative(target, stateDir).split(path.sep).join("/") || "wiki",
    output: "output",
    createdAt: new Date().toISOString(),
  };
  fs.writeFileSync(path.join(target, ".francesco", "config.json"), JSON.stringify(config, null, 2) + "\n", "utf8");

  out(`${C.green}ok${C.reset} Francesco ${VERSION} inizializzato in ${target}`);
  out(`   wiki:   ${path.relative(target, stateDir) || "."} (${created} file creati, ${skipped} esistenti)`);
  out(`   kit:    .francesco/skill (${kit} file)`);
  out(`   output: output/`);
  out("");
  out("Prossimi passi:");
  out(`   1. Apri l'agente in ${target}`);
  out("   2. Di': \"usa la skill in .francesco/skill e leggi wiki/INDEX.md\"");
  out("   3. Oppure esporta il bundle cloud: npx francesco-audit bundle --out bundle.md");
}

/* ---------------------------------------------------------------- bundle */

function bundleBody({ compact }) {
  const sections = [];
  const add = (title, file) => {
    sections.push(`\n\n<!-- ===== FILE: ${rel(file)} ===== -->\n\n${read(file).trim()}\n`);
  };

  sections.push(`# Francesco 2.0 — Cloud Bundle${compact ? " (compact)" : ""}

Versione: ${VERSION}
Licenza: MIT
Generato da: \`npx francesco-audit bundle${compact ? " --compact" : ""}\`

Questo documento è una skill completa e autosufficiente. Caricalo come
istruzione di progetto in Claude Projects/Skills, ChatGPT Projects o Gemini Gems.
Non richiede file esterni, OCR, librerie Office o connessioni obbligatorie.

## Come usarlo

1. Incolla o carica questo documento come istruzioni del progetto.
2. Scrivi cosa devi fare: ente, periodo, documenti disponibili.
3. Allega i PDF o incolla i dati. Francesco usa la vision nativa.
4. Mantieni la Wiki in una sezione \`WIKI\` della conversazione.
5. Chiedi l'export in Markdown, CSV o HTML stampabile.

## Regole di caricamento

- Tratta le sezioni \`core/\` come moduli sempre disponibili: il bundle le
  contiene tutte, non serve leggerle "da file".
- Tratta \`templates/wiki/\` come pagine iniziali della Wiki.
- Tratta \`templates/output/\` come modelli di output.
- Se un template contiene segnaposto \`{{...}}\`, sostituiscili con i dati reali.
- Non inventare moduli mancanti: se una sezione non c'è, dichiaralo.

## Indice dei moduli

${walk(path.join(ROOT, "core")).map((f) => `- ${rel(f)}`).join("\n")}
`);

  add("SKILL", path.join(ROOT, "SKILL.md"));
  for (const file of walk(path.join(ROOT, "core"))) add("CORE", file);

  for (const file of walk(path.join(ROOT, "templates", "wiki"))) add("WIKI TEMPLATE", file);

  if (!compact) {
    for (const file of walk(path.join(ROOT, "templates", "output"))) add("OUTPUT TEMPLATE", file);
  } else {
    const checklist = path.join(ROOT, "templates", "output", "checklist-chiusura.md");
    if (fs.existsSync(checklist)) add("OUTPUT TEMPLATE", checklist);
  }

  sections.push(`\n\n<!-- ===== FINE BUNDLE ===== -->\n`);
  return sections.join("");
}

function cmdBundle(args) {
  const compact = Boolean(args.compact);
  const body = bundleBody({ compact });
  const outFile = args.out ? path.resolve(String(args.out)) : null;
  if (outFile) {
    ensureDir(path.dirname(outFile));
    fs.writeFileSync(outFile, body, "utf8");
    out(`${C.green}ok${C.reset} bundle ${compact ? "compact" : "full"} scritto in ${outFile}`);
    out(`   ${Buffer.byteLength(body, "utf8")} byte, ${body.split("\n").length} righe`);
  } else {
    process.stdout.write(body);
  }
}

/* --------------------------------------------------------------- install */

const AGENT_TARGETS = {
  opencode: "~/.agents/skills/francesco",
  "claude-code": "~/.claude/skills/francesco",
  claude: "~/.claude/skills/francesco",
  cursor: "~/.cursor/skills/francesco",
};

function expandHome(p) {
  if (p === "~") return os.homedir();
  if (p.startsWith("~/")) return path.join(os.homedir(), p.slice(2));
  return p;
}

function cmdInstall(args) {
  const agent = args.agent ? String(args.agent) : null;
  let target = args.target ? expandHome(String(args.target)) : null;

  if (!target && agent) {
    const mapped = AGENT_TARGETS[agent];
    if (!mapped) {
      fail(`agente non supportato per install su disco: ${agent}`);
      out("Usa --target <dir> oppure --agent opencode|claude-code|cursor.");
      out("Per Claude Web, ChatGPT o Gemini usa: npx francesco-audit bundle");
      return;
    }
    target = expandHome(mapped);
  }
  if (!target) {
    target = expandHome(AGENT_TARGETS.opencode);
    out(`${C.yellow}nota${C.reset} nessun --target/--agent: uso ${target}`);
  }

  ensureDir(target);
  let copied = 0;
  for (const entry of ["SKILL.md", "skill.json", "README.md", "README.it.md", "AUDIT.md", "LICENSE", "core", "templates"]) {
    const src = path.join(ROOT, entry);
    if (!fs.existsSync(src)) continue;
    if (fs.statSync(src).isDirectory()) copied += copyDir(src, path.join(target, entry), true);
    else if (copyFile(src, path.join(target, entry), true)) copied++;
  }
  out(`${C.green}ok${C.reset} skill installata in ${target} (${copied} file)`);
  out("Riavvia l'agente per caricare la skill.");
}

/* ---------------------------------------------------------------- doctor */

function cmdDoctor() {
  const checks = [];
  const add = (ok, label, detail = "") => checks.push({ ok, label, detail });
  const required = [
    "SKILL.md",
    "skill.json",
    "package.json",
    "bin/francesco.mjs",
    "core/00-motore-wiki.md",
    "core/01-ingestione.md",
    "core/02-onboarding-incarico.md",
    "core/03-analisi-rischi.md",
    "core/04-verifiche-periodiche.md",
    "core/05-carte-lavoro.md",
    "core/06-controlli-sostanza.md",
    "core/07-relazione-finale.md",
    "core/08-output-universali.md",
    "core/09-guida-utente.md",
    "core/10-principi-e-normativa.md",
    "templates/wiki/INDEX.md",
    "templates/wiki/contesto-ente.md",
    "templates/wiki/rischi-controlli.md",
    "templates/wiki/anomalie-findings.md",
    "templates/output/carta-lavoro.html",
    "templates/output/relazione-finale.html",
  ];

  for (const file of required) {
    add(fs.existsSync(path.join(ROOT, file)), `file presente: ${file}`);
  }

  const skill = fs.existsSync(path.join(ROOT, "SKILL.md")) ? read(path.join(ROOT, "SKILL.md")) : "";
  add(skill.startsWith("---\n"), "SKILL.md ha frontmatter YAML");
  add(/\nname:\s*francesco\s*\n/.test(skill), "frontmatter: name");
  add(/\ndescription:\s*".+"/.test(skill), "frontmatter: description");
  add(/\nlicense:\s*MIT\s*\n/.test(skill), "frontmatter: license");

  const deps = pkg.dependencies || {};
  const devDeps = pkg.devDependencies || {};
  add(Object.keys(deps).length === 0, "package.json: zero dependencies", Object.keys(deps).join(", "));
  add(Object.keys(devDeps).length === 0, "package.json: zero devDependencies", Object.keys(devDeps).join(", "));
  add(Boolean(pkg.bin && (pkg.bin["francesco-audit"] || pkg.bin.francesco)), "package.json: bin definito");

  const forbidden = ["docling", "docx", "xlsx", "libreoffice", "tesseract", "paddleocr", "mammoth", "pdf-parse"];
  const codeFiles = walk(path.join(ROOT, "bin")).filter((f) => /\.(mjs|js)$/.test(f));
  const hits = [];
  for (const file of codeFiles) {
    const text = read(file).toLowerCase();
    for (const word of forbidden) {
      if (new RegExp(`(from|require\\()\\s*["'][^"']*${word}`).test(text)) {
        hits.push(`${rel(file)}:${word}`);
      }
    }
  }
  add(hits.length === 0, "nessuna dipendenza legacy nel codice", hits.slice(0, 6).join(", "));

  const htmlFiles = walk(path.join(ROOT, "templates", "output")).filter((f) => f.endsWith(".html"));
  for (const file of htmlFiles) {
    const html = read(file);
    add(/@media\s+print/.test(html), `CSS print: ${rel(file)}`);
    add(!/<script\s+src=/i.test(html) && !/<link\s+[^>]*href=["']https?:/i.test(html), `nessuna risorsa esterna: ${rel(file)}`);
  }

  const bundleFull = path.join(ROOT, "bundle", "CLOUD-BUNDLE.md");
  const bundleCompact = path.join(ROOT, "bundle", "CLOUD-BUNDLE.compact.md");
  if (fs.existsSync(bundleFull)) {
    add(read(bundleFull) === bundleBody({ compact: false }), "bundle full aggiornato");
  } else {
    add(false, "bundle full presente");
  }
  if (fs.existsSync(bundleCompact)) {
    add(read(bundleCompact) === bundleBody({ compact: true }), "bundle compact aggiornato");
  } else {
    add(false, "bundle compact presente");
  }

  out(`${C.bold}Francesco doctor${C.reset} — v${VERSION} — node ${process.version}`);
  out("");
  let failed = 0;
  for (const check of checks) {
    if (check.ok) {
      out(`  ${C.green}PASS${C.reset}  ${check.label}`);
    } else {
      failed++;
      out(`  ${C.red}FAIL${C.reset}  ${check.label}${check.detail ? ` (${check.detail})` : ""}`);
    }
  }
  out("");
  out(failed === 0 ? `${C.green}${checks.length}/${checks.length} controlli superati${C.reset}` : `${C.red}${failed} controlli falliti${C.reset}`);
  if (failed > 0) process.exitCode = 1;
}

/* ------------------------------------------------------------------ info */

function cmdInfo() {
  out(`${C.bold}Francesco ${VERSION}${C.reset} — revisione legale AI-first, zero dipendenze`);
  out("");
  out("Comandi:");
  out("  npx francesco-audit init [dir] [--entity Nome] [--period 2025] [--state wiki] [--force]");
  out("  npx francesco-audit bundle [--compact] [--out FILE]");
  out("  npx francesco-audit install [--agent opencode|claude-code|cursor] [--target DIR]");
  out("  npx francesco-audit doctor");
  out("  npx francesco-audit info");
  out("");
  out("Percorsi:");
  out(`  package: ${ROOT}`);
  out(`  skill:   ${path.join(ROOT, "SKILL.md")}`);
  out(`  moduli:  ${path.join(ROOT, "core")}`);
  out(`  wiki:    ${path.join(ROOT, "templates", "wiki")}`);
  out(`  output:  ${path.join(ROOT, "templates", "output")}`);
  out("");
  out("Formati: Markdown, CSV, HTML self-contained (@media print).");
  out("Dipendenze runtime: nessuna.");
}

/* ------------------------------------------------------------------ help */

function cmdHelp() {
  out(`${C.bold}francesco-audit${C.reset} — CLI zero-dependency per la skill Francesco 2.0

Uso:
  npx francesco-audit <comando> [opzioni]

Comandi:
  init [dir]        Inizializza la Wiki e il kit skill nel workspace
  bundle            Esporta il bundle unico per cloud (stdout o --out)
  install           Copia la skill in una cartella agente
  doctor            Verifica integrità, frontmatter e zero dipendenze
  info              Mostra versione, comandi e percorsi
  help              Questo messaggio

Opzioni init:
  --entity NOME     Nome ente (default: nome cartella)
  --period 2025     Periodo (default: anno corrente)
  --state DIR       Cartella stato Wiki (default: wiki)
  --force           Sovrascrive i file esistenti

Opzioni bundle:
  --compact         Solo SKILL + core + template Wiki + checklist
  --out FILE        Scrivi su file invece che stdout

Opzioni install:
  --agent NOME      opencode | claude-code | cursor
  --target DIR      Cartella di destinazione esplicita

Esempi:
  npx francesco-audit init . --entity "Casa di Riposo Esempio" --period 2025
  npx francesco-audit bundle --out bundle/CLOUD-BUNDLE.md
  npx francesco-audit install --agent opencode
  npx francesco-audit doctor
`);
}

/* ------------------------------------------------------------------- main */

const args = parseArgs(process.argv.slice(2));
const command = args._.shift() || (args.version ? "version" : "help");

if (args.version) {
  out(VERSION);
} else {
  switch (command) {
    case "init":
      cmdInit(args);
      break;
    case "bundle":
      cmdBundle(args);
      break;
    case "install":
      cmdInstall(args);
      break;
    case "doctor":
      cmdDoctor();
      break;
    case "info":
      cmdInfo();
      break;
    case "help":
    case "--help":
      cmdHelp();
      break;
    case "version":
      out(VERSION);
      break;
    default:
      fail(`comando sconosciuto: ${command}`);
      cmdHelp();
  }
}
