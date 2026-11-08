---
name: test-mutation-audit
description: Audita se testes e gates realmente reprovam: perturba o comportamento e confere se alguma asserção falha; procura falsos verdes e gate que passa sem relatório. Use em suíte suspeita, CI, ou teste novo de bug.
---
# Pergunta
Este teste/gate **falha** quando o código está errado? Verde sem poder ficar vermelho não verifica nada.

# Passos
1. **Baseline fixo**: SHA, comando exato, toolchain, host, testes selecionados. Run antigo vale só para o seu SHA.
2. **Rastrear o que executa de fato**: gatilhos, seleção de testes, scripts, geração de dados. Conferir os dois lados: teste obrigatório é descoberto **uma vez**; teste ausente ou relatório ausente **não pode** ficar verde.
3. **Perturbar** (em cópia/branch descartável, restaurar depois): inverter condição, remover um `if`, retornar valor errado, injetar falha de I/O. A suíte tem de reprovar. Se não reprovou → falso verde.
4. **Falsos verdes típicos**: asserção que repete o mock · fixture velha que quebra antes do comportamento testado · subprocesso/checker com erro engolido · teste que nunca roda (skip silencioso, `Skipped` > 0) · asserção sem `await`.
5. **Fixtures**: conferir contra contrato/protocolo/versão atuais; varrer a família inteira de fixtures; manter as malformadas de propósito.
6. **Eficiência sem perder o gate**: remover preparação duplicada/reusar setup imutável antes de reduzir cobertura; preservar caso de cancelamento, falha de limpeza, permissão, capacidade, identidade e concorrência. Teste ao vivo não vem de cache.

# Classificar (`evidence-report`)
Defeito reproduzido · custo suportado · hipótese · evidência indisponível. Falha na `main` pode ser pré-existente; atribuir pelo SHA executado e baseline limpo. Repetir só para testar uma causa específica; manter a falha original.

# Proibido
Suprimir falha, retry cego, subir timeout ou apagar asserção distinta só para ficar verde. Mutação fora de cópia descartável. Mudar o gate sem demonstrar que ele ainda detecta falha.

# Saída (≤15 linhas)
`ALVO | MUTAÇÃO | REPROVOU? | CONSEQUÊNCIA | CORREÇÃO`. Backend: confirmar "Skipped: 0".
