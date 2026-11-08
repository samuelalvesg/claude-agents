---
name: code-smell-eliminator
description: Algoritmo de decisão smell → refactoring (Fowler/GoF/SOLID) para método longo, classe acoplada, duplicação e violações de SOLID, preservando comportamento. Use sob rede de testes.
---

# Pré-condição (bloqueante)
Testes cobrem o trecho e estão **verdes**. Senão: pedir `@qa-engineer` para teste de caracterização. Refactor ≠ feature: diff separado.

# Medir (não chutar)
- Tamanho: `wc -l <arquivo>`; limites do repo nas regras de estilo citadas no `AGENTS.md`.
- Complexidade ciclomática: analisador do projeto se houver (`dotnet build` com regra CA1502; `dart analyze`/DCM); senão contar `if/for/while/case/&&/||/catch`. Alvo prático: ≤10 por método.
- Duplicação: `grep -rn "<trecho distintivo>"` + leitura; 3ª ocorrência = abstrair.

# Árvore de decisão
```
Método > ~30 linhas ou CC > 10?
  ├─ blocos com comentário/nome implícito → Extract Method
  ├─ muitos parâmetros → Introduce Parameter Object
  ├─ condicional por tipo → Replace Conditional with Polymorphism / Strategy (GoF)
  └─ ninhos de if → Guard Clauses (retorno antecipado)
Classe faz 2+ coisas (SRP) / "God class"?
  └─ Extract Class / Extract Interface (separar por razão de mudar)
Classe usa mais dados de outra que os seus (Feature Envy)?
  └─ Move Method
Acoplamento a concreto / `new` de dependência (DIP)?
  └─ Introduce interface + DI (construtor)
Mesma lógica em 3+ lugares (DRY)?
  └─ Extract Method/Class compartilhado; reaproveitar o existente primeiro
Switch/flag que cresce a cada feature (OCP)?
  └─ Strategy / registro de handlers
Herança só para reuso (LSP/composição)?
  └─ Replace Inheritance with Delegation
Primitivos repetidos (CPF, dinheiro, id)?
  └─ Value Object (DDD)
Nada acima e o código é só feio?
  └─ Rename / deixar. KISS: não criar abstração especulativa.
```

# Loop
1. Escolher **um** refactoring. 2. Aplicar. 3. Rodar testes do módulo. 4. Verde → próximo; vermelho → reverter o passo (não "consertar" o teste). 5. Ao fim, medir de novo e comparar.

# Proibido
Mudar contrato público/comportamento; renomear em massa sem `graph-mapping`; traduzir arquivo para inglês de passagem; padrão de projeto sem dor concreta; comentário de histórico ("antes era…").

# Saída (≤15 linhas)
`SMELL | REFACTORING | linhas/CC antes→depois | testes (total/verde)`.
