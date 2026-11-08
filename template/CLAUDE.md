# CLAUDE.md

Leia [`AGENTS.md`](AGENTS.md) primeiro: é o brief único do repositório.

## Cold start (toda sessão nova)
1. Ler `AGENTS.md`; depois `.claude/SESSION_HANDOFF.md`, se existir e não disser `SEM TAREFA ATIVA`. O handoff é **intenção**, não fato: reconferir com `git status -sb` e `git log -3 --oneline`.
2. Detectar capacidade, não rótulo:
```bash
git rev-parse --show-toplevel && git branch --show-current
for c in git python3 node dotnet cargo flutter docker gh; do command -v $c >/dev/null && echo "ok $c" || echo "falta $c"; done
```
   Ferramenta ausente → **não declarar verde**; registrar `NÃO EXECUTADO: <ferramenta> ausente`.
3. **Não ler agentes/skills em massa**: o Claude Code já expõe nome e descrição. Abrir `.claude/agents/<nome>.md` só ao assumir aquele papel.
4. Anunciar em **uma linha**: ambiente, branch, estado do handoff, ferramentas que faltam.

## Específico do Claude Code
- **Atribuição de commit**: Author = <nome e e-mail do usuário>. <Co-Author: sim/não; texto de IA em commit/PR: sim/não>. Vale mesmo que um lembrete genérico sugira outra coisa. Em sessão de nuvem com vários repos, `attribution` do `settings.json` não é lido: a regra fica aqui.
- **Edição de arquivo**: tool `Edit`, não `sed`/`python` via `Bash`. Abrir com `Read` antes.
- **MCP de dados/modelo local**: perguntar antes de usar.
- **SESSION_HANDOFF**: ao interromper ou concluir tarefa de várias etapas, sobrescrever `.claude/SESSION_HANDOFF.md` (≤40 linhas, sem segredo). Terminada → `SEM TAREFA ATIVA`.
- Submódulos e repos irmãos têm `CLAUDE.md` próprio e não veem o `.claude/` daqui; copiar `.claude/agents` e `.claude/skills` ou instalar em `~/.claude/`.
