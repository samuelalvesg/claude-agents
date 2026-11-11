# Evaluation of the Top 50 Agent Skills for Multi-AI Software Engineering

This evaluation assesses the top 50 agent skills across modern AI ecosystems (**`agenticskills.io`**, **`skills.sh`**, **`vercel-labs/skills`**, **`rtadewald/skills`**, **`mcpservers.org`**, and **`anthropics/knowledge-work-plugins`**) for inclusion in our standardized multi-AI agent repository template.

All skills are standardized in English, following the open `SKILL.md` specification compatible with **Claude Code**, **Cursor**, **Antigravity / Gemini**, and **Windsurf**.

---

## 1. Top 50 Skills Catalog & Recommendations

| # | Skill Name | Source / Ecosystem | Domain | Verdict / Recommendation | Description |
|---|---|---|---|---|---|
| 1 | `find-skills` | `vercel-labs/skills` | Meta / Discovery | **INSTALLED** | Automatically searches (`skills.sh`) and installs skills via CLI mid-task. |
| 2 | `humanizer` | `blader/humanizer` | Copy & Prose | **INSTALLED** | Eliminates 26 AI structural writing patterns; human-sounding docs, PRs, comments. |
| 3 | `docling` | `docling-project/docling` | Document AI | **INSTALLED** | Converts PDF, DOCX, PPTX, XLSX, HTML, images into structured Markdown/JSON for RAG. |
| 10 | `adr-writer` | Canonical (Anthropic / Nygard) | Architecture | **INSTALLED** | Formats immutable Architecture Decision Records with options and Mermaid diagrams. |
| 11 | `bdd-spec-writer` | OpenSpec / BDD | Requirements | **INSTALLED** | Formats executable Given/When/Then acceptance criteria and test scenarios. |
| 12 | `code-smell-eliminator` | Refactoring / Clean Code | Refactoring | **INSTALLED** | Detects and removes duplication, dead code, long methods without altering behavior. |
| 13 | `evidence-report` | Verification / Audit | QA / Review | **INSTALLED** | Fact-based verification reports tying findings directly to `file:line` and test outputs. |
| 14 | `graph-mapping` | Dependency Graph / AST | Architecture | **INSTALLED** | Maps call graphs, dependency layers, and blast radius before touching code. |
| 15 | `incident-postmortem` | Reliability / SRE | Operations | **INSTALLED** | Blameless 5-Whys post-mortem reports with timelines and preventive tasks. |
| 16 | `openspec-validation` | Specification Audit | QA / Architecture | **INSTALLED** | Audits technical specs against OpenSpec for completeness, contracts, and testability. |
| 17 | `owasp-sanitizer` | AppSec / OWASP | Security | **INSTALLED** | Audits code for SQL/command injection, broken auth, secret leakage, and CVEs. |
| 18 | `release-checklist` | CI/CD & Delivery | Operations | **INSTALLED** | Release readiness verification: tests, migrations, secrets, and changelog sanity. |
| 19 | `root-cause-debug` | Systematic Debugging | Debugging | **INSTALLED** | Scientific debugging protocol: reproduce -> isolate -> trace -> verify regression. |
| 20 | `tech-debt-triage` | Backlog / Maintenance | Architecture | **INSTALLED** | Prioritizes technical debt by impact vs effort with concrete remediation tickets. |
| 21 | `test-mutation-audit` | Mutation Testing | QA | **INSTALLED** | Evaluates test suite quality by injecting intentional code mutations. |
| 22 | `test-strategy` | Test Pyramid / Quality | QA | **INSTALLED** | Designs coverage plans across unit, integration, and E2E boundaries. |
| 23 | `token-optimization` | Context Hygiene | Efficiency | **INSTALLED** | Minimizes token bloat via focused reading ranges and structured handoffs. |
| 24 | `tool-contract-design` | Tooling / MCP | Architecture | **INSTALLED** | Designs robust schemas and contracts for MCP tools and CLIs. |
| 25 | `ui-handoff-spec` | UI/UX Design | Frontend | **INSTALLED** | Structured frontend specifications for tokens, responsive layouts, and states. |
| 26 | `a11y-audit` | WCAG 2.1/2.2 AA | Frontend / a11y | **INSTALLED** | Screen contrast, keyboard navigation, touch target, and screen-reader audit. |
| 27 | `ux-copy-ptbr` | UI Localization | Frontend | **INSTALLED** | Brazilian Portuguese interface copy rules (action verbs, clean error feedback). |
| 28 | `grill-me` | `rtadewald/skills` | Architecture / Planning | **RECOMMENDED** | Relentless interview process mapping decisions into an unambiguous design tree. |
| 29 | `to-tickets` | `rtadewald/skills` | Agile / Delivery | **RECOMMENDED** | Breaks plans into tracer-bullet vertical slices with explicit blocking dependencies. |
| 30 | `improve-codebase-architecture` | `rtadewald/skills` | Architecture | **RECOMMENDED** | Deepens shallow modules, identifies architectural friction, and removes leaks. |
| 31 | `plan-screen` | `rtadewald/skills` | UI / Wireframing | **RECOMMENDED** | Conversational screen planning producing typed ASCII / SVG wireframes. |
| 32 | `extract-ds` | `rtadewald/skills` | Design Systems | **RECOMMENDED** | Extracts live design system tokens and patterns from reference web apps. |
| 33 | `to-wireframe` | `rtadewald/skills` | UI Prototyping | **RECOMMENDED** | Converts UI briefs or images into nested ASCII or SVG wireframes. |
| 34 | `context7-mcp` | `rtadewald/skills` | Docs / Reference | **RECOMMENDED** | Fetches up-to-date documentation for modern libraries via Context7 MCP. |
| 35 | `postgres-query-analyzer` | `mcpservers.org` | Database / SRE | **RECOMMENDED** | Analyzes Postgres EXPLAIN plans, missing indexes, and buffer hit rates. |
| 36 | `dockerfile-optimizer` | DevOps / Infra | DevOps | **RECOMMENDED** | Audits multi-stage builds, cache layers, minimal base images (Alpine/Distroless). |
| 37 | `api-contract-diff` | API Governance | Architecture | **RECOMMENDED** | Detects breaking changes in OpenAPI/gRPC protobuf contracts across versions. |
| 38 | `kubernetes-manifest-linter` | Cloud Native / K8s | Operations | **RECOMMENDED** | Validates resource limits, security contexts, probes, and PodDisruptionBudgets. |
| 39 | `git-rebase-conflict-resolver` | Git / Source Control | Productivity | **RECOMMENDED** | Resolves complex git rebase and cherry-pick merge conflicts methodically. |
| 40 | `rest-to-graphql-mapper` | Backend / API | Backend | **RECOMMENDED** | Converts REST endpoints into declarative GraphQL schemas and resolvers. |
| 41 | `redis-cache-strategy` | Caching / Performance | Architecture | **RECOMMENDED** | Evaluates cache-aside, write-through, TTLs, and cache stampede mitigations. |
| 42 | `otel-instrumentation` | Observability / Telemetry | SRE | **RECOMMENDED** | Configures OpenTelemetry traces, metrics, span attributes, and exporter pipelines. |
| 43 | `playwright-e2e-generator` | E2E Testing | QA | **RECOMMENDED** | Generates resilient Playwright E2E tests with locator best practices. |
| 44 | `schema-migration-planner` | Database / SRE | Database | **RECOMMENDED** | Plans zero-downtime database migrations (Expand-Contract pattern). |
| 45 | `openapi-spec-generator` | API Documentation | Backend | **RECOMMENDED** | Reverse engineers or drafts OpenAPI 3.1 specifications from endpoints. |
| 46 | `dead-code-hunter` | Code Quality | Maintenance | **RECOMMENDED** | Cross-references symbol tables to find unreferenced methods, classes, and routes. |
| 47 | `github-actions-builder` | CI/CD | DevOps | **RECOMMENDED** | Builds hardened, cached GitHub Actions workflows with least-privilege tokens. |
| 48 | `jwt-security-audit` | Security / Auth | Security | **RECOMMENDED** | Audits JWT signing algorithms, expiration, audience, issuer, and claim revocation. |
| 49 | `tailwind-cleaner` | Frontend / CSS | Frontend | **RECOMMENDED** | Consolidates redundant Tailwind CSS utility classes into design tokens. |
| 50 | `changelog-generator` | Release / Documentation | Operations | **RECOMMENDED** | Compiles semantic release notes and CHANGELOG entries from conventional commits. |

---

## 2. Incorporation Strategy for the claude-agents Template

1. **Pre-installed Core (Skills 1–27)**:
   Already installed and available in `template/.agents/skills/`. They cover the complete development lifecycle: requirements analysis, architecture, security, testing, humanized writing, token efficiency, and document parsing.
2. **On-Demand Discovery via `find-skills`**:
   Agents use `npx skills find <keyword>` or `npx skills add <package>` to seamlessly pull any recommended skill (skills 28–50) into a repository as needed without bloating the initial template footprint.
