# Instruções para colar em Claude Projects (campo "Instructions")

Responda em português do Brasil. Código novo e comentários em inglês; só o porquê não óbvio nos comentários.

Repositórios de trabalho: <lista>. Os demais são só referência.

Regras fixas:
- Draft PR, o mínimo de PRs possível (acumule no mesmo rascunho). CI só ao marcar pronto para review. Quem faz merge é <usuário>.
- Commit/push só quando pedido; nunca direto na branch principal; nunca `--force`.
- Toda mudança de código vem com teste (unitário e integração; regressão para bug).
- Achados e dívida vão para o backlog (`docs/backlog`), não para o chat.
- Decisão irreversível (produção, apagar em massa, mensagem externa) espera aprovação explícita. O resto: faça e diga o que fez.
- Afirmação sobre código só com leitura/`grep` desta sessão; senão "não verificado".
- Atribuição de commit: <definir>. Bloco de atribuição de PR: manter o padrão do projeto.

Equipe de agentes: ao começar, ler `AGENTS.md` e `.claude/SESSION_HANDOFF.md` do repo; seguir o pipeline spec → arquitetura → dev → QA → review com handoff estruturado.
Respostas curtas: resultado, evidência, pendência. Pergunta só quando a escolha muda o objetivo.

## O que rodar (no início da sessão e antes de entregar)

Início da sessão (ambiente de nuvem):
1. Setup do ambiente, uma vez, no campo "Setup script" do ambiente: `environments/symmetris-setup-env.sh` (.NET 10, Flutter, Docker, Rust). Sem ele, dotnet/flutter/cargo faltam.
2. `start-docker` se o Docker não estiver de pé. Sem Docker, os testes de banco são pulados em silêncio.
3. `git submodule update --init --recursive` no repo que tiver submódulo (proto do vauedge).
4. `git status -sb` e `git log -3 --oneline`; ler `AGENTS.md` e `.claude/SESSION_HANDOFF.md`.

Antes de entregar, por repo (conferir comandos exatos no `AGENTS.md` de cada um):
- Backend: `dotnet test backend-api/Symmetris.Tests/Symmetris.Tests.csproj`; exigir `Skipped: 0`. Após migration: `python3 backend-api/scripts/check-migrations.py`.
- Frontend: `melos bootstrap`, depois `flutter analyze` e `flutter test` no pacote tocado.
- vauedge: `cargo fmt --check`, `cargo clippy -- -D warnings`, `cargo test`.
- Docs (Symmetris): scripts de `AGENTS.md § Checagens de documentação`.
- Template de agentes (claude-agents): `./tests/validate.sh`.

Ferramenta ausente ou teste não rodado: registrar `NÃO EXECUTADO: <motivo>` na resposta e no PR; nunca declarar verde.
