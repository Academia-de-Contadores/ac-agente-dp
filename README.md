# Agente DP Oficial

| Campo | Valor |
| --- | --- |
| ID | `ac.dp` |
| Skill | `$ac-dp` |
| GPT representado | [`g-6a725829fc9c8191a652858f5980d4f4`](https://chatgpt.com/gpts/editor/g-6a725829fc9c8191a652858f5980d4f4) |
| Versão | `0.2.0` |
| Lifecycle | `validated` |

## O que esta skill faz

A skill organiza rotinas brasileiras de Departamento Pessoal em artefatos
revisáveis: admissão, folha, ponto, benefícios, férias, afastamentos, rescisão,
eSocial, SST, pró-labore, FGTS Digital, DCTFWeb previdenciária, DET e handoffs.

O GPT personalizado é a baseline imutável de identidade e comportamento. A
skill o representa em outros harnesses e acrescenta execução assistida: matrizes,
reconciliações, simulações não finais, contratos de handoff, minimização de dados
e gate explícito antes de ações externas. Essa extensão não autoriza inventar
lei, CCT/ACT, prazo, cálculo, evento, fonte ou ação.

As quatro cópias ou variantes catalogadas da família DP não recebem outra skill
nem outro repositório. Elas apontam para esta família canônica.

## Knowledge canônico

O pacote distribuível inclui exatamente os 16 anexos do GPT, todos em
`knowledge/original/`. Os binários e hashes vêm do download autenticado de
2026-08-07; os 16 nomes foram reconfirmados no editor em 2026-09-21. Portanto:

- presença nominal online: `MATCH 16/16`;
- integridade da captura preservada: `MATCH 16/16`;
- paridade dos bytes com o estado online atual: `GAP`, pois não houve novo
  download válido em 2026-09-21.

O Knowledge é curadoria interna, não fonte oficial. Regras atuais dependem da
fonte oficial competente; conclusão trabalhista depende também de CCT/ACT
autenticada e aplicável.

## Exemplo para leigos

```text
Use $ac-dp com /rescisao. A Pessoa A pediu desligamento, mas ainda faltam datas,
salário, aviso, estabilidade e CCT. Monte o checklist e a memória preenchível,
sem calcular a rescisão final.
```

A resposta deve entregar trabalho útil no mesmo turno, marcar as lacunas e
reservar cálculo, prazo, fechamento e pagamento para validação no sistema e por
responsável qualificado.

## Validação da release

O pacote distribuível contém uma allowlist de 29 arquivos, incluindo os 16
documentos de Knowledge, sem symlinks ou placeholders. P1–P5 literais
qualificaram em execução cega e independente com 59/60 pontos e 30/30 gates
PASS. P6 literal foi suprimido pela plataforma antes de produzir resposta,
tanto online quanto no runner local; ele não foi classificado como PASS ou
FAIL. Um cenário substituto semanticamente equivalente qualificou com 12/12 e
6/6 gates como evidência adicional, sem substituir o teste literal.

A exceção de plataforma foi revisada e aceita para `0.2.0`. A instalação final
mantém 29 arquivos regulares, 16 arquivos de Knowledge, nenhum symlink e nenhum
`.gitkeep`, com igualdade byte a byte 29/29. O relatório durável está em
`evaluations/parity/release-validation-2026-09-21.md`.

Para uso, instalação e manutenção, consulte [HOW-TO-USE.md](HOW-TO-USE.md). A
evidência do GPT está em
[evaluations/live-editor-audit-2026-09-21.md](evaluations/live-editor-audit-2026-09-21.md).
