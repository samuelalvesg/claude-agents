---
name: evidence-report
description: Formato de relatório com evidência honesta: separa observado, derivado, inferido e desconhecido, declara cobertura e limites. Use em todo relatório de agente (review, QA, segurança, banco, debug, auditoria).
---
# Regra
Todo achado diz **como se sabe**. Nunca afirmar execução, medição ou leitura que não aconteceu nesta sessão.

# Níveis (marcar cada afirmação)
| Nível | Significa | Exemplo |
|---|---|---|
| **OBSERVADO** | vi/rodei nesta sessão | `dotnet test` → 612 passou, 0 pulou |
| **DERIVADO** | consequência direta do observado | o índice não é usado (plano mostra `Seq Scan`) |
| **INFERIDO** | hipótese razoável, não provada | provável N+1 pelo padrão do loop |
| **DESCONHECIDO** | não verificado / sem dado | cobertura do módulo X: não verificado |

# Classificar achados
`DEFEITO REPRODUZIDO` (passos + saída) · `LIMITAÇÃO SUPORTADA` (existe, é aceita) · `OPORTUNIDADE DE DESIGN` · `HIPÓTESE` · `EVIDÊNCIA INDISPONÍVEL`. Só o primeiro vale como bug.

# Cobertura
- Dizer **o que foi examinado** (arquivos, rotas, cenários, janela de tempo). "Nada encontrado" só prova ausência **dentro desse escopo**.
- Resultado parcial é parcial: retornar o que se tem + o que falta; nunca "sucesso" com lacuna escondida.
- Erro com razão útil e próximo passo, não só "falhou".

# Campos mínimos
`ACHADO | NÍVEL | EVIDÊNCIA (arquivo:linha ou comando+saída) | COBERTURA | LIMITE/NÃO VERIFICADO | AÇÃO`
Faltando dado: escrever `SEM DADO SUFICIENTE: <o que falta>` e perguntar; não preencher por palavra.

# Proibido
Atestar revisão humana em nome do usuário · dizer "testado" sem comando e saída · repetir fato de outro `.md` sem reconferir (regra de documentação do `AGENTS.md`, se houver) · duplicar o mesmo problema com palavras diferentes: **agrupar por causa-raiz**.
