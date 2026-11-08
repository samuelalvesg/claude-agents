---
name: incident-postmortem
description: Triagem de incidente, atualização de status e postmortem sem culpa. Use quando algo quebrou em produção. Texto para cliente é rascunho; o envio é do usuário.
---
# Severidade
SEV1 serviço fora para todos · SEV2 função principal degradada · SEV3 função menor, parte dos usuários · SEV4 cosmético.

# Fluxo
1. **Triagem**: sintoma, quem afeta, desde quando, o que mudou (deploy/config/dependência). Consultar `docs/anexos/RUNBOOK.md` (rollback, migration reversa) **antes** de improvisar.
2. **Mitigar**: reverter > consertar. Ação em produção é do usuário; o agente propõe e documenta.
3. **Linha do tempo**: UTC, só fatos.
4. **Postmortem** (blameless) → o backlog como item (`Status`), com ação e dono.

# Atualização (≤8 linhas)
`SEV | status (investigando/identificado/monitorando/resolvido) | impacto | feito | próximo + horário`

# Postmortem
Resumo (2–3 linhas) · Impacto (usuários, duração; número só se medido) · Linha do tempo · Causa-raiz + 5 porquês (parar quando virar processo/sistema, não pessoa) · O que funcionou/falhou · Ações (dono, prioridade) · Detecção: por que o alarme não pegou antes (`telemetry-tracing`).

# Limites
Nunca enviar comunicado a cliente/Slack/e-mail; só rascunho. Sem culpar pessoa. Sem dado pessoal no documento.
