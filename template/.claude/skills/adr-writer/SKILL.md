---
name: adr-writer
description: Escreve ADR (formato Nygard do repo) e desenha o sistema com requisitos, alternativas e trade-offs explícitos. Use em decisão de arquitetura, tecnologia ou fronteira de módulo.
---
# Convenção do repo (`docs/ADR/README.md`)
Arquivo `NNNN-titulo-curto.md` (próximo número sequencial; conferir `ls docs/ADR`). Seções: **Status** (`Aceito|Proposto|Descontinuado|Sob revisão`), **Contexto**, **Decisão**, **Consequências**. ADR aceito **não se edita**: novo ADR + marcar o antigo `Descontinuado`. Atualizar o índice do README.

# Antes de escrever
`grep` em `docs/ADR` e o backlog do projeto por decisão prévia (não re-litigar o que o usuário já decidiu). Requisitos funcionais e não funcionais (escala, latência, custo, equipe), restrições.

# Estrutura de decisão
1. Requisitos e restrições (numerados).
2. ≥2 alternativas, incl. "não fazer": complexidade, custo, escala, familiaridade da equipe, reversibilidade.
3. Trade-off em 3–5 linhas; **uma recomendação**.
4. Consequências: o que fica mais fácil, mais difícil, o que revisitar (gatilho mensurável).
5. Diagrama Mermaid com **pacotes e estado** (✅🟡📝, ❓ em aberto) — ordem do usuário nº 9.

# Regras
Estado do código só com `grep` desta sessão; senão "não verificado". Preço, licença e jurídico: pergunta ao usuário, não decide. Número calculado por script.

# Saída
Arquivo ADR pronto + linha do índice. Status `Proposto` até o usuário aceitar.
