# Changes on this branch: portable, dependency-free skill pack

Francesco is now a plain Markdown skill pack. Docling, the MCP server, the Python/uv setup and the first-run setup step are gone. Nothing outside this repo was touched.

## What changed

- **Scanned documents:** the model reads scanned PDFs and images directly, with no OCR tooling. The orchestrator has a short rule for it: re-add the rows against the stated total, and mark any doubtful figure `N.d.` with page and row instead of guessing.
- **Layout:** the repo follows the standard Agent Skills layout. Every skill lives under `skills/<name>/` and its name matches its folder. The orchestrator moved from the repo root to `skills/francesco/`, and `commands/` became `skills/francesco/references/`.
- **Removed:**
  - `scripts/docling-server.py`
  - `commands/setup.md` and the `~/.francesco-setup` marker
  - the `caveman ultra` mention
  - the `compatibility: opencode, claude-code, cursor` frontmatter line (that field is for real requirements)
- **Sub-skills:** `francesco-revisione`, `francesco-bilancio` and `francesco-estratto` now state that they need `francesco` installed next to them and read `../francesco/references/`. They already depended on it; the old text called them standalone.
- **Reference files:** the five files over 100 lines got a table of contents.
- **Installers:** `install.sh` and `install.ps1` no longer need Node. They download the repo and copy `skills/*` into the detected folder (`~/.claude/skills`, `~/.config/opencode/skills`, or `~/.agents/skills`).
- **Docs:** both READMEs and `DIRECTION.md` are updated, including a "zip `skills/francesco` and upload it" route for the Claude app.

The `docx` / `xlsx` skills and LibreOffice remain optional, with a Markdown/CSV fallback.

## Path mapping

| Before | After |
|---|---|
| `SKILL.md` | `skills/francesco/SKILL.md` |
| `commands/<name>.md` | `skills/francesco/references/<name>.md` |
| `commands/setup.md` | removed |
| `scripts/docling-server.py` | removed |
| `skills/francesco-*/SKILL.md` | unchanged location |

## What was checked

- `bash install.sh --dir <scratch folder>` run locally installs all four skills.
- `npx skills add . --list` finds all four skills in the new layout.
- Names match folders, descriptions are under 1,024 characters, every `SKILL.md` is under 500 lines, and no reference link is broken.

## Not tested

- The remote one-liner (`curl ... | bash`). It downloads the `main` branch, so it only works once this layout is merged there. To try it from this branch, set `FRANCESCO_BRANCH=<branch>`.
- `install.ps1`: no PowerShell was available on the machine used for this work.
- A real audit session with the rewritten skills.
- The Claude app upload. The Settings → Skills menu path in the READMEs is from memory.

## Things to know

- An existing install made from the old layout still holds the old files. Re-running the installer updates the skills, but old `commands/` and `scripts/` folders inside the installed `francesco` folder remain as harmless leftovers; delete them by hand if you want.
- The frustration regex block is still duplicated in all four `SKILL.md` files. It was left as is because it was added deliberately.
- For non-technical Claude app users, a ready-made `francesco.zip` attached to a GitHub release would be easier than zipping the folder themselves. This is noted in `DIRECTION.md`; no release exists yet.

## Guidance followed

- [Skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)
- [Agent Skills specification](https://agentskills.io/specification)
- [Skills in Claude Code](https://code.claude.com/docs/en/skills)
