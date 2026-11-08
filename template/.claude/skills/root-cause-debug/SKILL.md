---
name: root-cause-debug
description: Depuração estruturada: reproduzir, isolar, diagnosticar, corrigir com teste de regressão. Use com stack trace, "quebrou após deploy" ou comportamento divergente.
---
# Ciclo
1. **Reproduzir**: esperado × real, passos exatos, escopo (quando começou, quem afeta). Sem reprodução → não "corrigir", coletar dado.
2. **Isolar**: `git log -p --since=... -- <caminho>`, `git bisect` se há commit bom conhecido; config/env/dependência mudou?; logs com `TraceId` (`telemetry-tracing`).
3. **Diagnosticar**: 1 hipótese por vez, teste que a refuta; causa-raiz, não sintoma. Registrar hipóteses descartadas (1 linha cada).
4. **Corrigir**: menor mudança. **Primeiro** o teste de regressão vermelho (`@qa-engineer`), depois o fix, depois verde.
4b. **Irmãos**: achada a causa, `grep` os outros consumidores/adaptadores com o mesmo padrão; verificar cada suspeita e **agrupar por causa-raiz** (um registro, não um por sintoma). Corrigir no **produtor** do dado/regra antes de remendar quem consome.
5. **Prevenir**: guarda/validação/alerta; se é classe de bug repetida → item de backlog.

# Atalhos neste repo
- 500+ testes "passando" mas pulados → Docker fora; ver "Skipped".
- 400 em runtime com build limpo → EF compiled models: `dotnet ef dbcontext optimize`.
- Migration quebra com linhas → coleção primitiva sem `HasDefaultValueSql`.
- Erro 401 em massa/foto → fallback sem crash (regra de requisição).

# Limites
Sem produção/MCP de dados sem pedido do usuário. Não "consertar" teste para passar. Afirmar causa só com evidência.

# Saída (≤15 linhas)
`SINTOMA | REPRODUÇÃO | CAUSA-RAIZ (evidência) | FIX | TESTE DE REGRESSÃO | PREVENÇÃO`.
