---
name: bdd-spec-writer
description: Converte demanda em cenários BDD (Gherkin) executáveis, com ids rastreáveis até o teste. Use ao especificar comportamento novo, bug ou mudança de regra.
---

# Processo
1. **Atores e linguagem**: usar termos do glossário do projeto, se houver.
2. **Regras** (1 linha cada, "Regra: …"), depois **exemplos** concretos com dados reais — Specification by Example.
3. **Cenários** por regra: feliz, borda, erro, permissão/tenant, idempotência.
4. **Ids**: `R<req>.<n>` → viram prefixo do nome do teste (`R1_2_<descricao_em_ingles>`).
5. **Validar** com `openspec-validation`.

# Formato (Gherkin; palavras-chave em inglês, texto de domínio em português)
```gherkin
# language: pt
Funcionalidade: <comportamento> (R1)
  Regra: <regra de negócio em uma frase>

  Cenário: R1.1 <caso feliz>
    Dado <contexto com dados concretos>
    Quando <uma ação>
    Então <um resultado observável>

  Esquema do Cenário: R1.2 <variações de borda>
    Dado <x> igual a <valor>
    Então <resultado>
    Exemplos:
      | valor | resultado |
      | 0     | rejeita   |
```

# Regras de qualidade
- 1 `Quando` por cenário; `Então` verificável (valor, status, evento), nunca "funciona corretamente".
- Declarativo (o quê), não imperativo (cliques). Sem detalhe de UI/SQL.
- Cenário de **erro e permissão negada** obrigatórios em toda regra com acesso a dado.
- Mínimo de cenários que cobrem a regra; sem duplicata.
- Dado de teste: nunca real/pessoal.

# Mapa para teste
| Camada | Cenário vira |
|---|---|
| Regra de domínio/service | teste unitário xUnit (nome em inglês, id no nome) |
| Rota/contrato | teste de integração (`WebApplicationFactory`) |
| Persistência/tenant | integração com banco real (container) |
| Fluxo de UI | teste de widget/integração Flutter |

# Saída
Bloco `## Spec` pronto para colar no item de backlog + tabela `id → camada de teste`. Lacunas viram **perguntas** ao usuário (máx. 3).
