---
name: tech-debt-triage
description: Identifica, categoriza e prioriza débito técnico e registra no backlog (não no chat). Use em auditoria de qualidade ou ao decidir o que refatorar primeiro.
---
# Antes
Conferir o registro de problemas conhecidos do projeto (ex.: `docs/KNOWN_ISSUES.md`): não é "descoberta nova" se já está lá.

# Categorias
Código (duplicação, God class) · Arquitetura (acoplamento, ciclo entre pacotes) · Teste (sem rede, flaky, skip) · Dependência (vulnerável, abandonada) · Documentação (fato duplicado/desatualizado) · Infra (deploy manual, sem métrica).

# Pontuação
`Prioridade = (Impacto + Risco) × (6 − Esforço)`; cada um de 1–5. Medir o que for medível por comando (`wc -l`, `grep -c`, `dotnet list package --vulnerable`), não estimar a olho.

# Passos
1. Coletar evidência (arquivo:linha, contagem por script).
2. Classificar e pontuar.
3. Ordenar; propor fases que cabem junto de feature (um refactoring por diff, com `code-smell-eliminator`).
4. Gravar como item no backlog do projeto + linha no índice.

# Saída (≤20 linhas)
`ITEM | categoria | I | R | E | prioridade | evidência | fase`.
Quem executa: `@refactoring-architect` (código), `@sre-database` (banco/infra), `@secops-engineer` (dependência).
