# O que trabalhar a seguir (template de agentes)

Ordem sugerida; cada item é uma decisão ou entrega pequena.

1. **Decidir a atribuição de commit** (Co-Author sim/não) e gravar em `CLAUDE.md` e na memória. Hoje as três fontes divergem.
2. **Instalar o template nos repos de trabalho sem `.claude/`**: Symmetris-backend, Symmetris-frontend, vauedge (um PR draft por repo, via `install.sh`), com `developer.md` copiado por stack (C#, Dart, Rust).
3. **Fonte única**: tornar este repo a origem e fazer o Symmetris passar a consumir o template (ou um script de sincronização) para não haver cópias divergentes.
4. **Migrar `rust-dev`** e os perfis `local/` (Ollama) como pacote opcional deste repo.
5. **Genericizar mais skills** ainda acopladas: `telemetry-tracing`, `query-performance-tuner`, `diagram-generator`, `auto-doc-updater`.
6. **Teste do template**: script que roda `install.sh` num diretório vazio e valida frontmatter (`name`, `description`, `tools`, `model`) de cada agente e skill.
7. **Revisar `AGENTS.md` do Symmetris** (352 linhas) separando regras permanentes de estado/status, que envelhece.
8. **Colar** `INSTRUCOES_CLAUDE_PROJECTS.md` e `MEMORIA_INICIAL.md` nas configurações do Claude Projects.
