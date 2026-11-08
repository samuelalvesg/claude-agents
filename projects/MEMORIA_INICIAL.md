# Memória inicial sugerida (um fato por arquivo, formato do project memory)

Salvar cada item como memória própria. Conferir datas e marcar o que mudou.

1. **usuario-e-idioma** (user): <nome>, GitHub <login>, escreve em pt-BR; responder em português.
2. **repos-de-trabalho** (project): quais repos são de trabalho e quais são só referência; submódulos e onde cada PR vai.
3. **regra-de-prs** (feedback): mínimo de PRs, draft, CI só ao marcar pronto, merge pelo usuário. Por quê: custo de GitHub Actions.
4. **idioma-do-codigo** (feedback): código e comentários em inglês; `.md` e commit em pt-BR.
5. **testes-em-toda-mudanca** (feedback): unitário + integração; regressão para bug.
6. **atribuicao-de-commit** (feedback): DECIDIR (ver `docs/INVENTARIO.md` item 2) e gravar a decisão final com data.
7. **ordem-de-merge** (project): <ex.: proto → daemon → backend → frontend>.
8. **decisoes-de-arquitetura** (project): uma memória por decisão duradoura, com Why e How to apply; o detalhe vive em ADR, a memória só aponta.
9. **equipe-de-agentes** (reference): este repo (`claude-agents`) é a fonte do template; `install.sh` copia para cada repo.

Não salvar: estrutura de código, histórico de git, nada que o `AGENTS.md` já diga.
