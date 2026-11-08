---
name: a11y-audit
description: Auditoria de acessibilidade (WCAG 2.1/2.2 AA) para telas Flutter/Web. Use antes de entregar tela nova ou em revisão de UI.
---
# Critérios (conferir contra o texto oficial do WCAG ao reportar)
- Contraste: texto ≥ 4,5:1 (grande ≥ 3:1); componente/gráfico ≥ 3:1 (1.4.3, 1.4.11).
- Teclado: tudo operável, ordem de foco lógica, foco visível, sem armadilha (2.1.1, 2.4.3, 2.4.7).
- Alvo de toque: o 2.5.8 (AA, WCAG 2.2) pede ≥ 24×24 px; a referência prática de plataforma é **48 dp (Android) / 44 pt (iOS)**. O 2.5.5 (44 px) é nível **AAA**, não AA.
- Nomes/papéis: todo controle com rótulo acessível (4.1.2); erro descrito em texto, não só cor (3.3.1, 1.4.1).
- Zoom/fonte 200%: layout não quebra; sem texto cortado.
- Movimento: respeitar "reduzir animação" (o projeto já usa `prefersReducedMotion`).

# Flutter
- `Semantics(label:, button:, ...)` onde o widget não for semântico; `ExcludeSemantics` só em decoração.
- Testes: `await expectLater(tester, meetsGuideline(androidTapTargetGuideline))`, `iOSTapTargetGuideline`, `labeledTapTargetGuideline`, `textContrastGuideline`.
- Verificar com TalkBack/VoiceOver quando possível; o automático pega só parte.

# Saída (≤20 linhas)
`# | problema | critério | gravidade (crítico/maior/menor) | correção`. Itens não testados em leitor de tela: "não verificado".
