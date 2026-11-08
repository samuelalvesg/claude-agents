# AGENTS.md - Brief para Agentes de IA

Arquivo único e canônico para qualquer agente (Claude Code, Cursor, Aider…).
`CLAUDE.md` aponta para cá. Fato detalhado vive nos arquivos linkados, não aqui.

## O que é o projeto
<uma frase: o que é, stack, quem usa>

## Mapa do repositório
| Pasta | Conteúdo |
|---|---|
| `<pasta>` | <...> |

## Onde ler antes de mexer em quê
| Tarefa | Leia primeiro |
|---|---|
| <tarefa> | <link> |

## Convenções críticas
- **Testes em toda implementação**: todo PR de código traz testes unitários e de integração da mudança; bug corrigido traz teste de regressão. Reutilize os helpers existentes.
- **Idioma**: código novo (nomes, comentários, nomes de teste) em inglês; texto exibido ao usuário, `.md` e mensagem de commit em <idioma do projeto>. Não traduzir arquivo existente "de passagem".
- **Comentários**: só o **porquê** não óbvio. Nunca histórico ("antes era X") nem o que o nome já diz; isso fica no `git blame` e no commit.
- **Reutilizar em vez de duplicar.** Achado/dívida vai para o **backlog**, não para o chat.
- **Documentação**: afirmação sobre o estado do código só com `grep`/leitura desta sessão; senão "não verificado". Número em documento sai de script.
- **Quantidade de PRs**: o mínimo possível. Acumule mudanças relacionadas no mesmo PR em **draft**; marque como pronto só no fim. CI roda só ao marcar pronto para review. O usuário faz o merge.
- **Git**: commit/push só quando o usuário pedir; nunca direto na branch principal; nunca `--force`/`reset --hard` em branch alheia.

## Equipe de agentes (`.claude/agents/`, `.claude/skills/`)
Pipeline: `@spec-analyst` → `@architect` → `@developer` (uma cópia por stack) → `@qa-engineer` → `@reviewer`.
Por gatilho: `@secops-engineer` (segurança/dependência/release), `@sre-database` (migration, query, telemetria), `@refactoring-architect` (débito, diff separado).

- **Um dono por vez.** Só `@architect`/`@spec-analyst` mudam spec e contrato; só devs mudam código de produção; só `@qa-engineer` muda teste de aceitação; `@reviewer` e `@secops-engineer` só leem.
- **Handoff** é o único canal entre agentes (≤25 linhas):
```
HANDOFF @de → @para
ITEM: <caminho do item de backlog>
ESCOPO: <arquivos/módulos que PODEM mudar>
FORA: <o que NÃO mexer>
CONTRATO: <rota/DTO/evento, antes → depois>
CENÁRIOS: <ids da spec que o QA vai testar>
RISCOS: <migration? contrato? multi-tenant?>
ORDEM: <quem primeiro>
AMBIENTE: <shell? ferramentas que faltam>
```
- **Retorno**: `RETORNO @de → @para | STATUS: OK|BLOQUEADO|DIVERGENTE` + FEITO / NÃO EXECUTADO / PENDENTE. Fora do ESCOPO ou spec divergente → `BLOQUEADO` ao `@architect`; nunca expandir sozinho.
- Em Claude Code: tool `Agent` com `subagent_type: <nome>` e o handoff literal como prompt (o subagente não herda a conversa). Sem subagentes: abrir `.claude/agents/<nome>.md` e trocar de papel escrevendo `[PAPEL: @nome]`.

**Limites rígidos (nenhum agente faz sozinho):** merge ou PR pronto sem testes verdes; mexer em credenciais/`.env`/produção; apagar o que não criou; enviar dados a serviço externo; enfraquecer, pular ou apagar teste para passar.

## Comandos úteis
<build / test / lint>
