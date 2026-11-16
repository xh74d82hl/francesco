import test from "node:test";
import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const CLI = path.join(ROOT, "bin", "francesco.mjs");

function run(args, opts = {}) {
  return spawnSync(process.execPath, [CLI, ...args], {
    encoding: "utf8",
    cwd: opts.cwd || ROOT,
    timeout: 30000,
  });
}

function tempDir() {
  return fs.mkdtempSync(path.join(os.tmpdir(), "francesco-test-"));
}

test("package is zero-dependency and exposes the npx bin", () => {
  const pkg = JSON.parse(fs.readFileSync(path.join(ROOT, "package.json"), "utf8"));
  assert.deepEqual(pkg.dependencies || {}, {});
  assert.deepEqual(pkg.devDependencies || {}, {});
  assert.ok(pkg.bin["francesco-audit"]);
  assert.ok(fs.existsSync(path.join(ROOT, pkg.bin["francesco-audit"])));
});

test("SKILL.md has standard frontmatter", () => {
  const skill = fs.readFileSync(path.join(ROOT, "SKILL.md"), "utf8");
  assert.ok(skill.startsWith("---\n"));
  assert.match(skill, /\nname: francesco\n/);
  assert.match(skill, /\nlicense: MIT\n/);
  assert.match(skill, /\ndescription: ".*"/);
});

test("init creates a wiki, kit and config with entity placeholders resolved", () => {
  const dir = tempDir();
  const result = run(["init", dir, "--entity", "Ente Test", "--period", "2025"]);
  assert.equal(result.status, 0, result.stderr);
  assert.ok(fs.existsSync(path.join(dir, "wiki", "INDEX.md")));
  assert.ok(fs.existsSync(path.join(dir, "wiki", "carte-lavoro", "_TEMPLATE.md")));
  assert.ok(fs.existsSync(path.join(dir, ".francesco", "skill", "SKILL.md")));
  assert.ok(fs.existsSync(path.join(dir, "output")));
  const index = fs.readFileSync(path.join(dir, "wiki", "INDEX.md"), "utf8");
  assert.match(index, /Ente Test/);
  assert.match(index, /2025/);
  const config = JSON.parse(fs.readFileSync(path.join(dir, ".francesco", "config.json"), "utf8"));
  assert.equal(config.entity, "Ente Test");
  assert.equal(config.version, "2.0.0");
});

test("init does not overwrite existing wiki pages without --force", () => {
  const dir = tempDir();
  assert.equal(run(["init", dir, "--entity", "Prima"]).status, 0);
  const index = path.join(dir, "wiki", "INDEX.md");
  fs.writeFileSync(index, "custom\n", "utf8");
  assert.equal(run(["init", dir, "--entity", "Seconda"]).status, 0);
  assert.equal(fs.readFileSync(index, "utf8"), "custom\n");
  assert.equal(run(["init", dir, "--entity", "Seconda", "--force"]).status, 0);
  assert.match(fs.readFileSync(index, "utf8"), /Seconda/);
});

test("bundle exports all modules and the compact variant excludes HTML templates", () => {
  const dir = tempDir();
  const full = path.join(dir, "full.md");
  const compact = path.join(dir, "compact.md");
  assert.equal(run(["bundle", "--out", full]).status, 0);
  assert.equal(run(["bundle", "--compact", "--out", compact]).status, 0);
  const fullText = fs.readFileSync(full, "utf8");
  const compactText = fs.readFileSync(compact, "utf8");
  assert.match(fullText, /FILE: core\/00-motore-wiki\.md/);
  assert.match(fullText, /FILE: core\/10-principi-e-normativa\.md/);
  assert.match(fullText, /FILE: templates\/wiki\/INDEX\.md/);
  assert.match(fullText, /FILE: templates\/output\/relazione-finale\.html/);
  assert.match(compactText, /FILE: templates\/wiki\/rischi-controlli\.md/);
  assert.doesNotMatch(compactText, /FILE: templates\/output\/relazione-finale\.html/);
  assert.ok(fullText.length > compactText.length);
});

test("install copies the skill kit to an explicit target", () => {
  const dir = tempDir();
  const result = run(["install", "--target", dir]);
  assert.equal(result.status, 0, result.stderr);
  assert.ok(fs.existsSync(path.join(dir, "SKILL.md")));
  assert.ok(fs.existsSync(path.join(dir, "core", "00-motore-wiki.md")));
  assert.ok(fs.existsSync(path.join(dir, "templates", "wiki", "INDEX.md")));
});

test("doctor passes on the repository", () => {
  const result = run(["doctor"]);
  assert.equal(result.status, 0, result.stdout + result.stderr);
  assert.match(result.stdout, /controlli superati/);
});

test("HTML outputs are self-contained and print-ready", () => {
  for (const name of ["carta-lavoro.html", "relazione-finale.html"]) {
    const html = fs.readFileSync(path.join(ROOT, "templates", "output", name), "utf8");
    assert.match(html, /@media\s+print/);
    assert.doesNotMatch(html, /<script\s+src=/i);
    assert.doesNotMatch(html, /<link\s+[^>]*href=["']https?:/i);
  }
});
