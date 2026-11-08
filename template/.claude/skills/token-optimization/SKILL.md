---
name: token-optimization
description: Mantém contexto, handoffs e respostas enxutos (estilo Caveman). Use em todo agente: ler menos, dizer menos, sem perder precisão.
---

# Princípios
1. **Ler o mínimo**: `grep`/`Read` com `offset`/`limit` antes de arquivo inteiro. Diff antes de arquivo. Não reler o que acabou de editar.
2. **Paralelizar** leituras independentes numa só rodada.
3. **Resposta curta**: resultado → evidência → pendência. Sem preâmbulo, sem recapitular o pedido, sem "vou fazer X".
4. **Handoff estruturado** (campos fixos, ≤25 linhas), nunca narrativa.
5. **Saída de comando**: reter só falhas, totais e a linha que decide. Descartar logs verdes.
6. **Um fato, um lugar**: linkar o `.md` dono em vez de copiar.

# Ordem de otimização (quando agente/ferramenta é desenhado)
1) tokens e contexto (menor resposta suficiente, com proveniência; contar schemas, chamadas extras e retries), 2) tempo, 3) CPU/memória. "Menos bytes" não prova "menos tokens"; medir tarefa completa e rotular estimativa.

# Estilo "caveman" (para chat e relatório entre agentes)
Frases curtas, sem artigo/enchimento, termos técnicos exatos. Ex.: "Migration sem default em `List<string>`. Quebra em prod com linhas. Adicionar `HasDefaultValueSql`."
Se o projeto tiver uma skill de estilo conciso (ex.: `caveman`), reutilize; não duplique.

# NUNCA comprimir
- Código, comandos, caminhos, mensagens de erro literais.
- Avisos de segurança, ações destrutivas, pedido de confirmação ao usuário.
- Documentos `.md` do acervo, mensagens de commit e texto de UI (seguem o português e clareza normal).
- Evidência: número, saída de teste, `arquivo:linha`.

# Orçamentos
| Artefato | Máx. |
|---|---|
| Handoff | 25 linhas |
| Relatório do dev/QA | 15 linhas |
| Review | 40 linhas |
| Saída do graph-mapping | 30 linhas |

# Checagem final
Cortar a primeira e a última frase de cada resposta; se nada se perdeu, deixar cortado.
