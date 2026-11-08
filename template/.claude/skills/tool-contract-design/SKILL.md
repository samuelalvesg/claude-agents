---
name: tool-contract-design
description: Projeta contrato de ferramenta/endpoint (tools de IA, gRPC, API) com um contrato único, efeitos declarados, resultado estruturado e resumo primeiro. Use ao criar tool de IA no backend, RPC ou rota nova.
---
# Princípio
**Tudo é um contrato único** consumido por qualquer wrapper (app, CLI, IA, SignalR/gRPC). Regra de negócio mora no Application Service; wrapper só traduz. Começar pela **pergunta que o consumidor quer responder**, reaproveitar contrato existente (`grep` antes).

# Ficha do contrato
| Campo | Regra |
|---|---|
| `id` | verbo + objeto, estável (`list_events`) |
| `resumo` | 1 linha; para modelo leve (qwen 7b) o nome e o resumo **são** a documentação |
| `parâmetros` | poucos; **nomes, não ids** para a IA; tipos fechados; schema validado |
| `efeito` | **L**eitura · **R**eversível · **E**scrita irreversível/externa (E passa por fila de aprovação). IA **não tem "excluir"** |
| `requer` | permissão/papel/tenant; falta de permissão = erro estruturado |
| `resultado` | campos tipados (decisão **nunca** por texto em português); resumo primeiro + paginação (`offset`/`limit`); dado para IA em TOON |
| `cobertura` | o que foi examinado/truncado; resultado parcial é marcado |
| `erro` | código estável + causa + o que fazer (recuperação no ponto de uso) |
| `idempotência` | escrita repetida não duplica (chave) |

# Regras
- Limite só onde há restrição real (formato, protocolo, autoridade, recurso); calcular expansão antes de alocar.
- Contrato versionado (campo de versão); mudança incompatível = backend primeiro + plano para o app.
- Nova capacidade com **efeito/autoridade/escopo em aberto** → não integrar (fail-closed); perguntar ao usuário.
- Efeito declarado de forma honesta: tool que escreve não pode se apresentar como leitura.
- Não consertar defeito de contrato com texto de skill/prompt; consertar o contrato.
- Nova tool de IA nasce no **backend** (decisão vigente); as do app não se removem.

# Verificação
Teste de contrato (schema), de permissão/tenant, de resultado parcial e de erro; checar que o nome/resumo basta para um modelo leve escolher a tool (com um modelo pequeno, se o projeto usar).

# Saída
Ficha preenchida + delta de contrato (ADDED/MODIFIED/REMOVED) para o handoff do `@architect`.
