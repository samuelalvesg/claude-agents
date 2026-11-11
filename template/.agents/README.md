# `.agents/` - Canonical Multi-AI System for Agents, Skills, and Rules

Canonical, tool-agnostic artificial intelligence structure for the repository.
Serves as the single source of truth for **Claude Code**, **Antigravity / Gemini**, **Cursor**, **Windsurf**, and other AI coding assistants. See [`/AGENTS.md`](../AGENTS.md) at repository root for the full agent team brief and handoff pipeline.

## Multi-AI Architecture & Symbolic Links

To prevent duplication and version divergence across different AI tools, the `.agents/` directory is the canonical owner of all resources. Tool-specific configurations point here via relative symlinks:

- **Claude Code**:
  - `.claude/agents` -> `../.agents/agents`
  - `.claude/skills` -> `../.agents/skills`
- **Cursor**:
  - `.cursor/rules` -> `../.agents/rules`
- **Antigravity / Windsurf / Others**:
  - Read `.agents/rules/` natively via `always_on` triggers, and discover `.agents/agents/` and `.agents/skills/`.

---

## Folder Structure

### `agents/`

Specialized agent definitions in markdown with standard frontmatter:
- `spec-analyst.md`: Requirements analyst and BDD spec writer.
- `architect.md`: Architecture guardian, ADR author, and contract designer.
- `developer.md`: Base software engineer template (duplicate per stack, e.g. `backend-dev.md`, `frontend-dev.md`).
- `qa-engineer.md`: Automated test strategy, coverage, and mutation audit.
- `reviewer.md`: Strict, read-only code review before merge.
- `secops-engineer.md`: Security analysis, OWASP verification, and secret detection.
- `sre-database.md`: Database reliability, schema migrations, and query tuning.
- `refactoring-architect.md`: Code smells and technical debt cleanup without behavior modification.
- `copywriter-humanizer.md`: Humanizing copy across docs, comments, PRs, issues, and UI/UX strings.

### `skills/`

Shared capabilities for AI agents (each containing its own `SKILL.md`):
- **Core Engineering & Quality**: `adr-writer`, `bdd-spec-writer`, `code-smell-eliminator`, `evidence-report`, `graph-mapping`, `incident-postmortem`, `openspec-validation`, `owasp-sanitizer`, `release-checklist`, `root-cause-debug`, `tech-debt-triage`, `test-mutation-audit`, `test-strategy`, `token-optimization`, `tool-contract-design`, `ui-handoff-spec`.
- **Ecosystem Discovery & Documents**: `find-skills`, `docling`.
- **Text & Copywriting**: `humanizer`, `ux-copy-ptbr`.

### `rules/`

Shared architecture and coding rules for Cursor, Antigravity, and IDEs (frontmatter with `trigger: always_on`).
