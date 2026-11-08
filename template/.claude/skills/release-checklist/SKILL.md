---
name: release-checklist
description: Checklist pré-deploy com critérios de rollback decididos antes. Use antes de pedir merge de release ou deploy (Coolify). Não executa deploy.
---
# Pré
- [ ] Testes verdes: backend `Skipped: 0`; frontend `test`+`analyze` sem aviso novo vs baseline; Rust `fmt`/`clippy -D warnings`/`test`
- [ ] Review (`@reviewer`) e, se houver gatilho, `@secops-engineer`
- [ ] Migration: `check-migrations.py`, `dbcontext optimize`, testada com linhas; **reversível** ou plano em 2 fases
- [ ] Contrato de API mudou → backend publicado primeiro; `docs/API.md` atualizado
- [ ] Config por ambiente (12-Factor III); nenhum segredo no diff
- [ ] Rollback documentado em `docs/anexos/RUNBOOK.md` (como voltar app e banco)
- [ ] Docs: scripts de checagem listados no `AGENTS.md` comparados ao baseline
- [ ] Builds de outras plataformas: **pausados** — só com confirmação do usuário

# Deploy (somente o usuário/pessoa autorizada executa)
Staging → smoke → produção (canário se existir) → observar 15 min (erro, p95, filas CAP/outbox).

# Gatilhos de rollback (definir **antes**)
Taxa de erro > X% · p95 > X ms · fluxo crítico falha · fila crescendo sem escoar. Preencher X com baseline medido; sem baseline → "não medido".

# Pós
Métricas nominais · changelog · fechar itens no backlog (`Status: ✅ Concluído` no arquivo do item).

# Saída
Checklist marcada com evidência por linha; item sem evidência = ☐ "não verificado". Agente **não** faz deploy nem notifica ninguém.
