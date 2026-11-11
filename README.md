# claude-agents

Template reutilizável de equipe de agentes para Claude Code, extraído dos repositórios
Symmetris, Symmetris-backend, Symmetris-frontend e vauedge (ver [`docs/INVENTARIO.md`](docs/INVENTARIO.md)).

## O que tem

| Pasta | Conteúdo |
|---|---|
| `template/` | O que vai para a raiz do projeto novo: `AGENTS.md`, `CLAUDE.md`, `.agents/` (agents, skills, rules), links simbólicos em `.claude/` e `.cursor/`, settings, SESSION_HANDOFF, NOTICE. |
| `projects/` | Texto para colar no **Claude Projects** (instruções e memória) e a lista do que trabalhar. |
| `environments/` | Setup script do ambiente de nuvem (campo "Setup script"). `symmetris-setup-env.sh`: .NET 10, Flutter, Docker, Rust; versões por variável de ambiente. Específico do Symmetris: usar como modelo. |
| `docs/` | Inventário das configurações existentes e lacunas encontradas. |
| `install.sh` | Copia `template/` para um repo, sem sobrescrever o que já existe. |

## Uso

```bash
./install.sh /caminho/do/projeto          # não sobrescreve
./install.sh /caminho/do/projeto --force  # sobrescreve
```

Depois:
1. Preencher os `<placeholders>` de `AGENTS.md` e `CLAUDE.md` (projeto, mapa, atribuição de commit, idioma).
2. Copiar `.agents/agents/developer.md` uma vez por stack (`backend-dev.md`, `frontend-dev.md`…) e preencher "Stack".
3. Adaptar as skills que citam stack (`owasp-sanitizer`, `test-strategy`, `a11y-audit`, `graph-mapping`: exemplos .NET/Flutter/Rust).
4. Colar `projects/INSTRUCOES_CLAUDE_PROJECTS.md` e `projects/MEMORIA_INICIAL.md` nas configurações do projeto no claude.ai.

## Equipe

`spec-analyst` → `architect` → `developer` → `qa-engineer` → `reviewer`; por gatilho `secops-engineer`, `sre-database`, `refactoring-architect`, `copywriter-humanizer`. Handoff estruturado é o único canal entre agentes.

## Fora do template (de propósito)

`rust-dev` e `backend-dev`/`frontend-dev` específicos (viram cópias do `developer`), perfis de modelo local (Ollama), skills `local-llama-bridge`, `auto-doc-updater`, `diagram-generator`, `query-performance-tuner`, `telemetry-tracing`, `ux-copy-ptbr` e o `.agents/` (MCP próprios): acopladas ao Symmetris. Copiar do repo de origem sob demanda.

Licença Apache-2.0; ver `template/.claude/NOTICE.md` para skills derivadas.

Teste: `tests/validate.sh` (frontmatter de agentes/skills e idempotência do `install.sh`).
