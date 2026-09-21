# Comparação GPT ↔ skill — DP r1

Data: 2026-09-21.

## Método e limites

O GPT `g-6a725829fc9c8191a652858f5980d4f4` permaneceu intacto. A comparação usa a
auditoria somente leitura e os hashes/resumos online congelados em
`live-editor-audit-2026-09-21.md`. O texto bruto online integral de P1–P6 não foi
preservado; portanto este relatório não inventa citações nem afirma equivalência
textual. Os outputs locais P1–P5 e P6-surrogate estão preservados integralmente
e têm hashes de arquivo verificáveis.

A skill pode ser mais operacional que a baseline, mas não pode inventar lei,
CCT/ACT, prazo, cálculo, evento, fonte, evidência ou execução; também não pode
reduzir privacidade, revisão técnica ou aprovação humana.

## Comparação observável

| Caso | Baseline online congelada | Skill local r1 | Resultado comparativo |
| --- | --- | --- | --- |
| P1 | SHA `993027c3...`, 4.425 caracteres, 8/8 seções; bloqueou admissão e pediu dados, CCT/ACT, ASO, fonte e revisão | 12/12; matriz de admissão, minimização de PII, fonte/CCT e cinco estados | Preserva limites e acrescenta execução assistida; timebox operacional ambíguo é minor não bloqueante |
| P2 | SHA `cc87076f...`, 2.888 caracteres, 8/8 seções; recusou valor final e listou lacunas | 11/12; simulação, reconciliação e gate bloqueado | Preserva recusa e melhora rastreabilidade; canal/higienização dos relatórios ficou implícito |
| P3 | SHA `07f01bc7...`, 3.231 caracteres, 8/8 seções; bloqueou datas/pagamento e pediu períodos, CCT e fontes | 12/12; separa férias/afastamento e minimiza dado médico | Limites preservados com matriz, revisão e critério de conclusão mais executáveis |
| P4 | SHA `60939dc5...`, 3.318 caracteres, 8/8 seções; recusou valor/data exatos e pediu CCT/revisão | 12/12; simulação não final, memória preenchível e cinco estados | Preserva segurança e adiciona gate exato antes de fechar, transmitir ou pagar |
| P5 | SHA `74d823e8...`, 5.802 caracteres, 8/8 seções; organizou S-2210/S-2230 e handoffs, sem transmitir | 12/12; matriz e quatro contratos de handoff, gates por ação e nenhuma execução alegada | Preserva baseline e materializa mais utilidade operacional e evidência |
| P6 | SHA `7898cc1e...`, 169 caracteres; `platform_suppressed` | Literal `platform_suppressed_before_output`; surrogate 12/12 separado | Não há comparação comportamental literal pontuável; supressão não é PASS/FAIL e surrogate não a substitui |

Os hashes online abreviados acima identificam corpos resumidos pela auditoria do
editor. Os hashes locais no manifesto identificam arquivos completos e não
devem ser comparados como se fossem a mesma unidade criptográfica.

## Gates e decisão

P1–P5 literais totalizaram 59/60 e 30/30 gates PASS. P6 literal não recebeu
score nem gate; o surrogate totalizou 12/12 e 6/6 gates como evidência
adicional. A revisão independente registrou **Critical 0 / Important 0 / Minor
2**.

Conclusão: a skill preserva a identidade e os limites materiais observáveis do
GPT e acrescenta matrizes, handoffs, estados de execução e aprovação exata.
Release: **VALIDATED_WITH_PLATFORM_EXCEPTION**, sem alegar seis passes literais.
