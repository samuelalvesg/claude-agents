---
name: test-strategy
description: Plano de testes por camada (unitário, integração, contrato, UI) para este repo. Use ao planejar a cobertura de uma mudança, achar lacunas ou decidir o tipo de teste.
---
# Regra do repo
Toda mudança traz **unitário + integração**; bug traz **regressão** (ADR 0016). Reusar helpers existentes.

# Pirâmide aplicada
| Camada | Ferramenta | Quando | Mínimo |
|---|---|---|---|
| Regra de domínio/service | xUnit (mock de borda) | lógica pura | 1 por regra + borda |
| Rota/contrato | integração HTTP | endpoint novo/alterado | feliz, 4xx, authz/tenant |
| Persistência/migration | integração com banco real (container) | repositório, ORM, migration | com ≥1 linha pré-existente |
| Widget/estado Flutter | `flutter test` | tela, provider | 5 estados (carregando/vazio/erro/offline/ok) |
| Rust | `#[cfg(test)]` + `tests/` | crate | invariante + erro de I/O |
| App abre / código nativo | `integration_test` + `flutter drive` (web, Android) ou `flutter test -d linux` | bootstrap, plugin ou versão de plugin, `web/pkg`, FFI | cold start + núcleo Rust responde + 1 verificação por plugin de risco |
| Fluxo ponta a ponta | poucos, caros | caminho crítico | só o essencial |

# Cobrir / pular
Cobrir: caminho crítico de negócio, erro, borda (nulo, vazio, fuso, concorrência), fronteira de segurança, integridade de dado, idempotência.
Pular: getter/setter trivial, código de framework, script descartável.

# Passos
1. Listar cenários da spec (`bdd-spec-writer`); mapear cada um à camada.
2. Procurar teste existente: `grep -rn "<símbolo>" <pasta-de-testes>` (ver `AGENTS.md`).
3. Apontar lacunas (cenário sem teste). Nome do teste = id do cenário + descrição em inglês.
4. Rodar; backend exige "Skipped: 0".

# Armadilhas conhecidas (exemplos de Flutter/Rust; adaptar à stack)
- Teste que procura **texto de tela** envelhece: um teste buscava um botão renomeado e falhava na linha de base boa. Preferir chave ou tipo de widget.
- Web: `flutter drive` precisa de `chromedriver` do mesmo Chrome; no contêiner, `--no-sandbox`.
- Teste que depende de biblioteca nativa precisa dela compilada; sem ela falha no setup. É ambiental, não regressão.
- Teste que só passa não prova nada: **provar por mutação** (voltar o código antigo e ver o teste falhar). Guarda de segurança idem.

# Saída (≤15 linhas)
`CENÁRIO | CAMADA | TESTE (existe/falta) | RISCO`.
