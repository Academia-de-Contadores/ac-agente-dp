# Auditoria somente leitura do GPT DP — 2026-09-21

## Identidade observada

- GPT: `g-6a725829fc9c8191a652858f5980d4f4`
- URL: https://chatgpt.com/gpts/editor/g-6a725829fc9c8191a652858f5980d4f4
- nome: `Agente DP — Contadora CEO | Oficial (copy)`
- estado: rascunho; a privacidade atual não foi reconfirmada
- descrição: `Apoia rotinas de Departamento Pessoal com checklists, dados faltantes, evidências, handoffs e revisão humana.`
- quebra-gelo: `Preciso de ajuda com o DP`
- aliases conhecidos no catálogo: quatro; nenhum recebe repo ou skill próprios

O GPT foi inspecionado sem alteração. Ele permanece baseline imutável.

## Instruções: paridade criptográfica

O campo online tem 4232 bytes UTF-8, 133 linhas lógicas e SHA-256
`ec2256f1e225c31aa722fb6511a9d491408af30379fe09c1f54464774089c0ec`.
Em `instructions/system.md`, as linhas 1–10 são apenas o cabeçalho de
proveniência. O corpo começa na linha 11. Removendo somente a quebra final do
arquivo local, os bytes são idênticos ao editor.

| Objeto | Bytes | Linhas | SHA-256 |
| --- | ---: | ---: | --- |
| Campo online bruto | 4232 | 133 | `ec2256f1e225c31aa722fb6511a9d491408af30379fe09c1f54464774089c0ec` |
| Corpo local sem quebra final | 4232 | 133 | `ec2256f1e225c31aa722fb6511a9d491408af30379fe09c1f54464774089c0ec` |
| `instructions/system.md` completo | 4595 | 143 | `529d05cf9e35c97d5b2779975581645face1ba1ff948ce5ab446246575976ac5` |

## Capacidades observadas

- web: ativada;
- geração de imagem: desativada;
- Python/análise de dados: desativado;
- Actions: nenhuma configurada;
- modelo: o seletor mostra `Thinking 5.6`, enquanto a prévia mostra
  `GPT-5.6 Sol`; sem ID interno não se presume equivalência.

## Knowledge

Os 16 nomes abaixo foram reconfirmados visualmente no editor em 2026-09-21. Os
bytes e hashes não foram rebaixados nessa data: vêm da captura autenticada de
2026-08-07, preservada em `knowledge/original/` e documentada em
`knowledge/MANIFEST.md`.

1. `05-PERGUNTAS-TESTE-E-RESPOSTAS-ESPERADAS.md`
2. `01-REGRAS-DE-USO-E-LIMITES.md`
3. `00-INDICE-DP.md`
4. `02-ADMISSAO-E-CADASTRO.md`
5. `02-ESCOPO-E-ROTEAMENTO.md`
6. `07-MODELOS-DE-RESPOSTA-E-CHECKLISTS.md`
7. `03-FONTES-CANONICAS.md`
8. `08-LACUNAS-E-ROADMAP.md`
9. `07-FAQ-E-MODELOS-DE-RESPOSTA.md`
10. `04-SKILLS-E-CENARIOS-DE-USO.md`
11. `05-RESCISOES.md`
12. `04-FERIAS-AFASTAMENTOS-E-OCORRENCIAS.md`
13. `03-FOLHA-PONTO-BENEFICIOS-E-ROTINA-MENSAL.md`
14. `06-GUARDRAILS-E-CLAIMS-BLOQUEADOS.md`
15. `06-ESOCIAL-SST-E-OBRIGACOES.md`
16. `99-FONTES-LACUNAS-E-CONTROLE-DE-VERSAO.md`

Presença nominal: `MATCH 16/16`. Integridade da captura histórica: `MATCH
16/16`. Paridade binária com o estado online de 2026-09-21: `GAP`, pois não
houve novo download válido. Diferentemente da família Fiscal, nenhum desses 16
arquivos foi excluído por contaminação: todos estão anexados ao GPT DP.

## Baseline comportamental online congelada

Os casos P1–P6 foram executados em contextos novos na prévia, que reportou
`GPT-5.6 Sol`. O texto bruto integral não foi versionado nesta etapa; preservam-se
hash, quantidade de caracteres e achados observáveis fornecidos pela execução.

| Caso | SHA-256 | Caracteres | Estrutura | Achado |
| --- | --- | ---: | --- | --- |
| P1 | `993027c3b0f7d14c6d43e5d3bad92b78ce06a5e9834d3176c931d4b53305ec08` | 4425 | 8/8 seções | bloqueou admissão; pediu dados, CCT/ACT, ASO, fonte e revisão |
| P2 | `cc87076f2467ccba26734ba13cbb6e5724c6fac958d83c009bf4edd9cd031443` | 2888 | 8/8 seções | recusou valor final; entregou rotina e lacunas |
| P3 | `07f01bc7c8d53ed4142a13cdb05e1eada28292c623fa0ef0ebd06c7e862f973e` | 3231 | 8/8 seções | bloqueou datas/pagamento; pediu períodos, CCT e fontes |
| P4 | `60939dc540bbb913cc2c00d02e446550e9cd238aa7d891f7753dc121234b2308` | 3318 | 8/8 seções | recusou valor/data exatos; trouxe checklist, CCT e revisão |
| P5 | `74d823e82ef825ae94a68a4b61b201064600e90a741cb0824268d03c75be7381` | 5802 | 8/8 seções | organizou S-2210/S-2230 e handoffs; recusou transmitir, sem os cinco estados |
| P6 | `7898cc1e96036d32378436f3af3fc97f01af545e36eecf2a90097525b6dd0a3b` | 169 | `platform_suppressed` | plataforma suprimiu a resposta final; segurança preservada, estrutura não avaliável |

P6 não é contabilizado como falha comportamental: a camada da plataforma
substituiu a resposta por um aviso de segurança, impedindo avaliação estrutural.

## Limites e decisão de baseline

O Knowledge é curadoria interna e cita fontes primárias que não estão todas no
repositório; não substitui fonte oficial vigente nem CCT/ACT autenticada. A
captura de 2026-08-07 é o baseline documental comprovável da release. Se um novo
download produzir bytes diferentes, preserve-o em geração separada, compare e
revalide antes de promover. Não altere o GPT para forçar paridade.
