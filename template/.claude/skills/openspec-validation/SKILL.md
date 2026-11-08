---
name: openspec-validation
description: Cria e valida spec (estilo OpenSpec) antes do código: requisitos SHALL, cenários WHEN/THEN, delta de contrato. Use antes de implementar mudança de comportamento ou de API.
---

# Quando
Mudança de comportamento, contrato (rota, DTO, SignalR, CAP) ou regra de negócio. Não para typo, refactor sem efeito externo ou doc.

# Onde mora
Seção `## Spec` no item do backlog (reuso; sem pasta nova). Requisito duradouro → também o documento de requisitos do projeto; decisão → ADR.

# Formato
```
## Spec
### R1 <nome curto>
O sistema SHALL <comportamento observável>.
#### Cenário R1.1 <nome>
- WHEN <pré-condição/ação>
- THEN <resultado verificável>
### Delta de contrato (se houver)
ADDED: POST /api/x {req}→{res}
MODIFIED: GET /api/y campo z: string→string?
REMOVED: —
### Fora de escopo
- ...
```

# Validar (todas devem passar)
1. Cada requisito tem ≥1 cenário; cada cenário é **testável** (resultado observável, sem "adequado/rápido").
2. Sem ambiguidade: termos do domínio batem com `docs/anexos/GLOSSARIO.md`.
3. Delta de contrato lista ADDED/MODIFIED/REMOVED e quem consome (use `graph-mapping`).
4. Casos de borda explícitos: vazio, nulo, tenant errado, soft-deleted, permissão negada, idempotência.
5. Compatibilidade: quebra de contrato → backend primeiro + plano para o app.
6. "Fora de escopo" preenchido.
7. Nada sobre estado atual do código sem `grep` nesta sessão; senão "não verificado".

# Saída
`SPEC OK` ou lista numerada do que falta (≤10 linhas). Ids de cenário vão para o handoff; o `@qa-engineer` os usa como nomes de teste.
