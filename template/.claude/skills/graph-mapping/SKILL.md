---
name: graph-mapping
description: Mapeia dependências e raio de impacto (quem chama/depende) antes de mudar código, no estilo Graphify. Usa o graphify se instalado; senão grep/analisadores.
---

# Objetivo
Responder, com evidência: **o que muda se eu mudar X?** Sem ler a árvore inteira.

# Passos
1. **Âncora**: símbolo/arquivo/rota alvo.
2. **Graphify (preferido, se `graphify` existir no PATH ou `graphify-out/`)**: consultar o grafo (AST local, arestas explicadas). Não instalar nada sem o usuário pedir. Não presumir que existe: `command -v graphify`.
3. **Fallback**, por camada:
   - C#: `grep -rn "NomeDoTipo" <backend-dir> --include=*.cs` (usos, `: IInterface`, registros DI em `AddScoped/AddTransient`), `Controllers/` p/ rota, handlers CAP/SignalR p/ eventos.
   - Dart: `grep -rn "import .*arquivo"` e `dart analyze` do pacote tocado; pasta de pacotes p/ achar o dono.
   - Rust: `grep` em a pasta dos crates, `cargo tree -i <crate>`.
   - Docs: `grep -rn "<termo>" docs/` (afirmação repetida = achar o dono do fato).
4. **Classificar** cada aresta: chamador direto · chamador transitivo (máx. 2 saltos) · teste · config/DI · contrato externo (app, vauedge, webhook).
5. **Marcar** o que cruza fronteira: módulo, tenant, backend↔frontend, submódulo.

# Saída (≤30 linhas)
```
ALVO: <símbolo>
DIRETOS: caminho:linha …
TRANSITIVOS: …
TESTES QUE COBREM: …
CONTRATO EXTERNO: sim/não (qual)
RISCO: baixo|médio|alto + motivo
NÃO VERIFICADO: …
```
# Regras
- Só reporta o que viu. Sem dependência dinâmica (reflection, DI por convenção) coberta → "não verificado".
- Parar quando o raio fechou; não varrer o repo por completeza.
- Descartar listagens brutas: guardar apenas a saída acima.
