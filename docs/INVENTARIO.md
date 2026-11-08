# Inventário das configurações de agentes (2026-11-08)

Fonte: leitura dos repositórios em 2026-11-08. Não verificado: execução dos agentes.

| Repo | Config de agentes |
|---|---|
| Symmetris (docs) | `AGENTS.md` (352 linhas), `CLAUDE.md`, `.claude/` com 10 agentes + 3 perfis locais (`agents/local/`), 23 skills, `settings.json`, `SESSION_HANDOFF.md`, `NOTICE.md`; `.agents/` (rules, skills caveman/compress, MCP próprios); `.clinerules`, `.cursorrules`, `.codex`, `.mcp.json`. |
| Symmetris-backend | `AGENTS.md` (121 linhas) e `CLAUDE.md` apontando para o `AGENTS.md`. Sem `.claude/`. |
| Symmetris-frontend | `AGENTS.md` (139) e `CLAUDE.md` idem. Sem `.claude/`. |
| vauedge | `AGENTS.md` (26: idioma, submódulo proto, quantidade de PRs) e `CLAUDE.md` idem. Sem `.claude/`. |
| bible_with_me | `CLAUDE.md` apontando para `AGENTS.md`. |

## Padrão que se repete (virou o template)
- `AGENTS.md` como brief único, `CLAUDE.md` como ponteiro + cold start.
- Pipeline spec → arquitetura → dev → QA → review, com especialistas por gatilho.
- Handoff estruturado como único canal; `SESSION_HANDOFF.md` entre sessões.
- Cada agente: Execução (declarativo × exige shell), SOUL, Fluxo, Boundaries, Memory Strategy.
- Regras de PR (mínimo, draft, CI ao liberar), testes em toda mudança, idioma do código, comentários só de porquê.

## Lacunas e inconsistências encontradas
1. **Agentes e skills só existem no repo de docs.** Em thread aberta só no backend, frontend ou vauedge o `.claude/` não é carregado (o próprio `CLAUDE.md` admite). O `install.sh` resolve copiando para cada repo, mas a duplicação precisa de uma fonte única (este repo).
2. **Atribuição de commit**: a memória do projeto diz "Co-Author = IA", o `CLAUDE.md` do Symmetris diz que o Co-Author foi removido em 2026-11-07, e o lembrete de atribuição da sessão manda adicionar `Co-Authored-By`. Precisa de decisão do Samuel; o template deixa como placeholder.
3. **`.agents/rules/*` com `trigger: always_on`** é convenção de outra ferramenta; o Claude Code não carrega sozinho. No template, as regras vão direto para o `AGENTS.md` ou são linkadas na tabela "Onde ler".
4. **`settings.json`** (`attribution` vazio, MCPs) não é lido em sessão de nuvem com vários repos.
5. `AGENTS.md` do Symmetris tem 352 linhas; o template mantém só convenções e links.
6. Não verificado: se subpastas de `.claude/agents/` (como `local/`) são carregadas.
