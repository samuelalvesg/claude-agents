---
name: ui-handoff-spec
description: Especificação de tela para implementação: estados, tokens, responsivo, bordas, acessibilidade. Use no spec-analyst/architect antes de pedir tela ao frontend-dev, ou no frontend-dev para checar o que falta.
---
# Princípios
Não deixar o dev adivinhar. Usar **tokens/tema do app**, não valores soltos (`grep` o tema do pacote antes; não criar token paralelo). Descrever o porquê de decisões de UX.

# Checklist da tela
- **Estados** (todos): carregando · vazio · erro · offline · sem permissão · parcial/ok · desabilitado.
- **Conteúdo**: limites de caracteres, truncamento, dados ausentes, texto longo (pt-BR), números/datas/fuso.
- **Responsivo**: celular, tablet, desktop/web; mínimo e máximo de conteúdo.
- **Interação**: toque/clique, foco/teclado, gesto, atalhos, feedback (ripple, snackbar), animação (duração; respeitar reduzir movimento).
- **Dados**: de qual provider/endpoint vêm; comportamento offline e conflito de sync.
- **Permissão**: quem vê/age (papéis do glossário).
- **Acessibilidade**: `a11y-audit`. **Texto**: `ux-copy-ptbr`.
- **Reuso**: widgets existentes que serve (listar), o que é realmente novo.

# Saída
Seção `## Spec` (cenários Gherkin de `bdd-spec-writer`) + tabela `elemento | estado | comportamento | token/widget`. Sem mockup inventado: se faltar design, perguntar ao usuário.
