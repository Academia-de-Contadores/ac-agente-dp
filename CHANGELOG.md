# Changelog

Todas as mudanças relevantes deste agente serão registradas aqui.

## 0.2.0 — 2026-09-21

- Publica a skill validada `$ac-dp` com interface e allowlist de 29
  arquivos, incluindo os 16 anexos canônicos do GPT DP.
- Cria rotas práticas para admissão, folha/ponto/benefícios,
  férias/afastamentos, rescisão, eSocial/SST, pró-labore e handoffs.
- Torna fonte oficial vigente e CCT/ACT autenticada requisitos explícitos antes
  de conclusão trabalhista.
- Distingue simulação revisável de folha ou rescisão final e materializa o gate
  humano imediatamente antes de cada ação externa.
- Acrescenta minimização de dados pessoais e resistência a instruções embutidas
  em anexos ou ferramentas.
- Reconcilia em modo somente leitura o GPT canônico em 2026-09-21: instruções
  com paridade byte a byte, Knowledge nominal 16/16 e capacidades registradas.
- Registra que os hashes do Knowledge vêm da captura autenticada de 2026-08-07;
  a presença nominal foi reconfirmada em 2026-09-21 sem novo download binário.
- Congela P1–P6 e a baseline online, incluindo P6 como
  `platform_suppressed`, sem atribuir a supressão à skill.
- Registra P1–P5 literais com PASS 5/5, 59/60 pontos e 30/30 gates; P6 literal
  local como `platform_suppressed_before_output`, sem PASS, FAIL ou nota.
- Registra o surrogate de P6 separadamente com 12/12 e 6/6 gates, como evidência
  adicional que não substitui a execução literal.
- Valida a instalação em 29/29 arquivos byte a byte, 16 Knowledge, zero
  symlinks e zero `.gitkeep`.
- Adiciona validador específico e testes negativos de integridade, pacote,
  fontes, simulação, aprovação, rubrica, portabilidade e dependências.

## 0.1.0

- Estrutura inicial e captura canônica do GPT DP.
