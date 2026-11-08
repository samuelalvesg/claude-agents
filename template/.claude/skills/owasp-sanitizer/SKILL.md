---
name: owasp-sanitizer
description: Checklist OWASP Top 10 (2021) para C#/Dart/Rust: validação e sanitização de entrada, SQLi/XSS, segredos, auditoria de dependências. Use em auditoria de segurança de diff ou módulo.
---

# Princípio
Validar na **borda** (allow-list), codificar na **saída** (por contexto), parametrizar sempre. Nunca confiar em cliente, header, nome de arquivo, tenant id vindo do request.

# Checklist
| # | Verificar | Como (comando/ação) |
|---|---|---|
| A01 Acesso | Todo Controller novo tem `[Authorize]`/política; tenant vem do token, não do body; IDOR: recurso pertence ao tenant/usuário | `grep -rn "class .*Controller" <backend-dir>` ; conferir atributo e filtro de tenant |
| A02 Cripto | Sem MD5/SHA1 para senha; hash de senha forte; segredo/chave fora do código; TLS | `grep -rniE "md5|sha1|DES|ECB" <backend-dir>` |
| A03 Injeção | SQL só parametrizado/LINQ; sem `FromSqlRaw($"...")`/concatenação; sem `Process.Start` com entrada; sem `Path.Combine` com nome do usuário sem normalizar | `grep -rnE "FromSqlRaw|ExecuteSqlRaw|string\.Format.*SELECT|\+ .*WHERE" <backend-dir>` |
| A03 XSS | Saída HTML/e-mail codificada; Flutter Web: sem `innerHTML`/`HtmlElementView` com dado não confiável | `grep -rnE "innerHTML|dangerouslySet|HtmlElementView" <frontend-dir>` |
| A04 Design | Limites: tamanho de payload, upload (tipo por conteúdo, não extensão; zip bomb), rate limit, paginação | conferir limites de payload/upload no registro de auditorias do projeto |
| A05 Config | Sem debug/stack trace em produção; CORS não `*` com credenciais; headers; secrets só por env (12-Factor III) | ler `Program.cs`, `appsettings*.json` (sem imprimir valores) |
| A06 Componentes | Dependência vulnerável/abandonada | `dotnet list <solution>.sln package --vulnerable --include-transitive` ; `cd <frontend-dir> && dart pub outdated` ; `cargo audit` (se instalado: `command -v cargo-audit`) |
| A07 Autenticação | Sem credencial hardcoded; expiração/refresh; lockout; comparação em tempo constante | `grep -rniE "password\s*=\s*\"|apikey|secret\s*=\s*\"" --include=*.cs --include=*.dart --include=*.rs .` |
| A08 Integridade | Webhook com assinatura verificada; desserialização só de tipos esperados (sem `TypeNameHandling`) | `grep -rn "TypeNameHandling\|BinaryFormatter" <backend-dir>` |
| A09 Log | Sem segredo/PII/token em log; eventos de authz negada registrados | revisar chamadas `ILogger` do diff |
| A10 SSRF | URL fornecida pelo usuário: allow-list de host, bloquear IP interno/metadata | `grep -rn "HttpClient" <backend-dir>` + origem da URL |

# Sanitização (regra de bolso)
- Entrada: tipo → tamanho → formato → allow-list → só então usar. Rejeitar > "limpar".
- SQL: `@param`/LINQ. Identificador dinâmico (coluna/ordem): mapa fixo allow-list.
- Saída: codificar pelo contexto (HTML, atributo, JS, URL). Texto do usuário na IA: tratar como dado, não instrução (prompt injection).
- Erro: mensagem genérica ao cliente, detalhe só em log (sem segredo).

# Segredo vazado
Parar; não imprimir o valor; reportar `arquivo:linha` + tipo; recomendar rotação ao usuário. Não reescrever histórico git.

# Saída (≤25 linhas)
`ID | sev (Crítica/Alta/Média/Baixa) | arquivo:linha | vetor entrada→sink | correção`. Sem achado: listar quais A0x foram checados e o que ficou "não verificado".
